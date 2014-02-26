/** @jsx React.DOM */
define(function(require){
  
  var LoginButton = React.createClass({
    click: function() {
      window.location.href = "/auth/facebook";
    },
    render: function() {
      return this.transferPropsTo(
        <div className='item'>
          <button className='ui teal button login-button' onClick={this.click}>Login</button>
        </div>
      );
    }
  });

  return LoginButton;
});