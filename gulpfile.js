var gulp = require('gulp'),
    elm  = require('gulp-elm')
    stylus = require('gulp-stylus'),
    watch = require('gulp-watch'),
    concat = require('gulp-concat')
    server = require('gulp-server-livereload')

    //changed = require('gulp-changed'),
    //browserify = require('browserify'),
    //watchify = require('watchify'),
    //reactify = require('reactify'),
;


gulp.task('webserver', function() {
  gulp.src('./')
    .pipe(server({
      livereload: true,
      directoryListing: true,
      open: true,
    }));
});

//***************************************
// compile source files to app dir
//***************************************

var notify = function(message) {
    console.log(message);
};

// gulp.task('elm-init', elm.init);

// gulp.task('compileElm', ['elm-init'], function(){
//     return gulp.src('src/**/*.elm')
//         .pipe(watch('src/**/*.elm',function(event){
//             notify("Elm Changed!");
//         }))
//         .pipe(elm())
//         // .pipe(concat('elmapp.compiled.js'))
//         .pipe(gulp.dest('app'))
//         // .pipe(livereload())
//     ;
// });


gulp.task('compileStylus',function(){
    return gulp.src('src/**/*.styl')
        .pipe(watch('src/**/*.styl',function(event){
            notify("Styles Changed!");
        }))
    //.pipe(changed('app'))
        .pipe(stylus())
        .pipe(gulp.dest('app'))
        // .pipe(livereload())
    ;
});


// gulp.task('default',['webserver','compileStylus']);
gulp.task('default',['compileStylus']);
