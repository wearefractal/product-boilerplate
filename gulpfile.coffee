# core
gulp = require 'gulp'
gutil = require 'gulp-util'

# stream utilities
gif = require 'gulp-if'
path = require 'path'
rimraf = require 'rimraf'

# plugins
imagemin = require 'gulp-imagemin'
htmlmin = require 'gulp-minify-html'
uglify = require 'gulp-uglify'
reload = require 'gulp-livereload'
cache = require 'gulp-cached'
replace = require 'gulp-replace'
sourcemaps = require 'gulp-sourcemaps'

# misc
nodemon = require 'gulp-nodemon'
autowatch = require 'gulp-autowatch'
nib = require 'nib'

# browserify crap
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
coffeeify = require 'coffeeify'
envify = require 'envify'
browserify = require 'browserify'
watchify = require 'watchify'

production = process.env.NODE_ENV is 'production'
staging = process.env.NODE_ENV is 'staging'
development = process.env.NODE_ENV is 'development'
local = !production and !staging and !development

# version
{version} = require './package.json'

# paths
paths =
  img: './client/img/**/*'
  vendor: './client/vendor/**/*'
  fonts: './client/fonts/**/*'
  bundle: './client/index.coffee'
  html: './client/**/*.html'

gulp.task 'server', (cb) ->
  watcher = nodemon
    verbose: false
    script: './server'
    watch: ['./server']
    ext: 'js json coffee'
    ignore: './server/test'

  watcher.once 'start', cb
  watcher.on 'start', ->
    # TODO: make sure this is actually right
    setTimeout reload.reload, 1000
  return

# javascript
args =
  fullPaths: true
  debug: !production
  cache: {}
  packageCache: {}
  extensions: ['.coffee']

bundler = browserify paths.bundle, args
bundler = watchify bundler if local
bundler.transform coffeeify
bundler.transform envify

gulp.task 'rimraf', (cb) ->
  rimraf.sync './public'
  cb()

reportError = (err) ->
  gutil.log gutil.colors.red err.message
  gutil.beep()

bundle = ->
  bundler.bundle()
    .on 'error', reportError
    .pipe source 'index.js'
    .pipe buffer()
    .pipe cache 'js'
    .pipe sourcemaps.init
      loadMaps: true
    .pipe uglify()
    .pipe sourcemaps.write '.'
    .pipe gulp.dest './public'
    .pipe gif '*.js', reload quiet: true

gulp.task 'js', bundle

gulp.task 'html', ->
  gulp.src paths.html
    .pipe cache 'html'
    .pipe replace '$CACHE_BUST', String Date.now()
    .pipe htmlmin()
    .pipe gulp.dest './public'
    .pipe reload quiet: true

gulp.task 'img', ->
  gulp.src paths.img
    .pipe cache 'img'
    .pipe imagemin()
    .pipe gulp.dest './public/img'
    .pipe reload quiet: true

gulp.task 'vendor', ->
  gulp.src paths.vendor
    .pipe cache 'vendor'
    .pipe gulp.dest './public/vendor'
    .pipe reload quiet: true

gulp.task 'fonts', ->
  gulp.src paths.fonts
    .pipe cache 'fonts'
    .pipe gulp.dest './public/fonts'
    .pipe reload quiet: true

gulp.task 'watch', (cb) ->
  reload.listen()
  bundler.on 'update', gulp.parallel 'js'
  autowatch gulp, paths
  cb()

gulp.task 'build', gulp.parallel 'html', 'img', 'vendor', 'fonts', 'js'
gulp.task 'default', gulp.series 'rimraf', 'build', 'server', 'watch'
