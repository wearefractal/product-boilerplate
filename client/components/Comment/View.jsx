/** @jsx React.DOM */
define(function(require){
  var ProfilePic = require('components/ProfilePic/View');
  var Rating = require('components/Rating/View');

  var Comment = React.createClass({
    getDefaultProps: function () {
      return {};
    },

    render: function() {
      var id = this.props.from.username() || this.props.from.fbid();
      return this.transferPropsTo(
        <div className='comment' key={this.props._id()}>
            <a className='avatar' href={'/people/'+id}>
              <ProfilePic username={id}/>
            </a>
            <div className='content'>
              <a className='author'>{this.props.from.name()}</a>
              <div className='metadata'>
                <div className='date'>{moment(this.props.created()).fromNow()}</div>
                <Rating rating={this.props.rating()}/>
              </div>
              <div className='text'>{this.props.text()}</div>
              <div className='actions'>
                <a className='delete'>Delete</a>
              </div>
            </div>
          </div>
      );
    }
  });

  return Comment;
});
