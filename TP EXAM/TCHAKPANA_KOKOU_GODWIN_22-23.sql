/*a. Donner les informations des contribuables qui habitent paris*/
SELECT *
FROM `contribuable`
WHERE `contribuable`.`adr` LIKE '%paris%';

/*b.Donner le numéro et le nom des contribuables qui ont payé une amande. Chaque ligne 
(numéro et nom) s’affiche une seule fois.*/
SELECT DISTINCT `tel`,`nom`
FROM `contribuable` as c, `payer_amende` as p
WHERE c.`ncont`=p.`ncont`
GROUP BY c.`ncont`;

/*c. Donner les informations du premier contribuable qui a payé une taxe*/
SELECT c.*
FROM `contribuable` as c, `payer_taxe` as p
WHERE c.`ncont`=p.`ncont`
GROUP BY c.`ncont`
ORDER BY p.`date` ASC
LIMIT 1;

/*d. Donner le nom, l’adresse et la date pour les 5 premiers contribuables qui ont fait des 
déclarations de type « spectacle » */
SELECT `nom`, `adr`, `date`,`type`
FROM `contribuable` as c, `declaration` as d
WHERE c.`ncont`=d.`ncont` and d.`type`="spectacle"
GROUP BY c.`ncont`
ORDER BY d.`date` ASC
LIMIT 5;

/* e. Donner le numéro et le nom des contribuables qui n’ont jamais payé d’amende. */
SELECT `tel`,`nom`
FROM `contribuable` 
WHERE `ncont` NOT IN (SELECT `ncont` FROM `payer_amende`);
