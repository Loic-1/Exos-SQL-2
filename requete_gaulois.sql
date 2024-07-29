/*EXO 1*/
-- SELECT l.nom_lieu
-- FROM lieu l
-- WHERE l.nom_lieu LIKE '%um'

/*EXO 2*/
-- SELECT l.nom_lieu, COUNT(p.id_personnage) AS nbPersonnes
-- FROM personnage p
-- INNER JOIN lieu l ON p.id_lieu = l.id_lieu
-- GROUP BY l.id_lieu
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
-- GROUP BY s.id_specialite
-- ORDER BY nbPersonnes DESC

/*EXO 5*/
-- SELECT b.nom_bataille, b.date_bataille, l.nom_lieu
-- FROM bataille b
-- INNER JOIN lieu l ON b.id_lieu = l.id_lieu
-- ORDER BY b.date_bataille ASC -- JE PARS DU PRINCIPE QUE CES DATES SONT EN - (AVANT L'AN 0)

/*EXO 6*/
-- SELECT po.id_potion, po.nom_potion, SUM(co.qte * i.cout_ingredient) AS coutTotal
-- FROM potion po
-- INNER JOIN composer co ON po.id_potion = co.id_potion
-- INNER JOIN ingredient i ON co.id_potion = i.id_ingredient
-- GROUP BY po.id_potion
-- ORDER BY coutTotal DESC

/*EXO 7*/
-- SELECT i.nom_ingredient, i.cout_ingredient, co.qte
-- FROM ingredient i
-- INNER JOIN composer co ON i.id_ingredient = co.id_ingredient
-- INNER JOIN potion po ON co.id_potion = po.id_potion
-- WHERE po.nom_potion = 'Santé'

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
-- 	GROUP BY p.id_personnage
-- );

/*EXO 9*/
-- SELECT p.nom_personnage, SUM(bo.dose_boire) AS qteBue
-- FROM personnage p
-- INNER JOIN boire bo ON p.id_personnage = bo.id_personnage
-- GROUP BY p.id_personnage
-- ORDER BY qteBue DESC;

/*EXO 10*/
-- SELECT b.nom_bataille, SUM(pc.qte) AS casquePris
-- FROM bataille b
-- INNER JOIN prendre_casque pc ON b.id_bataille = pc.id_bataille
-- GROUP BY b.nom_bataille
-- HAVING casquePris >= ALL (
-- 	SELECT SUM(pc.qte)
-- 	FROM bataille b
-- 	INNER JOIN prendre_casque pc ON b.id_bataille = pc.id_bataille
-- 	GROUP BY b.id_bataille
-- );

/*EXO 11*/
-- SELECT tc.nom_type_casque, SUM(c.cout_casque) AS coutTotal
-- FROM casque c
-- INNER JOIN type_casque tc ON c.id_type_casque = tc.id_type_casque
-- GROUP BY tc.id_type_casque
-- ORDER BY coutTotal DESC;

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
-- WHERE bo.id_personnage IS NULL;

-- SELECT p.id_personnage, p.nom_personnage
-- FROM personnage p
-- WHERE p.id_personnage NOT IN (
-- 	SELECT p.id_personnage
-- 	FROM personnage p
-- 	LEFT JOIN boire bo ON p.id_personnage = bo.id_personnage
-- 	WHERE bo.id_personnage IS NOT NULL
-- );

/*EXO 15*/
-- SELECT p.nom_personnage
-- FROM personnage p
-- WHERE p.id_personnage NOT IN(
-- 	SELECT au.id_personnage
-- 	FROM autoriser_boire au
-- 	INNER JOIN potion po ON au.id_potion = po.id_potion
-- 	WHERE po.nom_potion = 'Magique'
-- )

/*A*/ -- https://www.w3schools.com/sql/sql_syntax.asp
-- INSERT INTO specialite
-- (nom_specialite)
-- SELECT 'Agriculteur'
-- WHERE NOT EXISTS (
-- 	SELECT 1
-- 	FROM specialite
-- 	WHERE nom_specialite = 'Agriculteur'
-- );

-- SET @id_lieu = (
-- SELECT id_lieu
-- FROM lieu
-- WHERE nom_lieu = 'Rotomagus'
-- );

-- SET @id_specialite = (
-- SELECT id_specialite
-- FROM specialite
-- WHERE nom_specialite = 'Agriculteur'
-- );

-- INSERT INTO personnage
-- (nom_personnage, adresse_personnage, image_personnage, id_lieu, id_specialite)
-- VALUES
-- ('Champdeblix', 'Ferme Hantassion', 'indisponible.jpg', @id_lieu, @id_specialite);

-- /*PLUS SIMPLE*/
-- INSERT INTO personnage
-- (nom_personnage, adresse_personnage, image_personnage, id_lieu, id_specialite)
-- VALUES
-- ('Champdeblix', 'Ferme Hantassion', 'indisponible.jpg', 9, 12)

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
-- (@id_potion, @id_personnage);

