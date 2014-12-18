# core
gulp = require 'gulp'
gutil = require 'gulp-util'

# stream utilities
gif = require 'gulp-if'
path = require 'path'

# plugins
imagemin = require 'gulp-imagemin'
htmlmin = require 'gulp-minify-html'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
csso = require 'gulp-csso'
reload = require 'gulp-livereload'
cache = require 'gulp-cached'
jshint = require 'gulp-jshint'
jsonlint = require 'gulp-jsonlint'
autoprefixer = require 'autoprefixer-stylus'
cmq = require 'gulp-combine-media-queries'
sourcemaps = require 'gulp-sourcemaps'

# misc
nodemon = require 'nodemon'
stylish = require 'jshint-stylish'
autowatch = require 'gulp-autowatch'
nib = require 'nib'
jeet = require 'jeet'

# browserify crap
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
coffeeify = require 'coffeeify'
browserify = require 'browserify'
watchify = require 'watchify'

cssSupport = [
  'last 5 versions',
  '> 1%',
  'ie 8', 'ie 7',
  'Android 4',
  'BlackBerry 10'
]

# paths
paths =
  img: './client/img/**/*'
  coffee: './client/**/*.coffee'
  bundle: './client/index.coffee'
  stylus: './client/**/*.styl'
  html: './client/**/*.html'
  config: './server/config/*.json'

# im going to break this out into a module
# so this will become about two lines
gulp.task 'server', (cb) ->
  # total hack to make nodemon + livereload
  # work sanely
  idxPath = './public/index.html'
  reloader = reload()
  nodemon
    script: './server/start.js'
    watch: ['./server']
    ext: 'js json coffee'
    ignore: './server/test'

  nodemon.once 'start', cb
  nodemon.on 'start', ->
    console.log 'Server has started'
    setTimeout ->
      reloader.write path: idxPath
    , 750
  nodemon.on 'quit', ->
    console.log 'Server has quit'
  nodemon.on 'restart', (files) ->
    console.log 'Server restarted due to:', files

  return


# javascript
bundleCache = {}
pkgCache = {}
bundler = watchify browserify paths.bundle,
  debug: true
  fullPaths: true
  cache: bundleCache
  packageCache: pkgCache
  extensions: ['.coffee']
bundler.transform coffeeify

gulp.task 'coffee', ->
  bundler.bundle()
    .pipe source 'index.js'
    .pipe buffer()
    .pipe cache 'js'
    .pipe sourcemaps.init
      loadMaps: true
    .pipe sourcemaps.write '.'
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'config', ->
  gulp.src paths.config
    .pipe cache 'config'
    .pipe jsonlint()
    .pipe jsonlint.reporter()

# styles
gulp.task 'stylus', ->
  gulp.src paths.stylus
    .pipe sourcemaps.init()
      .pipe stylus
        use: [
          nib(),
          jeet(),
          autoprefixer(
            cascade: true
            browsers: cssSupport
          )
        ]
      .pipe concat 'index.css'
      .pipe gif gutil.env.production, csso()
    .pipe sourcemaps.write '.'
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'html', ->
  gulp.src paths.html
    .pipe cache 'html'
    .pipe gif gutil.env.production, htmlmin()
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'img', ->
  gulp.src paths.img
    .pipe cache 'img'
    .pipe imagemin()
    .pipe gulp.dest './public/img'
    .pipe reload()

gulp.task 'watch', ->
  bundler.on 'update', ->
    gulp.start 'coffee'
  autowatch gulp, paths

gulp.task 'css', ['stylus']
gulp.task 'js', ['coffee']
gulp.task 'static', ['html', 'img']
gulp.task 'default', ['js', 'css', 'static', 'server', 'config', 'watch']
