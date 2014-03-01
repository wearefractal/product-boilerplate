/** @jsx React.DOM */
define(function(require){
  var ProfilePic = require('components/ProfilePic/View');
  var LogoutButton = require('components/LogoutButton/View');

  var MenuAvatar = React.createClass({
    render: function() {
      var user = this.props.user;
      return this.transferPropsTo(
        <div className='menu-avatar ui pointing top right simple dropdown item'>
          <ProfilePic className='ui avatar image' username={user.username()||user.fbid()} size='small' />
          <i className='dropdown icon'/>
          <div className='menu'>
            <a className='item'>
              <i className='user icon'/>
              Edit Profile
            </a>
            <a className='item'>
              <i className='settings icon'/>
              Change Settings
            </a>
            <LogoutButton/>
          </div>
        </div>
      );
    }
  });

  return MenuAvatar;
});
