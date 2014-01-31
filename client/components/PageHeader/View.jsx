/** @jsx React.DOM */
define(function(require){
  var PageHeader = React.createClass({
    render: function() {
      return (
        <h2 className='ui header'>
          <i className='settings icon'/>
          <div className='content'>
            {this.props.page}
            <div className='sub header'>{this.props.description}</div>
          </div>
        </h2>
      );
    }
  });

  return PageHeader;
});