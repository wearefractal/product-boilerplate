module.exports =
  debug: true
  database: 'mongodb://localhost:27017/product_dev'
  facebook:
    id: 'replace-this'
    secret: 'replace-this'
    callback: '/auth/facebook/callback'
  redis:
    host: 'localhost'
    pass: ''
    dbIndex: 2