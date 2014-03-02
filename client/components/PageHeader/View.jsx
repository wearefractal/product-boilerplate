/** @jsx React.DOM */
define(function(require){

  var cx = React.addons.classSet;

  var PageHeader = React.createClass({
    render: function() {
      var iconClasses = cx({
        large: true,
        icon: true
      });
      iconClasses += " "+this.props.icon;

      return this.transferPropsTo(
        <div className='ui segment'>
          <h2 className='ui header page-header'>
            <i className={iconClasses}/>
            <div className='content'>
              {this.props.title}
              <div className='sub header'>{this.props.description}</div>
            </div>
          </h2>
        </div>
      );
    }
  });

  return PageHeader;
});
