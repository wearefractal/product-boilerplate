/** @jsx React.DOM */
define(function(require){
  var auth = require('app/auth');
  
  var LoginButton = React.createClass({
    click: function() {
      auth.login();
    },
    render: function() {
      return (
        <div className='item'>
          <button className='ui teal button' onClick={this.click}>Login</button>
        </div>
      );
    }
  });

  return LoginButton;
});