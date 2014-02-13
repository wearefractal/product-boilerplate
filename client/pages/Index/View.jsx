/** @jsx React.DOM */
define(function(require){

  var Container = require('components/Container/View');
  var PageHeader = require('components/PageHeader/View');

  var Index = React.createClass({
    render: function () {
      return (
        <div id='index-page'>
          <Container>
            <PageHeader title='Home' description='Your dashboard' icon='home'/>
            <p>Stuff</p>
          </Container>
        </div>
      );
    }
  });

  return Index;
});