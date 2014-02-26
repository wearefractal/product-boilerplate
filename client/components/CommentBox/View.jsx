/** @jsx React.DOM */
define(function(require){
  var CommentBox = React.createClass({
    render: function() {
      return this.transferPropsTo(
        <form className='comment-box ui reply form'>
          <div className='field'>
            <textarea/>
          </div>
          <div className='ui button teal submit labeled icon'>
            <i className='icon edit'/> Add Comment
          </div>
        </form>
      );
    }
  });

  return CommentBox;
});