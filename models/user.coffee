logger = require 'winston'
mongoose = require 'mongoose'

UserSchema = new mongoose.Schema
  familySearchId: { type: String, unique: true} # index so we can quickly look up users by familysearch id
  displayName   : String
  version       : { type: Number, default: 0} # in case we want to use optimistic concurrency control
  { strict : true }

module.exports = mongoose.model 'User', UserSchema
