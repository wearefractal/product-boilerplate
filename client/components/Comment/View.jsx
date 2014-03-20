/** @jsx React.DOM */
define(function(require){
  var ProfilePic = require('components/ProfilePic/View');
  var Rating = require('components/Rating/View');
  var me = require('app/auth');

  var Comment = React.createClass({
    getDefaultProps: function () {
      return {};
    },

    render: function() {
      var owner = (me && me._id() === this.props.from._id());

      return this.transferPropsTo(
        <div className='comment' key={this.props._id()}>
            <a className='avatar' href={'/people/'+this.props.from.prettyName()}>
              <ProfilePic user={this.props.from}/>
            </a>
            <div className='content'>
              <a className='author'>{this.props.from.name()}</a>
              <div className='metadata'>
                <div className='date'>{moment(this.props.created()).fromNow()}</div>
                <Rating rating={this.props.rating()}/>
              </div>
              <div className='text'>{this.props.text()}</div>
              <div className='actions'>
                <a className='delete'>{(owner ? 'Delete' : 'Report')}</a>
              </div>
            </div>
          </div>
      );
    }
  });

  return Comment;
});
