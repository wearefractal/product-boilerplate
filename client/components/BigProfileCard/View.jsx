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
        active: this.state.liked,
        like: true,
        ui: true,
        corner: true,
        label: true,
        left: true
      });

      var likeText = this.state.liked ? 'You like this' : 'Click to like this';

      return this.transferPropsTo(
        <div className='big-profile-card ui segment' key={this.props.user.username()}>
          <div className='ui left floated image'>
            <ProfilePic username={this.props.user.username()} />
            <a className={likeClasses} onClick={this.like}>
              <i className='like icon' title={likeText}/>
            </a>
          </div>

          <div className='info'>
            <h2 className='name'>{this.props.user.name()}</h2>
            <p className='description'>Wow such a great person</p>
          </div>
        </div>
      );
    }
  });

  return ProfileCard;
});