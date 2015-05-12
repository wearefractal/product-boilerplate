if (process.env.NODE_ENV == null) {
  process.env.NODE_ENV = 'local';
}

require('coffee-script/register');
if (process.env.NODE_ENV !== 'production') {
  require('coffee-trace');
}
module.exports = require('./start.coffee');