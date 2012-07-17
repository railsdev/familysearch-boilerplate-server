_ = require('underscore')._
env = process.env.NODE_ENV || 'development'

config =
  env: env
  mongodbUrl: process.env.MONGODB_URL || 'mongodb://localhost:27017/test'
  port: process.env.PORT || 3000
  host: process.env.HOST || 'localhost'
  familySearchKey: process.env.FAMILYSEARCH_KEY
  secret: process.env.SECRET || 'secret'
  clientHomepage: '/'

_.extend config, switch env
  when 'production' then require './config_production'
  when 'development' then require './config_development'
  else {}

module.exports = config
