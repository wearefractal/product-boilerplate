/** @jsx React.DOM */
define(function(require){

  var cx = React.addons.classSet;
  var ProfilePic = require('components/ProfilePic/View');

  var ProfileCard = React.createClass({
    getDefaultProps: function () {
      return {};
    },

    render: function() {
      var id = this.props.username() || this.props.fbid();
      return this.transferPropsTo(
        <div className='profile-card item' key={this.props.fbid()}>
          <a className='image' href={'/people/'+id}>
            <ProfilePic username={id} />
          </a>
          <div className='content'>
            <div className='name'>{this.props.name()}</div>
            <p className='description'>
              <i className='map marker icon'/>
              {this.props.location()}
            </p>
          </div>
        </div>
      );
    }
  });

  return ProfileCard;
});
