/** @jsx React.DOM */
define(function(require){
  var auth = require('app/auth');

  var LoginButton = require('components/LoginButton/View');
  var LogoutButton = require('components/LogoutButton/View');

  var Navbar = React.createClass({
    render: function() {
      return (
        <nav className='ui large menu'>
          <a className='active item' href='/'>
            <i className='home icon'/> Home
          </a>
          <div className='right menu'>
            <div className='item'>
              <div className='ui icon input'>
                <input type='text' placeholder='Search...' />
                <i className='search link icon'/>
              </div>
            </div>
            {auth ? <LogoutButton /> : <LoginButton />}
          </div>
        </nav>
      );

    }
  });

  return Navbar;
});