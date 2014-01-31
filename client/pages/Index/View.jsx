/** @jsx React.DOM */
define(function(require){

  var Container = require('components/Container/View');
  var ItemList = require('components/ItemList/View');

  var ProfileCard = require('components/ProfileCard/View');
  var PageHeader = require('components/PageHeader/View');

  var Index = React.createClass({
    render: function() {
      return (
        <Container>
          <PageHeader page='People' description='People you should follow'/>

          <ItemList perRow='three' stackable={true}>
            <ProfileCard username='zuck' points={100}/>
            <ProfileCard username='ChrisHughes' points={50}/>
            <ProfileCard username='moskov'/>

            <ProfileCard username='zuck' points={100}/>
            <ProfileCard username='ChrisHughes' points={50}/>
            <ProfileCard username='moskov'/>

            <ProfileCard username='zuck' points={100}/>
            <ProfileCard username='ChrisHughes' points={50}/>
            <ProfileCard username='moskov'/>
          </ItemList>

        </Container>
      );
    }
  });

  return Index;
});