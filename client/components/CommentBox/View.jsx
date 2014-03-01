/** @jsx React.DOM */
define(function(require){
  var Comment = require('models/Comment');
  var Rating = require('components/Rating/View');

  var CommentBox = React.createClass({
    getInitialState: function() {
      return {text: ''};
    },

    create: function() {
      var newComment = Comment({
        to: this.props.user._id(),
        text: this.state.text
      });
      newComment.save(function(err, mod){
        if (err) console.log(err);
      });
      this.setState({text: ''});
    },

    handleTextChange: function(event) {
      this.setState({
        text: event.target.value.substr(0, 140)
      });
    },

    render: function() {
      return this.transferPropsTo(
        <form className='comment-box ui reply form'>
          <div className='field'>
            <label>How would you rate this user?</label>
            <Rating write={true}/>
          </div>
          <div className='field'>
            <label>How would you describe your experience?</label>
            <textarea value={this.state.text} onChange={this.handleTextChange}/>
          </div>
          <div className='ui fluid button teal submit labeled icon' onClick={this.create}>
            <i className='icon edit'/> Add Comment
          </div>
        </form>
      );
    }
  });

  return CommentBox;
});
