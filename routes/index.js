var express = require('express');
var router = express.Router();
const mysql = require('mysql');
const multer  = require('multer');
const fs = require('fs');
const upload = multer({ dest: 'tmp/' });
const config = require('../config.js');

const connection = mysql.createConnection(config);

connection.connect();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('login');
});

// Page admin login/
router.post('/', function(req, res, next) {
    let fail = '';
	let login= req.body.login;
	let password = req.body.password;
	console.log(req.body);
	connection.query(`select * from Users where login="${login}" and password="${password}";`,
       function (error, results, fields){
        if (results.length==0) {
			res.send('erreur');
		} else {
			req.session.username=req.body.login;
			req.session.connected=true;

			res.redirect('/main');
		}
	});
});


//disconnect
router.get("/admin-logout", function(req, res, next) {
    req.session.connected=false;
    res.redirect('/');
});

router.get('/compte', function(req, res, next) {
  res.render('compte');
});

router.get('/cal', function(req, res, next) {
  res.render('cal');
});


router.get('/modify', function(req, res, next) {
  res.render('modify');
});


module.exports = router;
