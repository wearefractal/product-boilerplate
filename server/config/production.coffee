module.exports =
  cache: true
  port: 1337
  database: 'mongodb://localhost:27017/product_prod'
  facebook:
    id: ''
    secret: ''
    callback: '/auth/facebook/callback'
  redis:
    host: 'localhost'
    pass: ''
    dbIndex: 3