/** @jsx React.DOM */
define(function(require){
  var ProfilePic = require('components/ProfilePic/View');

  var Comment = React.createClass({
    getDefaultProps: function () {
      return {};
    },

    render: function() {
      return this.transferPropsTo(
        <div className='comment'>
            <a className='avatar'>
              <ProfilePic username={this.props.from.username()}/>
            </a>
            <div className='content'>
              <a className='author'>{this.props.from.name()}</a>
              <div className='metadata'>
                <div className='date'>{moment(this.props.created()).fromNow()}</div>
                <div className='stars'>
                  <i className='icon star'/>
                  <i className='icon star'/>
                  <i className='icon star'/>
                  <i className='icon empty star'/>
                  <i className='icon empty star'/>
                </div>
              </div>
              <div className='text'>{this.props.text()}</div>
              <div className='actions'>
                <a className='reply'>Reply</a>
                <a className='delete'>Delete</a>
              </div>
            </div>
          </div>
      );
    }
  });

  return Comment;
});