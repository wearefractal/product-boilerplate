
module.exports =
  debug: true
  database: 'mongodb://localhost:27017/product_dev'
  facebook:
    id: ''
    secret: ''
    callback: '/auth/facebook/callback'

  redis:
    host: 'localhost'
    pass: ''
    dbIndex: 3
