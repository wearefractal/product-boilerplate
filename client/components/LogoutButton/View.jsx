/** @jsx React.DOM */
define(function(require){
  var auth = require('app/auth');

  var LogoutButton = React.createClass({
    click: function() {
      window.location.href = "/logout";
    },
    render: function() {
      return (
        <div className='item'>
          <button className='ui orange button' onClick={this.click}>Logout</button>
        </div>
      );
    }
  });

  return LogoutButton;
});