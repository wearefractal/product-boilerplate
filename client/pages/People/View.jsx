/** @jsx React.DOM */
define(function(require){

  var User = require('models/User');

  var Container = require('components/Container/View');
  var ItemList = require('components/ItemList/View');
  var Loader = require('components/Loader/View');

  var ProfileCard = require('components/ProfileCard/View');
  var PageHeader = require('components/PageHeader/View');

  var People = React.createClass({

    componentWillMount: function () {
      User.all(function(err, users){
        this.setState({users: users});
      }.bind(this));
    },

    render: function () {
      if (!this.state) return <Loader />;

      var userCards = this.state.users.models.map(ProfileCard);

      return (
        <div id='people-page'>
          <Container>
            <PageHeader title='People' description='People you should follow' icon='users'/>
            <ItemList perRow='three' stackable={true}>
              {userCards}
            </ItemList>

          </Container>
        </div>
      );
    }
  });

  return People;
});
