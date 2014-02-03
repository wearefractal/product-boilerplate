// core
var gulp = require('gulp');
var gutil = require('gulp-util');

// stream utilities
var gif = require('gulp-if');
var path = require('path');

// plugins
var htmlmin = require('gulp-minify-html');
var react = require('gulp-react');
var coffee = require('gulp-coffee');
var stylus = require('gulp-stylus');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var csso = require('gulp-csso');
var reload = require('gulp-livereload');

// live reload crap
var nodemon = require('nodemon');
var lr = require('tiny-lr');
var lrServer = lr();
lrServer.listen(35729, function (err) {
  if (err) console.error(err);
});

// paths
var paths = {
  vendor: './client/vendor/**/*',
  coffee: './client/**/*.coffee',
  jsx: './client/**/*.jsx',
  stylus: './client/**/*.styl',
  html: './client/**/*.html'
};

// im going to break this out into a module
// so this will become about two lines
gulp.task('server', function (cb) {
  // total hack to make nodemon + livereload
  // work sanely
  var idxPath = './public/index.html';
  var reloader = reload(lrServer);

  nodemon({
    script: './server/start.js',
    watch: ['./server'],
    ext: 'js json coffee',
    ignore: './server/test'
  });
  nodemon.once('start', cb);
  nodemon.on('start', function () {
    console.log('Server has started');
    setTimeout(function(){
      reloader.write({path:idxPath});
    }, 750);
  }).on('quit', function () {
    console.log('Server has quit');
  }).on('restart', function (files) {
    console.log('Server restarted due to:', files);
  });
});

// javascript
gulp.task('coffee', function () {
  return gulp.src(paths.coffee)
    .pipe(coffee())
    .pipe(gif(gutil.env.production, uglify()))
    .pipe(gulp.dest('./public'))
    .pipe(reload(lrServer));
});

gulp.task('jsx', function () {
  return gulp.src(paths.jsx)
    .pipe(react())
    .pipe(gif(gutil.env.production, uglify()))
    .pipe(gulp.dest('./public'))
    .pipe(reload(lrServer));
});

// styles
gulp.task('stylus', function () {
  return gulp.src(paths.stylus)
    .pipe(stylus())
    .pipe(concat('app.css'))
    .pipe(gif(gutil.env.production, csso()))
    .pipe(gulp.dest('./public'))
    .pipe(reload(lrServer));
});

gulp.task('html', function () {
  return gulp.src(paths.html)
    .pipe(gif(gutil.env.production, htmlmin()))
    .pipe(gulp.dest('./public'))
    .pipe(reload(lrServer));
});

gulp.task('vendor', function () {
  return gulp.src(paths.vendor)
    .pipe(gulp.dest('./public/vendor'))
    .pipe(reload(lrServer));
});

gulp.task('watch', function () {
  Object.keys(gulp.tasks).forEach(function (t) {
    if (!paths[t]) return; // no watch
    gulp.watch(paths[t], [t]);
  });
});

gulp.task('css', ['stylus']);
gulp.task('js', ['coffee', 'jsx']);
gulp.task('static', ['html', 'vendor']);

gulp.task('default', ['js', 'css', 'static', 'server', 'watch']);
