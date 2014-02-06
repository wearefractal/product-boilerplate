/** @jsx React.DOM */
define(function(require){
  var LogoutButton = React.createClass({
    click: function() {
      window.location.href = "/logout";
    },
    render: function() {
      return this.transferPropsTo(
        <div className='item'>
          <button className='fluid ui orange button' onClick={this.click}>Logout</button>
        </div>
      );
    }
  });

  return LogoutButton;
});