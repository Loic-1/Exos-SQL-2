/*EXO 1*/
-- SELECT l.nom_lieu
-- FROM lieu l
-- WHERE l.nom_lieu LIKE '%um'

/*EXO 2*/
-- SELECT l.nom_lieu, COUNT(p.id_personnage) AS nbPersonnes
-- FROM personnage p
-- INNER JOIN lieu l ON p.id_lieu = l.id_lieu
-- GROUP BY l.nom_lieu
-- ORDER BY nbPersonnes DESC

/*EXO 3*/
-- SELECT p.nom_personnage, s.nom_specialite, p.adresse_personnage, l.nom_lieu
-- FROM personnage p
-- INNER JOIN specialite s ON p.id_specialite = s.id_specialite
-- INNER JOIN lieu l ON p.id_lieu = l.id_lieu
-- ORDER BY l.nom_lieu, p.nom_personnage

/*EXO 4*/
-- SELECT s.nom_specialite, COUNT(p.id_personnage) AS nbPersonnes
-- FROM personnage p
-- INNER JOIN specialite s ON p.id_specialite = s.id_specialite
-- GROUP BY s.nom_specialite
-- ORDER BY nbPersonnes DESC

/*EXO 5*/
-- SELECT b.nom_bataille, b.date_bataille, l.nom_lieu
-- FROM bataille b
-- INNER JOIN lieu l ON b.id_lieu = l.id_lieu
-- ORDER BY b.date_bataille -- JE PARS DU PRINCIPE QUE CES DATES SONT EN - (AVANT L'AN 0)

/*EXO 6*/ -- BOSSER ENCORE DESSUS
-- SELECT po.id_potion, po.nom_potion, SUM(co.qte * i.cout_ingredient) AS coutTotal
-- FROM potion po
-- INNER JOIN composer co ON po.id_potion = co.id_potion
-- INNER JOIN ingredient i ON co.id_potion = i.id_ingredient
-- GROUP BY po.id_potion, po.nom_potion
-- ORDER BY coutTotal DESC
/*
SELECT po.nom_potion, co.qte, i.cout_ingredient
FROM potion po
INNER JOIN composer co ON po.id_potion = co.id_potion
INNER JOIN ingredient i ON co.id_potion = i.id_ingredient*/

/*EXO 7*/
-- SELECT /*potion, */i.nom_ingredient, i.cout_ingredient, co.qte
-- FROM /*potion po, */ingredient i
-- INNER JOIN composer co ON i.id_ingredient = co.id_ingredient
-- INNER JOIN potion po ON co.id_potion = po.id_potion
-- WHERE po.nom_potion LIKE 'Santé'

/*EXO 8*/
-- AAAAAAAAA

/*EXO 9*/
-- SELECT p.nom_personnage, bo.dose_boire
-- FROM personnage p
-- INNER JOIN boire bo ON p.id_personnage = bo.id_personnage
-- ORDER BY bo.dose_boire DESC

/*EXO 10*/
-- SELECT b.nom_bataille, SUM(pc.qte) AS casquePris
-- FROM bataille b
-- INNER JOIN prendre_casque pc ON b.id_bataille = pc.id_bataille
-- GROUP BY b.nom_bataille
-- ORDER BY casquePris DESC
-- LIMIT 1