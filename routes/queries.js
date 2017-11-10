const mysql = require('mysql');
const config = require('../config.js');

const connection = mysql.createConnection(config);

//connection.query('SELECT userid, firstname, lastname, dob, emailAddress FROM people;'

connection.connect();

// GET /main/
router.get('/', function(req, res, next) {
	connection.query('SELECT userid, firstname, lastname, dob, emailAddress FROM people;', function (error, results, fields) {
		if (error) throw error;
		console.log(results);
		res.render('main',{people:results});
	});
});

// Ajouter une personne dans la table 'people'
connection.query('INSERT INTO people (firstname, lastname, dob, emailAddress) values(?, ?, ?, ?);',
[req.body.firstname, req.body.lastname, req.body.dob, req.body.emailAddress],
function (error, results, fields) {
	if (error) throw error;
	res.render('main', {message:"Personne ajoutée"});
	//console.log(results);
});

// modifier
connection.query('UPDATE products SET name = ?, description = ?, ingredients = ?, category = ? WHERE id = ?',
[req.body.product_name, req.body.product_description, req.body.ingredients, req.body.category, req.query.idProduit],
function(error){
	if (error) {
		console.log(error);
	}
});
