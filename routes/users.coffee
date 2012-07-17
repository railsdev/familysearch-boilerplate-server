logger = require 'winston'
User = require '../models/user'
utils = require '../lib/utils'

module.exports =
  me: (req, res) ->
    User.findById req.user.id, (err, user) ->
      logger.info "get me id=#{req.user.id} found id=#{user?._id} "
      utils.respond res, err, user, if user? then 200 else 404
