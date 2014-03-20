/** @jsx React.DOM */
define(function(require){
  var ProfilePic = React.createClass({
    getDefaultProps: function() {
      return {
        size: 'large'
      };
    },

    render: function() {
      return this.transferPropsTo(
        <img src={'http://graph.facebook.com/'+this.props.user.prettyName()+'/picture?type='+this.props.size} />
      );
    }
  });
  return ProfilePic;
});
