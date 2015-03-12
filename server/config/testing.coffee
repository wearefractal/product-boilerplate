
module.exports =
  debug: true
  port: 9191
  database: 'mongodb://localhost:27017/product_test'
  facebook:
    id: 'test'
    secret: 'test'
    callback: '/'

  redis:
    host: 'localhost'
    pass: ''
    dbIndex: 4
