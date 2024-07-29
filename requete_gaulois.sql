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

/*EXO 6*/
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
-- SELECT p.nom_personnage, SUM(pc.qte) AS casquesPris
-- FROM personnage p
-- INNER JOIN prendre_casque pc ON p.id_personnage = pc.id_personnage
-- INNER JOIN casque c ON pc.id_casque = c.id_casque
-- GROUP BY p.nom_personnage
-- HAVING casquesPris >= ALL(
-- 	SELECT SUM(pc.qte)
-- 	FROM personnage p
-- 	INNER JOIN prendre_casque pc ON p.id_personnage = pc.id_personnage
-- 	INNER JOIN casque c ON pc.id_casque = c.id_casque
-- 	GROUP BY p.nom_personnage
-- )

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
-- HAVING casquePris >= ALL (
-- 	SELECT SUM(pc.qte)
-- 	FROM bataille b
-- 	INNER JOIN prendre_casque pc ON b.id_bataille = pc.id_bataille
-- 	GROUP BY b.nom_bataille
-- )

/*EXO 11*/
-- SELECT tc.nom_type_casque, SUM(c.cout_casque) AS coutTotal
-- FROM casque c
-- INNER JOIN type_casque tc ON c.id_type_casque = tc.id_type_casque
-- GROUP BY tc.nom_type_casque
-- ORDER BY coutTotal DESC

/*EXO 12*/
-- SELECT po.nom_potion
-- FROM potion po
-- INNER JOIN composer co ON po.id_potion = co.id_potion
-- INNER JOIN ingredient i ON co.id_potion = i.id_ingredient
-- WHERE co.id_ingredient = 24

/*EXO 13*/
-- SELECT l.nom_lieu, COUNT(p.id_lieu) AS nbHabitants
-- FROM lieu l
-- INNER JOIN personnage p ON l.id_lieu = p.id_lieu
-- WHERE NOT l.nom_lieu = 'Village gaulois'
-- GROUP BY l.nom_lieu
-- HAVING nbHabitants >= ALL(
-- 	SELECT COUNT(p.id_lieu)
-- 	FROM lieu l
-- 	INNER JOIN personnage p ON l.id_lieu = p.id_lieu
-- 	WHERE NOT l.nom_lieu = 'Village gaulois'
-- 	GROUP BY l.nom_lieu
-- )

/*EXO 14*/
-- SELECT p.id_personnage, p.nom_personnage
-- FROM personnage p
-- LEFT JOIN boire bo ON p.id_personnage = bo.id_personnage
-- WHERE bo.id_personnage IS NULL

/*EXO 15*/
-- SELECT p.nom_personnage
-- FROM personnage p
-- WHERE p.id_personnage NOT IN(
-- SELECT au.id_personnage
-- FROM autoriser_boire au
-- INNER JOIN potion po ON au.id_potion = po.id_potion
-- WHERE po.nom_potion = 'Magique'
-- )

/*A*/ -- https://www.w3schools.com/sql/sql_syntax.asp
-- INSERT INTO specialite
-- (nom_specialite)
-- SELECT 'Agriculteur'
-- WHERE NOT EXISTS (
-- SELECT 1
-- FROM specialite
-- WHERE nom_specialite = 'Agriculteur');

-- SET @id_lieu = (
-- SELECT id_lieu
-- FROM lieu
-- WHERE nom_lieu = 'Rotomagus');

-- SET @id_specialite = (
-- SELECT id_specialite
-- FROM specialite
-- WHERE nom_specialite = 'Agriculteur');

-- INSERT INTO personnage
-- (nom_personnage, adresse_personnage, image_personnage, id_lieu, id_specialite)
-- VALUES
-- ('Champdeblix', 'Ferme Hantassion', 'indisponible.jpg', @id_lieu, @id_specialite)

/*B*/
-- INSERT INTO potion
-- (nom_potion)
-- SELECT 'Magique'
-- WHERE NOT EXISTS (
-- SELECT 1
-- FROM potion
-- WHERE nom_potion = 'Magique'
-- );

-- SET @id_potion = (
-- SELECT id_potion
-- FROM potion
-- WHERE nom_potion = 'Magique'
-- );

-- SET @id_personnage = (
-- SELECT id_personnage
-- FROM personnage
-- WHERE nom_personnage = 'Bonemine'
-- );

-- INSERT INTO autoriser_boire
-- (id_potion, id_personnage)
-- VALUES
-- (@id_potion, @id_personnage)

/*C*/ -- ERREUR
   /*Trouver casque - (casque ∩ casque_pris) où nom_type_casque = 'Grec'*/
-- SELECT c.id_casque, c.nom_casque
-- FROM casque c
-- INNER JOIN type_casque tc ON c.id_type_casque = tc.id_type_casque
-- LEFT JOIN prendre_casque pc ON c.id_casque = pc.id_casque
-- WHERE pc.id_casque IS NULL
-- AND tc.nom_type_casque = 'Grec'

-- DELETE c.*
-- FROM casque c
-- WHERE c.id_casque IS IN (
-- 	SELECT c.id_casque
-- 	FROM casque c
-- 	INNER JOIN type_casque tc ON c.id_type_casque = tc.id_type_casque
-- 	LEFT JOIN prendre_casque pc ON c.id_casque = pc.id_casque
-- 	WHERE pc.id_casque IS NULL
-- 	AND tc.nom_type_casque = 'Grec'
-- )