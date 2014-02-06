/** @jsx React.DOM */
define(function(require){
  var Loader = React.createClass({
    render: function() {
      return this.transferPropsTo(
        <div className='ui active dimmer'>
          <div className='ui medium text loader'>{this.props.text}</div>
        </div>
      );
    }
  });

  return Loader;
});