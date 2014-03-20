/** @jsx React.DOM */
define(function(require){
  var me = require('app/auth');
  var Comment = require('models/Comment');

  var LoginButton = require('components/LoginButton/View');
  var CommentBox = require('components/CommentBox/View');
  var CommentView = require('components/Comment/View');

  var UserComments = React.createClass({
    getDefaultProps: function () {
      return {};
    },

    getInitialState: function() {
      return {
        commented: false,
        comments: {
          models: []
        }
      };
    },

    componentWillMount: function () {
      Comment.getByTo(this.props.user._id(), function(err, comments){
        this.setState({comments: comments});
      }.bind(this));
    },

    onSubmitComment: function (comment) {
      // add to page
      this.state.comments.models.unshift(comment);

      this.setState({
        comments: this.state.comments,
        commented: true
      });
    },

    render: function() {
      var comments = this.state.comments.models.map(CommentView);

      return this.transferPropsTo(
        <div className='ui comments'>
          <div className='ui segment'>
            {comments.length > 0 ? comments : <h3>No comments</h3>}
          </div>

          {(me && !this.state.commented) ? <div className='ui segment'><CommentBox user={this.props.user} onSubmit={this.onSubmitComment}/></div> : ''}
        </div>
      );
    }
  });

  return UserComments;
});
