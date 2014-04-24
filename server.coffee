fs       =  require  'fs'
path     =  require  'path'
jade     =  require  'jade'
express  =  require  'express'
coffee   =  require  'coffee-script'

# Create app
app = express()

# Generates a compiler middleware
compiler = (opts) ->
  compile = opts.compile
  extRex = new RegExp "^([^.]+)\.#{opts.ext.compiled}"
  (req, res, next) ->
    if extRex.text req.url
      file = path.join\
      ( __dirname
      , "#{req.url.match(extRex)[0]}.#{opts.ext.source}" )
      fs.read file, (err, src) ->
        if err? then do next
        else res.send compile src
    else do next

# Configure jade
layout = jade.compile(fs.readFileSync path.join __dirname, 'layout.jade')
app.use compiler
  ext: compiled: 'html', source: 'jade'
  compile: (src) ->
    layout html: (jade.compile src)()

# Configure coffeescript
app.use compiler
  ext: compiled: 'js', source: 'coffee'
  compile: coffee.compile

# Serve static files from here
app.use express.static __dirname

app.listen (PORT = process.env.PORT || 4567), ->
  console.log "Server listening at http://localhost:#{PORT}"
