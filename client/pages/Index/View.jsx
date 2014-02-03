/** @jsx React.DOM */
define(function(require){

  var Container = require('components/Container/View');
  var ItemList = require('components/ItemList/View');

  var ProfileCard = require('components/ProfileCard/View');
  var PageHeader = require('components/PageHeader/View');

  var Index = React.createClass({
    render: function() {
      return (
        <div id='index-page'>
          <Container>
            <PageHeader title='People' description='People you should follow' icon='settings'/>

            <ItemList perRow='four' stackable={true}>
              <ProfileCard username='zuck' points={100}/>
              <ProfileCard username='ChrisHughes' points={5}/>
              <ProfileCard username='arie.hasit'/>

              <ProfileCard username='zuck' points={100}/>
              <ProfileCard username='ChrisHughes' points={5}/>
              <ProfileCard username='arie.hasit'/>

              <ProfileCard username='zuck' points={100}/>
              <ProfileCard username='ChrisHughes' points={5}/>
              <ProfileCard username='arie.hasit'/>

              <ProfileCard username='zuck' points={100}/>
              <ProfileCard username='ChrisHughes' points={5}/>
              <ProfileCard username='arie.hasit'/>

              <ProfileCard username='zuck' points={100}/>
              <ProfileCard username='ChrisHughes' points={5}/>
              <ProfileCard username='arie.hasit'/>

              <ProfileCard username='zuck' points={100}/>
              <ProfileCard username='ChrisHughes' points={5}/>
              <ProfileCard username='arie.hasit'/>

              <ProfileCard username='zuck' points={100}/>
              <ProfileCard username='ChrisHughes' points={5}/>
              <ProfileCard username='arie.hasit'/>
            </ItemList>

          </Container>
        </div>
      );
    }
  });

  return Index;
});