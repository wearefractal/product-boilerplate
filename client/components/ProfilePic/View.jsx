/** @jsx React.DOM */
define(function(require){
  var ProfilePic = React.createClass({
    render: function() {
      return (
        <img src={'http://graph.facebook.com/' + this.props.username + '/picture?type=large'} />
      );
    }
  });
  return ProfilePic;
});