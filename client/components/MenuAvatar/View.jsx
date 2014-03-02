/** @jsx React.DOM */
define(function(require){
  var ProfilePic = require('components/ProfilePic/View');

  var MenuAvatar = React.createClass({
    logout: function() {
      window.location.href = '/logout';
    },

    render: function() {
      var user = this.props.user;
      return this.transferPropsTo(
        <div className='menu-avatar ui pointing top right simple dropdown item'>
          <ProfilePic className='ui avatar image' username={user.username()||user.fbid()} size='small' />
          <i className='dropdown icon'/>
          <div className='menu'>
            <a className='item' href='/me/edit'>
              <i className='user icon'/>
              Edit Profile
            </a>
            <a className='item' href='/me/'>
              <i className='settings icon'/>
              Change Settings
            </a>
            <a className='item' onClick={this.logout}>
              <i className='sign out icon'/>
              Logout
            </a>
          </div>
        </div>
      );
    }
  });

  return MenuAvatar;
});
