/** @jsx React.DOM */
define(function(require){
  var me = require('app/auth');
  var Comment = require('models/Comment');

  var LoginButton = require('components/LoginButton/View');
  var CommentBox = require('components/CommentBox/View');
  var CommentView = require('components/Comment/View');
  var Loader = require('components/Loader/View');

  var UserComments = React.createClass({
    getDefaultProps: function () {
      return {};
    },

    getInitialState: function() {
      return {
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


    render: function() {
      var comments = this.state.comments.models.map(CommentView);

      return this.transferPropsTo(
        <div className='ui comments'>
          <div className='ui segment'>
            {comments.length > 0 ? comments : <h3>No comments</h3>}
          </div>

          {me ? <div className='ui segment'><CommentBox user={this.props.user}/></div> : ''}
        </div>
      );
    }
  });

  return UserComments;
});