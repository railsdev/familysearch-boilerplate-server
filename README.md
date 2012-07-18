# FamilySearch Boilerplate Server

This is a very simple boilerplate application for accessing FamilySearch from node.js.
It's designed to be used together with [FamilySearch Boilerplate Client](https://github.com/DallanQ/familysearch-boilerplate-client)

This is a work in progress.

## Uses

* [node.js](http://nodejs.org/)
* [coffeescript](http://coffeescript.org)
* [passport](http://passportjs.org/)
* [mongoose](http://mongoosejs.com/)
* [winston-papertrail logger](https://github.com/kenperkins/winston-papertrail)
* [mocha](http://visionmedia.github.com/mocha/)

## Getting started

Get a FamilySearch key [here](https://devnet.familysearch.org/certification)

Set the FAMILYSEARCH_KEY environment variable to your key

Run server tests with `mocha`

Run the server with `coffee app.coffee` or `node-dev app.coffee`

Start up the [client](https://github.com/DallanQ/familysearch-boilerplate-client)

## License
The MIT license.

Copyright (c) 2012 Dallan Quass (http://github.com/DallanQ)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
