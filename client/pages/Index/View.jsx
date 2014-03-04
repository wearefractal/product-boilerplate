/** @jsx React.DOM */
define(function(require){

  var Container = require('components/Container/View');

  var Index = React.createClass({
    render: function () {
      return (
        <div id='index-page'>
          <Container>
            <p>Stuff</p>
          </Container>
        </div>
      );
    }
  });

  return Index;
});
