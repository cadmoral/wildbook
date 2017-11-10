var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
const Session = require('express-session');
const mysql = require('mysql');
const config = require('./config.js');
const connection = mysql.createConnection(config);

connection.connect();



var index = require('./routes/index');
var users = require('./routes/users');
//var admin = require('./routes/admin');
var main = require('./routes/main');

var app = express();


// api Rocketchat
let listebd =[];

const request = require('request');

var CronJob = require('cron').CronJob;
new CronJob('*/5 * * * * * 1-7', function() {

  connection.query('SELECT firstname, lastname, dob FROM people WHERE dob=DATE(NOW());', function (error, results, fields) {
    if (error) throw error;
    console.log(listebd);
    listebd=results;
  });
    //-----------------------------------------------------------

    request.post({
      url:'https://demo.rocket.chat/api/v1/login',
      form: {
        "user": "jdm8@hotmail.fr",
        "password" : "azerty1234"
        }
      }, function (error, response, body) {

        const json = JSON.parse(body);
        const authToken = json.data.authToken;
        const userId = json.data.userId;
        console.log(listebd);

        for (var i =0; i<listebd.length; i++) {

          request.post({
            url:'https://demo.rocket.chat/api/v1/chat.postMessage',
            headers: {
              'X-Auth-Token': authToken,
              'X-User-Id': userId
              },
            form: {
              "channel": "#apirocket",
              "text": "bonjour aujourd'hui c'est l'aniversaire de " + listebd[i].firstname
            }

          },  function (error, response, body){
                console.log(error,body);
              })

        }

      });

    //----------------------------------------------------

  console.log('You will see this message every second');
}, null, true, 'Europe/Paris');





// pour la page admin super protégée !
// view engine setup


app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
const FileStore = require('session-file-store')(Session);

app.use(Session({
store: new FileStore({
path: path.join(__dirname, '/tmp'),
encrypt: true
}),
secret: 'Super Secret !',
resave: true,
saveUninitialized: true,
name : 'mysession'
}));


app.use('/', index);
app.use('/users', users);
app.use('/main', function (req, res, next) {
  console.log(req.session.connected);
if (req.session.connected) {
return next();
} else {
return res.redirect ('/')
}
});
app.use('/main', main);




// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
