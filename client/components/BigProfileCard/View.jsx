/** @jsx React.DOM */
define(function(require){

  var cx = React.addons.classSet;
  var ProfilePic = require('components/ProfilePic/View');

  var ProfileCard = React.createClass({
    getDefaultProps: function () {
      return {};
    },

    getInitialState: function() {
      return {
        liked: false
      };
    },

    like: function() {
      this.setState({
        liked: !this.state.liked
      });
    },

    render: function() {
      var likeClasses = cx({
        red: this.state.liked,
        like: true,
        ui: true,
        corner: true,
        label: true,
        left: true
      });

      var likeText = this.state.liked ? 'You like this' : 'Click to like this';
      var id = this.props.user.username() || this.props.user.fbid();

      return this.transferPropsTo(
        <div className='big-profile-card ui segment' key={this.props.user.fbid()}>
          <div className='ui left floated image'>
            <ProfilePic username={id} />
            <a className={likeClasses} onClick={this.like}>
              <i className='like icon' title={likeText}/>
            </a>
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
