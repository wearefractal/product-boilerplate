(function () {
  window.nestModel = function (model) {

    model.on('construct', function (instance, props) {
      for (var prop in model.attrs)
        nest(prop, instance, props[prop]);
    });

    function nest(prop, instance, val) {
      var submodel = model.attrs[prop];

      if (!model.attrs[prop] || 'function' !== typeof model.attrs[prop] || !model.attrs[prop].modelName) return;

      var sub = new submodel(val);

      sub.on('change', function (name, val, prev) {
        var ns = getRootPath(name, sub),
          root = ns[0],
          path = ns[1];

        root.model.emit('change ' + path, root, val, prev);
        root.emit('change ' + path, val, prev);
      });

      instance[prop] = sub;
      instance.attrs[prop] = sub.attrs;
      sub._parent = [prop, instance];
    }

  };

  function getRootPath(name, instance) {
    var keys = [name];
    while (instance && instance._parent) {
      keys.unshift(instance._parent[0]);
      instance = instance._parent[1];
    }
    return [instance, keys.join('.')];
  }
})();