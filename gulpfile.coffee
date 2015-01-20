# core
gulp = require 'gulp'

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
autoprefixer = require 'gulp-autoprefixer'
normalize = require 'stylus-normalize'
cmq = require 'gulp-combine-media-queries'
sourcemaps = require 'gulp-sourcemaps'

# misc
nodemon = require 'gulp-nodemon'
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

production = false
cssSupport = [
  'last 5 versions',
  '> 1%',
  'ie 8', 'ie 7',
  'Android 4',
  'BlackBerry 10'
]

# paths
paths =
  index: './public/index.html'
  img: './client/img/**/*'
  coffee: './client/**/*.coffee'
  bundle: './client/index.coffee'
  stylus: './client/**/*.styl'
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
    setTimeout ->
      reload.changed paths.index
    , 750
  return

# javascript
args =
  debug: true
  fullPaths: true
  cache: {}
  packageCache: {}
  extensions: ['.coffee']

bundler = watchify browserify paths.bundle, args
bundler.transform coffeeify

gulp.task 'coffee', ->
  bundler.bundle()
    .once 'error', (err) ->
      console.error err
    .pipe source 'index.js'
    .pipe buffer()
    .pipe cache 'js'
    .pipe sourcemaps.init
      loadMaps: true
    .pipe sourcemaps.write '.'
    .pipe gulp.dest './public'
    .pipe gif '*.js', reload()

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
          normalize(true),
          nib(),
          jeet()
        ]
      .pipe autoprefixer
        browsers: cssSupport
      .pipe concat 'index.css'
      .pipe gif production, csso()
    .pipe sourcemaps.write '.'
    .pipe gulp.dest './public'
    .pipe gif '*.css', reload()

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

gulp.task 'watch', ->
  bundler.on 'update', ->
    gulp.start 'coffee'
  autowatch gulp, paths

gulp.task 'css', ['stylus']
gulp.task 'js', ['coffee']
gulp.task 'static', ['html', 'img']
gulp.task 'default', ['js', 'css', 'static', 'server', 'config', 'watch']

reload.listen()