-- /*PLUS SIMPLE*/
-- INSERT INTO autoriser_boire
-- (id_potion, id_personnage)
-- VALUES
-- (1, 12);

/*C*/ -- ERREUR
   /*Trouver casque - (casque ∩ prendre_casque) où nom_type_casque = 'Grec'*/
   /*
SELECT c.id_casque, c.nom_casque
FROM casque c
INNER JOIN type_casque tc ON c.id_type_casque = tc.id_type_casque
LEFT JOIN prendre_casque pc ON c.id_casque = pc.id_casque
WHERE pc.id_casque IS NULL
AND tc.nom_type_casque = 'Grec';*/

-- DELETE FROM composer
-- WHERE id_potion = @id_potion
-- AND id_ingredient = @id_ingredient
/*
DELETE FROM casque
WHERE id_casque IN (
    SELECT c.id_casque
    FROM casque c
    LEFT JOIN prendre_casque pc ON c.id_casque = pc.id_casque
    WHERE c.id_type_casque = (
        SELECT id_type_casque
        FROM type_casque
        WHERE nom_type_casque = 'Grec'
    )
    AND pc.id_casque IS NULL
);*/

/*
INSERT INTO `casque` (`id_casque`, `nom_casque`, `cout_casque`, `id_type_casque`) VALUES
	(1, 'Villanovien', 865, 1),
	(2, 'Negau', 498, 1),
	(3, 'Corinthien', 765, 2),
	(4, 'Spangenhelm', 1200, 4),
	(5, 'Italo-celtique', 660, 1),
	(10, 'Weisenau', 50, 1),
	(11, 'Impérial-gaulois', 200, 1),
	(12, 'Gallois', 540, 4),
	(13, 'Wisigoth', 631, 4),
	(14, 'Ostrogoth', 743, 4),
	(15, 'A cornes', 2900, 3),
	(16, 'Veksø', 7820, 3),
	(17, 'Enkomi', 3140, 3),
	(18, 'Haguenau', 140, 1),
	(19, 'Picte', 160, 3),
	(20, 'Athénien', 452, 2),
	(21, 'Spartiate', 901, 2),
	(22, 'Phrygien', 840, 2),
	(23, 'Hoplite', 600, 2);
*/

/*D*/
-- INSERT INTO lieu
-- (nom_lieu)
-- SELECT 'Condate'
-- WHERE NOT EXISTS (
-- SELECT 1
-- FROM lieu
-- WHERE nom_lieu = 'Condate'
-- );

-- SET @id_lieu = (
-- SELECT id_lieu
-- FROM lieu
-- WHERE nom_lieu = 'Condate'
-- );

-- SET @id_specialite = (
-- SELECT id_specialite
-- FROM specialite
-- WHERE nom_specialite = 'Autre'
-- );

-- UPDATE personnage
-- SET adresse_personnage = 'Prison de Condate', image_personnage = 'indisponible.jpg', id_lieu = @id_lieu, id_specialite = @id_specialite
-- WHERE nom_personnage = 'Zérozérosix';

-- /*PLUS SIMPLE*/
-- UPDATE personnage
-- SET adresse_personnage = 'Prison de Condate', image_personnage = 'indisponible.jpg', id_lieu = 9, id_specialite = 17
-- WHERE nom_personnage = 'Zérozérosix';

/*E*/
-- SET @id_potion = (
-- SELECT id_potion -- 9
-- FROM potion
-- WHERE nom_potion =  'Soupe'
-- );

-- SET @id_ingredient = (
-- SELECT id_ingredient -- 19
-- FROM ingredient
-- WHERE nom_ingredient = 'Persil'
-- );

-- DELETE FROM composer
-- WHERE id_potion = @id_potion
-- AND id_ingredient = @id_ingredient;

-- /*PLUS SIMPLE*/
-- DELETE FROM composer
-- WHERE id_potion = 9
-- AND id_ingredient = 19;

/*F*/
-- SET @id_bataille = (
-- SELECT id_bataille
-- FROM bataille
-- WHERE nom_bataille = 'Attaque de la banque postale'
-- );

-- SET @id_casque = (
-- SELECT id_casque
-- FROM casque
-- WHERE nom_casque = 'Weisenau'
-- );

-- SET @id_personnage = (
-- SELECT id_personnage
-- FROM personnage
-- WHERE nom_personnage = 'Obélix'
-- );

-- UPDATE prendre_casque
-- SET id_casque = @id_casque, qte = 42
-- WHERE id_personnage = @id_personnage
-- AND id_bataille = @id_bataille

-- /*PLUS SIMPLE*/
-- UPDATE prendre_casque
-- SET id_casque = 10, qte = 42
-- WHERE id_personnage = 5
-- AND id_bataille = 9