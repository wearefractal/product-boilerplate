/** @jsx React.DOM */
define(function(require){
  var app = require('app/sugar');
  var me = require('app/auth');

  var LoginButton = require('components/LoginButton/View');
  var MenuAvatar = require('components/MenuAvatar/View');

  var Navbar = React.createClass({
    getInitialState: function() {
      return {
        path: window.location.pathname
      };
    },

    componentWillMount: function() {
      app.router.callbacks.unshift(this.handleRoute);
    },

    componentWillUnmount: function() {
      var idx = app.router.callbacks.indexOf(this.handleRoute);
      app.router.callbacks.splice(idx, 1);
    },

    handleRoute: function(ctx, next) {
      this.setState({path:ctx.path});
      next();
    },

    render: function() {
      var items = [
        {
          path: "/",
          name: "Home"
        },
        {
          path: "/people",
          name: "People",
          match: /\/people\/?(.*)?/
        }
      ];

      var links = items.map(function(item){
        var classes = 'main item';
        var exactMatch = item.path === this.state.path;
        var regMatch = item.match && item.match.test(this.state.path);

        if (exactMatch || regMatch) {
          classes += ' active'
        }
        return (<a className={classes} key={item.path} href={item.path}>
          {item.name}
        </a>);
      }, this);

      return (
        <nav className='ui menu'>
          {links}
          <div className='right menu'>
            <div className='item'>
              <div className='ui icon input'>
                <input type='text' />
                <i className='search link icon'/>
              </div>
            </div>
            {me ? <MenuAvatar user={me}/> : <LoginButton />}
          </div>
        </nav>
      );

    }
  });

  return Navbar;
});