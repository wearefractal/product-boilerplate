/** @jsx React.DOM */
define(function(require){

  var User = require('models/User');

  var BigProfileCard = require('components/BigProfileCard/View');
  var UserComments = require('components/UserComments/View');
  var Container = require('components/Container/View');
  var Loader = require('components/Loader/View');

  var Person = React.createClass({
    componentWillMount: function () {
      User.get(this.props.params.id, function(err, user){
        this.setState({user: user});
      }.bind(this));
    },

    render: function () {
      if (!this.state) return <Loader />;

      return (
        <div id='person-page'>
          <Container>
            <BigProfileCard user={this.state.user}/>
            <UserComments user={this.state.user}/>
          </Container>
        </div>
      );
    }
  });

  return Person;
});