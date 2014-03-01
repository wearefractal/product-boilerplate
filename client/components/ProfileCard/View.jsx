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
      var id = this.props.username() || this.props.fbid();
      return this.transferPropsTo(
        <div className='profile-card item' key={this.props.fbid()}>
          <a className='image' href={'/people/'+id}>
            <ProfilePic username={id} />
            <a className={likeClasses} onClick={this.like}>
              <i className='like icon' title={likeText}/>
            </a>
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
