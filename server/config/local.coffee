module.exports =
  debug: true
  database: 'mongodb://localhost:27017/product_local'
  facebook:
    id: ''
    secret: ''
    callback: '/auth/facebook/callback'
  redis:
    host: 'localhost'
    pass: ''
    dbIndex: 1