/** @jsx React.DOM */
define(function(require){

  var Rating = React.createClass({

    componentDidMount: function() {
      var el = $(this.getDOMNode());

      if (this.props.onChange) {
        el.rating({
          onRate: this.props.onChange
        });
      }

      if (this.props.rating) {
        el.rating('set rating', this.props.rating);
      }
      if (this.props.write) {
        el.rating('enable');
      } else {
        el.rating('disable');
      }
    },

    render: function() {
      return this.transferPropsTo(
        <div className='ui star rating'>
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
