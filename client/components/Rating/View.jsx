/** @jsx React.DOM */
define(function(require){

  var Rating = React.createClass({

    componentDidMount: function() {
      var el = $(this.getDOMNode());
      if (this.props.write) {
        el.rating('enable');
      } else {
        el.rating('disable');
      }
    },

    render: function() {
      return this.transferPropsTo(
        <div className='ui star rating' data-rating={this.props.rating}>
          <i className='icon'/>
          <i className='icon'/>
          <i className='icon'/>
          <i className='icon'/>
          <i className='icon'/>
        </div>
      );
    }
  });

  return Rating;
});
