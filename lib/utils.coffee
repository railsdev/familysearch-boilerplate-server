logger = require 'winston'

module.exports =
  respond: (res, err, result, status = 200) ->
    if err?
      # TODO we need to report errors better someday
      res.json 500, err
    else if result?
      res.json status, result
    else
      res.send status

  allowCrossDomain: (hostnames) ->
    do (hostnames) ->
      (req, res, next) ->
        if hostnames.indexOf req.headers.origin isnt -1
          res.header 'Access-Control-Allow-Credentials', true
          res.header 'Access-Control-Allow-Origin', req.headers.origin
          res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS'
          res.header 'Access-Control-Allow-Headers', 'X-Requested-With, Accept, Content-Length, Content-MD5, Content-Type'
          res.header 'Access-Control-Max-Age', '86400'
          next()
        else
          res.send 401
