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
        label: true
      });

      var likeText = this.state.liked ? 'You like this' : 'Click to like this';

      return this.transferPropsTo(
        <div className='profile-card item' key={this.props.username()}>
          <a className='image' href={'/people/'+this.props.username()}>
            <ProfilePic username={this.props.username()} />
            <a className={likeClasses} onClick={this.like}>
              <i className='like icon' title={likeText}/>
            </a>
          </a>
          <div className='content'>
            <div className='name'>{this.props.name()}</div>
            <p className='description'>Wow such a great person</p>
          </div>
        </div>
      );
    }
  });

  return ProfileCard;
});