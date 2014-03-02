/** @jsx React.DOM */
define(function(require){

  var cx = React.addons.classSet;
  var ProfilePic = require('components/ProfilePic/View');

  var ProfileCard = React.createClass({
    getDefaultProps: function () {
      return {};
    },

    render: function() {
      var id = this.props.user.username() || this.props.user.fbid();

      return this.transferPropsTo(
        <div className='big-profile-card ui segment' key={this.props.user.fbid()}>
          <div className='ui left floated image'>
            <ProfilePic username={id} />
          </div>

          <div className='info'>
            <h2 className='name'>{this.props.user.name()}</h2>
            <p className='description'>
              <i className='map marker icon'/>
              {this.props.user.location()}
            </p>
          </div>
        </div>
      );
    }
  });

  return ProfileCard;
});
