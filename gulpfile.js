var gulp = require('gulp'),
    elm  = require('gulp-elm'),
    stylus = require('gulp-stylus'),
    watch = require('gulp-watch'),
    concat = require('gulp-concat'),
    server = require('gulp-server-livereload')
;

const imagemin = require('gulp-imagemin');



gulp.task('webserver', function() {
  gulp.src('./')
    .pipe(server({
      livereload: true,
      directoryListing: true,
      open: true
    }));
});

//***************************************
// compile source files to app dir
//***************************************

var notify = function(message) {
    console.log(message);
};



gulp.task('compileStylus',function(){
    return gulp.src('src/**/*.styl')
        .pipe(watch('src/**/*.styl',function(event){
            notify("Styles Changed!");
        }))
        .pipe(stylus())
        .pipe(gulp.dest('app'))
    ;
});

gulp.task('imageMin',function(){
    return gulp.src('res/*')
        .pipe(watch('res/*',function(event){
            notify("Image found");
        }))
        .pipe(imagemin())
        .pipe(gulp.dest('app/res'))
    ;
});


// gulp.task('default',['webserver','compileStylus']);
gulp.task('default',['compileStylus','imageMin']);
