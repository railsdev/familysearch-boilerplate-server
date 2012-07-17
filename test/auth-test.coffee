logger = require 'winston'
expect = require('chai').expect
app = require '../app'
request = require 'request'

describe 'Authentication', ->
  it 'should authenticate valid user id', (done) ->
    cj = request.jar()
    # hard-code valid signed cookie value; cookie secret is 'secret'; not sure of a better way to generate a signed cookie
    cj.add(request.cookie('connect.sess=j%3A%7B%22passport%22%3A%7B%22user%22%3A%7B%22id%22%3A%2250043b05683d343370000001%22%7D%7D%7D.GqVO%2Bv6QJwiLpjYSTQSusN%2BCn7%2FVkyNPMhHitJgFxkg'))
    request {url: 'http://localhost:3000/api/v1/users/me', jar: cj}, (err, res) ->
      expect(res.statusCode).to.not.equal 401 # 200 or 404 are ok
      done()
  it 'should not authenticate missing user id', (done) ->
    cj = request.jar()
    request {url: 'http://localhost:3000/api/v1/users/me', jar: cj}, (err, res) ->
      expect(res.statusCode).to.equal 401
      done()
