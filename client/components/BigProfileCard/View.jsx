/** @jsx React.DOM */
define(function(require){

  var cx = React.addons.classSet;
  var ProfilePic = require('components/ProfilePic/View');

  var ProfileCard = React.createClass({
    getDefaultProps: function () {
      return {};
    },

    render: function() {
      return this.transferPropsTo(
        <div className='big-profile-card ui segment' key={this.props.user._id()}>
          <div className='ui left floated image'>
            <ProfilePic user={this.props.user} />
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
