/** @jsx React.DOM */
define(function(require){

  var cx = React.addons.classSet;
  var ProfilePic = require('components/ProfilePic/View');

  var ProfileCard = React.createClass({
    render: function() {
      return this.transferPropsTo(
        <div className='profile-card item' key={this.props.user._id()}>
          <a className='image' href={'/people/'+this.props.user.prettyName()}>
            <ProfilePic user={this.props.user} />
          </a>
          <div className='content'>
            <div className='name'>{this.props.user.name()}</div>
            <p className='description'>{this.props.user.location()}</p>
          </div>
        </div>
      );
    }
  });

  return ProfileCard;
});
