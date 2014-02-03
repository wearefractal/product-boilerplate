/** @jsx React.DOM */
define(function(require){
  var Container = React.createClass({
    render: function() {
      return (
        <div className='ui segment'>
          {this.props.children}
        </div>
      );
    }
  });

  return Container;
});