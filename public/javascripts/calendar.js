var maintenant=new Date();
var jour=maintenant.getDate();
var mois=maintenant.getMonth()+1;
var an=maintenant.getFullYear()-1;
let listebd =[];

document.write("Nous sommes le ",jour,"/",mois,"/",an,".");

// si la date du jour est égale à une date d'anniversaire alors l'interface affiche bon anniversaire, 
//le nom de la personne et la météo. Sinon il n'affiche que bonjour et la météo. 


   