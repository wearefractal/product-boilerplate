# core
gulp = require 'gulp'

# stream utilities
gif = require 'gulp-if'
path = require 'path'

# plugins
imagemin = require 'gulp-imagemin'
htmlmin = require 'gulp-minify-html'
uglify = require 'gulp-uglify'
reload = require 'gulp-livereload'
cache = require 'gulp-cached'
jsonlint = require 'gulp-jsonlint'
sourcemaps = require 'gulp-sourcemaps'

# misc
nodemon = require 'gulp-nodemon'
autowatch = require 'gulp-autowatch'
nib = require 'nib'
jeet = require 'jeet'

# browserify crap
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
coffeeify = require 'coffeeify'
browserify = require 'browserify'
watchify = require 'watchify'

production = false

# paths
paths =
  img: './client/img/**/*'
  bundle: './client/index.coffee'
  html: './client/**/*.html'
  config: './server/config/*.json'

gulp.task 'server', (cb) ->
  watcher = nodemon
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

bundler = watchify browserify paths.bundle, args
bundler.transform coffeeify

bundle = ->
  bundler.bundle()
    .once 'error', (err) ->
      console.error err.message
    .pipe source 'index.js'
    .pipe buffer()
    .pipe cache 'js'
    .pipe sourcemaps.init
      loadMaps: true
    .pipe gif production, uglify()
    .pipe sourcemaps.write '.'
    .pipe gulp.dest './public'
    .pipe gif '*.js', reload()

gulp.task 'js', bundle

gulp.task 'config', ->
  gulp.src paths.config
    .pipe cache 'config'
    .pipe jsonlint()
    .pipe jsonlint.reporter()

gulp.task 'html', ->
  gulp.src paths.html
    .pipe cache 'html'
    .pipe gif production, htmlmin()
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'img', ->
  gulp.src paths.img
    .pipe cache 'img'
    .pipe imagemin()
    .pipe gulp.dest './public/img'
    .pipe reload()

gulp.task 'watch', (cb) ->
  reload.listen()
  bundler.on 'update', gulp.parallel 'js'
  autowatch gulp, paths
  cb()

gulp.task 'build', gulp.parallel 'html', 'img', 'js'
gulp.task 'default', gulp.series 'config', 'server', 'watch', 'build'
