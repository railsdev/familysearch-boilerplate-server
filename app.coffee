express = require 'express'
logger = require 'winston'
require('winston-papertrail').Papertrail
config = require './conf/config'
utils = require './lib/utils'
mongoose = require 'mongoose'
auth = require './lib/auth'
users = require './routes/users'

app = express()

# in this boilerplate the server is simply a REST server, so views aren't used
app.set 'views', "#{__dirname}/views"
app.set 'view engine', 'hbs'
app.use express.favicon()
app.use express.logger()
# we want the server to be stateless, but it's convenient to pass the user-id back and forth in a secure cookie
app.use express.cookieParser(config.secret)
app.use express.cookieSession(cookie: httpOnly: false) # allow client to delete cookie on logout
app.use express.bodyParser()
app.use auth.initialize()
app.use auth.session()
if config.allowedDomains
  app.use utils.allowCrossDomain config.allowedDomains
app.use app.router
app.use express.static "#{__dirname}/public"

app.configure 'development', ->
  app.use express.errorHandler
    dumpExceptions: true,
    showStack: true
  logger.cli()

app.configure 'production', ->
  app.use express.errorHandler()
  logger.add logger.transports.Papertrail,
    host: config.papertrailHost,
    port: config.papertrailPort,
    handleExceptions: true

mongoose.connect config.mongodbUrl

app.options "*", (req, res) -> # for CORS requests
  res.send 200

app.get '/api/v1/users/me', auth.ensureAuthenticated, users.me

# This callback redirects the user to familysearch.org. After authorization,
# FamilySearch will redirect the user back to this application at /auth/familysearch/callback
app.get '/auth/familysearch', auth.authenticate, (req, res) ->
  # this function will never get called
# Handle the callback and redirect the user back to /
app.get '/auth/familysearch/callback', auth.authenticateCallback, (req, res) ->
  res.redirect config.clientHomepage

app.listen(config.port)

# logger levels are: verbose, info, warn, debug, error
logger.info "config.env=#{config.env}"
logger.info "Express server listening on port #{config.port}"
