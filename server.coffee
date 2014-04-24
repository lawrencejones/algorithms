fs       =  require  'fs'
path     =  require  'path'
jade     =  require  'jade'
stylus   =  require  'stylus'
express  =  require  'express'
coffee   =  require  'coffee-script'
morgan   =  require  'morgan'

# Create app
app = express()
app.use morgan('dev')

# Generates a compiler middleware
compiler = (opts) ->
  compile = opts.compile
  extRex = new RegExp "^([^.]+)\.#{opts.ext.compiled}"
  (req, res, next) ->
    if extRex.test req.url
      file = path.join\
      ( __dirname
      , "#{req.url.match(extRex)[1]}.#{opts.ext.source}" )
      fs.readFile file, 'utf8', (err, src) ->
        if err? then do next
        res.setHeader 'Content-Type', opts.mime
        res.send compile src
    else do next

# Configure jade
layout = jade.compile(fs.readFileSync path.join __dirname, 'layout.jade')
app.use compiler
  ext: compiled: 'html', source: 'jade'
  mime: 'text/html'
  compile: (src) ->
    layout html: (jade.compile src)()

# Configure coffeescript
app.use compiler
  ext: compiled: 'js', source: 'coffee'
  mime: 'application/javascript'
  compile: (src) ->
    coffee.compile src, bare: true

# Configure stylus
app.use compiler
  ext: compiled: 'css', source: 'stylus'
  mime: 'text/css'
  compile: stylus.render


# Serve static files from here
app.use express.static __dirname

app.listen (PORT = process.env.PORT || 4567), ->
  console.log "Server listening at http://localhost:#{PORT}"
