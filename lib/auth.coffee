logger = require 'winston'
config = require '../conf/config'
passport = require 'passport'
FamilySearchStrategy = require('passport-familysearch').Strategy
User = require '../models/user'

# To support persistent login sessions, Passport needs to be able to
# serialize users into and deserialize users out of the session.  For serialization,
# we'll simply save the id.
passport.serializeUser (user, done) ->
  logger.info 'serialize='+JSON.stringify(user)
  done null,
    id: user._id

# Many REST calls require only the user-id, so for deserialization, we'll simply pass back the user-id
passport.deserializeUser (obj, done) ->
  logger.info 'deserialize='+JSON.stringify(obj)
  done null, obj

# Use the FamilySearchStrategy within Passport.
#   Strategies in passport require a `verify` function, which accept
#   credentials (in this case, a token, tokenSecret, and FamilySearch profile), and
#   invoke a callback with a user object.
passport.use new FamilySearchStrategy {
    requestTokenURL: "https://#{config.familySearchAuthHost}/identity/v2/request_token",
    accessTokenURL: "https://#{config.familySearchAuthHost}/identity/v2/access_token",
    userAuthorizationURL: "https://#{config.familySearchAuthHost}/identity/v2/authorize",
    userProfileURL: "https://#{config.familySearchAuthHost}/identity/v2/user",
    consumerKey: config.familySearchKey,
    consumerSecret: '',
    callbackURL: "http://#{config.host}:#{config.port}/auth/familysearch/callback"
  },
  (token, tokenSecret, profile, done) ->
    # look for an existing user with the familysearch id, or create a new one
    logger.info 'look up profile='+JSON.stringify(profile)
    User.findOne familySearchId: profile.id, (err, user) ->
      logger.info 'found user='+JSON.stringify(user)
      return done err if err?
      return done null, user if user?
      user = new User
        familySearchId: profile.id
        displayName: profile.displayName
      user.save (err) ->
        return done err if err?
        done err, user

module.exports =
  initialize: ->
    passport.initialize()

  session: ->
    passport.session()

  authenticate: passport.authenticate 'familysearch'

  authenticateCallback: passport.authenticate 'familysearch'

  # never called, because the client deletes the cookie to log out
  logout: (req, res, next) ->
    req.logout()
    next()

  # Simple route middleware to ensure user is authenticated.
  # Use this route middleware on any resource that needs to be protected.  If
  # the request is authenticated (typically via a persistent login session),
  # the request will proceed.  Otherwise, we'll return a 401 error.
  ensureAuthenticated: (req, res, next) ->
    return res.send 401 unless req.isAuthenticated()
    next()
