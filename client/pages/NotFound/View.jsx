/** @jsx React.DOM */
define(function(require){
  
  var Container = require('components/Container/View');

  var NotFound = React.createClass({
    render: function() {
      return (
        <Container>
          <div className='ui icon message'>
            <i className='attention icon'></i>
            <div className='content'>
              <div className='header'>
                Page not found
              </div>
              <p>The page you tried to reach does not exist. Sorry about that.</p>
            </div>
          </div>
        </Container>
      );
    }
  });

  return NotFound;
});