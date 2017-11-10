const express = require('express');
const router = express.Router();
const mysql = require('mysql');
const multer  = require('multer');
const fs = require('fs');
const upload = multer({ dest: 'tmp/' });
const config = require('../config.js');
const connection = mysql.createConnection(config);

connection.connect();


let newperson = {userid:'', firstname:'', lastname:'', dob:'', emailAddress:''};

// GET /main/
router.get('/', function(req, res, next) {
	connection.query('SELECT id, userid, firstname, lastname, dob, emailAddress, Address.address, Address.Postal_code, Address.City, Address.Country, Address.longitude, Address.latitude, Languages.language FROM people LEFT JOIN Knows ON id = Knows.id_person = people.id LEFT JOIN Languages ON Languages.id_language = Knows.id_language LEFT JOIN Address ON id = Address.id_address;', function (error, results, fields) {
		if (error) throw error;
		console.log(results);
		res.render('home',{people:results});
	});
});

// GET /main/change
router.get('/change-create', function(req, res, next) {
	res.render('modify', {action:'create', message:'Création d\'une fiche pour une personne', body:newperson});
});

// GET /main/change
router.get('/change-modify', function(req, res, next) {
	res.render('modify', {action:'modify', message:'Modfication d\'une fiche', body:req.body});
});

// POST /main/change
router.post('/change-:action(\\w+)', upload.single('picture'), function(req, res, next) {
	console.log(req.body);
	console.log(req.file);
	let action = req.params.action;
	if (req.body.firstname.length > 45 || req.body.lastname.length > 45 || req.body.emailAddress.length > 250){
		res.render('change', {action:req.params.action, message:'Attention, les textes sont trop longs :', body:req.body});
	};
	if (req.file) {
		if (req.file.originalname.length < 250){
			if(req.file.size < (3*1024*1024) && (req.file.mimetype == 'image/png' || req.file.mimetype == 'image/jpeg')) {
				console.log('image format ok');
				fs.rename(req.file.path,'public/images/'+req.file.originalname);

				if (action == 'modify'){
					// Modifier une personne dans la table 'people'
					connection.query('ALTER people (firstname, lastname, dob, emailAddress) values(?, ?, ?, ?);', [req.body.firstname, req.body.lastname, req.body.dob, req.body.emailAddress], function (error, results, fields) {
						if (error) throw error;
					});
				}
				if (action == 'create'){
					// Ajouter une personne dans la table 'people'
					connection.query('INSERT INTO people (firstname, lastname, dob, emailAddress) values(?, ?, NOW(), 1);',
					[req.body.firstname, req.body.lastname, req.body.dob, req.body.emailAddress], function (error, results, fields) {
						if (error) throw error;
					});
				}
				// router.use(function (req, res) {
				// 	// flash a message
				// 	req.flash('Fiche modifiée');
				// 	next();
				// });
				res.redirect('main');
			} else {
				res.render('change', {action:req.params.action, message:'Attention, image de type png ou jpeg requis, 3Mo de poids maximum', body:req.body});
			}
		} else {
			res.render('change',  {action:req.params.action, message:'Attention, nom de fichier trop long', body:req.body});
		}
	} else {
		res.render('change', {action:req.params.action, message:'Attention, une image est requise :', body:req.body});
	}
});


/* GET nous trouver */
router.get('/carte', function(req, res, next) {
	res.render('carte', {title: 'Wild carte'});
});

//const locations = [adresses:{...}]
router.get('/mapinit', function(req, res, next) {
	connection.query('SELECT id, userid, firstname, lastname, dob, emailAddress, Address.address, Address.Postal_code, Address.City, Address.Country, Address.longitude, Address.latitude FROM people LEFT JOIN Address ON id = Address.id_address;', function (error, results, fields) {
		if (error) {
			console.log(error);
		}
		console.log(results);
		res.json(results);
	});
});

	//GET BDAY
router.get('/calendar', function(req,res, next){
		connection.query('SELECT firstname, lastname, dob FROM people WHERE dob=DATE(NOW());', function (error, results, fields) {
				if (results.length==0){
				res.render ('noBday');
				} else {
					res.render('bday', {
						anniv : listebd
					})
					}

			});

	});

router.get('/moncompte', function(req, res, next) {
	connection.query('SELECT id, userid, firstname, lastname, dob, emailAddress, login, Users.password, Address.address, Address.Postal_code, Address.City, Address.Country, Address.longitude, Address.latitude, Languages.language FROM people LEFT JOIN Knows ON id = Knows.id_person = people.id LEFT JOIN Languages ON Languages.id_language = Knows.id_language LEFT JOIN Address ON id = Address.id_address LEFT JOIN Users ON id = Users.idUsers  ;', function (error, results, fields) {
		if (error) throw error;
		console.log(results);
		console.log(req.session.username);
		res.render('compte',{
			user:results.filter(a => (a.login == req.session.username))
		});
	});
});

module.exports = router;
