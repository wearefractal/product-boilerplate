/** @jsx React.DOM */
define(function(require){

  var User = require('models/User');

  var Container = require('components/Container/View');
  var PageHeader = require('components/PageHeader/View');

  var Person = React.createClass({
    getInitialState: function () {
      return {
        user: {}
      };
    },

    componentWillMount: function () {
      var newUser = User({_id: this.props.params.id});
      
      newUser.update(function(){
        this.setState({
          user: newUser,
          fetched: true
        });
      }.bind(this));

      this.setState({user: newUser});
    },

    render: function () {
      return (
        <div id='person-page'>
          <Container>
            {this.state.user.username()}
          </Container>
        </div>
      );
    }
  });

  return Person;
});