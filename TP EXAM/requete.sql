/*requete 1
SUM
Donner le numéro, le nom, le libellé et le montant totale de l’amande payé pour 
chaque contribuable selon le type(libellé) d’amande
**********/
select `tel`,`nom`,`libelle`,SUM(`montant`)
from `contribuable` c, `payer_amende`  p, `amende` a
where c.`ncont`=p.`ncont` and a.`Namende`=p.`Namende`
group by c.`ncont`;

/******requete 2
AVG
Donner le numéro, le nom et le montant moyen des taxes payées par chaque
contribuable
***********/
selec `tel` "Numero", `nom`, round(AVG(`montant`)) "montant moyen"
from `contribuable` c,`taxes` t, `payer_taxe` p
where c.`ncont`=p.`ncont` and t.`ntaxe`=p.`ntaxe`
group by p.`ncont`;

/*******requete 3
MIN
Donner le numéro, le nom le libellé et le montant des contribuables ayant payé 
l’amande minimale
************/
SELECT `tel`,`nom`,`libelle`,`montant` 
FROM `contribuable` as c, `payer_amende` as p, `amende` as a
WHERE p.`ncont`=c.`ncont` and p.`namende`=a.`namende` and `montant`= (SELECT MIN(`montant`) FROM `amende`)
GROUP BY p.`ncont`;

/**********requete 4
ORDER BY
Donner le numéro, le nom le libellé et le montant des 5(cinq) premiers 
contribuables ayant payé la taxe maximale
************/
SELECT `tel`,`nom`,`libelle`,`montant` 
FROM `contribuable` as c, `payer_amende` as p, `amende` as a
WHERE p.`ncont`=c.`ncont` and p.`namende`=a.`namende` and `montant`= (SELECT `montant` FROM `amende` ORDER BY `montant` ASC LIMIT 1)
GROUP BY p.`ncont`;

/*******requete 5
- MAX
Donner le numéro, le nom le libellé et le montant des contribuables ayant payé la 
taxe maximale
***********/
SELECT c.`tel`, c.`nom`,q.`libelle`,t.`montant`
FROM `contribuable` c, `taxes` t, `payer_taxe` p, `quittance` q
WHERE c.`ncont`=p.`ncont` and p.`ntaxe`=t.`ntaxe` and p.`ncont`=q.`ncont` and t.`montant`=(SELECT MAX(`montant`) FROM `taxes`)
GROUP BY c.`ncont`;

/********requete 6
ORDER BY
Donner le numéro, le nom le libellé et le montant des 5(cinq) premiers 
contribuables ayant payé la taxe maximale
**********/
SELECT c.`tel`, c.`nom`,q.`libelle`,t.`montant`
FROM `contribuable` c, `taxes` t, `payer_taxe` p, `quittance` q
WHERE c.`ncont`=p.`ncont` and p.`ntaxe`=t.`ntaxe` and p.`ncont`=q.`ncont` and t.`montant`=(SELECT MAX(`montant`) FROM `taxes`)
GROUP BY c.`ncont`;
ORDER BY p.`date` ASC
LIMIT 5; 

/**********requete 7
GROUP BY
Donner le libelle de la déclaration, le montant de la taxe et le nom du 
contribuable des taxes payées le 2020-06-05
**********/
select   declaration.libelle, contribuable.nom, taxes.montant
from payer_taxe,  taxes,  contribuable, declaration 
where declaration.ncont=contribuable.ncont and taxes.ntaxes=payet_taxe.ntaxe and contribuable.ncont=payer_taxe.ncont and payer_taxe.date='2020-06-05'
GROUP BY cobtribuable.ncont;

/*********requete 8
- HAVING
Donner le numéro et le nom des contribuables qui ont individuellement payé au 
total plus de 500.000F d’amende pour des déclarations de spectacles.
**********/
SELECT `nom`, `tel`
FROM  contribuable , amende, declaration, payer_amende
where contribuable.ncont = payer_amende.ncont and payer_amende.namende =amende.namende and declaration.ncont =c ontribuable.ncont and declaration.libelle='spectacle'
group by payer_amende.ncont
HAVING SUM(amende.montant)> 500000

/*******requete 9
UNION
Donner séparément les montants totaux des taxes de spectacles ou de publicités
(une seule instruction SQL)
**********/
SELECT SUM(`montant`) FROM taxes WHERE taxes.type="spectacle"
UNION
SELECT SUM(`montant`) FROM taxes WHERE taxes.type="publicite";


/*require 10
ROUND
Donner le numéro et le nom des contribuables qui ont individuellement payé au 
total plus de 500.000F d’amende pour des déclarations de spectacles.
*/
SELECT `tel`, `nom`
FROM contribuable, amende, declaration,payer_amende
WHERE contribuable.ncont=payer_amende.ncont and payer_amende.namende=amende.namende and declaration.ncont=contribuable.ncont and declaration.libelle="spectacle"
GROUP BY payer_amende.ncont
HAVING ROUND(SUM(amende.montant))>500000;

/*****requete 11
DISTINCT
Donner le numéro et le nom des contribuables qui n’ont jamais payé d’amende
***********/
SELECT DISTINCT  `tel`,`nom`
FROM contribuable
WHERE `ncont` NOT IN (SELECT `ncont` FROM payer_amende);
---------ou aussi----------
SELECT DISTINCT `tel`,`nom` 
FROM `contribuable` c 
WHERE c.ncont != ALL(SELECT DISTINCT `ncont` FROM `payer_amende`);

/*****requete 12
COUNT
Donner le numéro et le nom des contribuables qui ont individuellement payé au 
total plus de quatre (4) amende
****************/
SELECT `tel`, `nom`
FROM contribuable c, payer_amende p
WHERE c.ncont=p.ncont
GROUP BY p.ncont
HAVING COUNT(p.ncont)>4;

/******requete 13
total plus de quatre (4) amendes
- LIMIT
Donner le numéro et le nom du contribuable qui a payé plus de taxe
************/
SELECT `tel`, `nom`
FROM contribuable c, payer_taxe p
WHERE c.ncont=p.ncont
GROUP BY p.ncont
ORDER BY COUNT(p.ncont) DESC
LIMIT 1;

/*******requete 14
LIKE %% (B%A)
Donner les informations des contribuables qui habitent paris
***********/
SELECT * 
FROM contribuable
WHERE `adr` LIKE '%paris%'
GROUP BY contribuable.ncont;

/******requete 15
BETWEEN
Donner le numéro et le nom des contribuables qui ont fait des déclarations entre 
le 4 avril 2020 et le 15 ou entre le 19Mai et le 25 mai
*********************/
SELECT `tel`,`nom`
FROM contribuable as c, declaration as d
WHERE c.ncont=d.ncont and ((d.date BETWEEN '2020-04-04' AND '2020-04-15') OR (d.date BETWEEN '2020-05-19' AND '2020-05-25')) 
GROUP By c.ncont;

/*********requete 16
Donner le numéro et le nom, le mois et la taxe total payée par chaque
contribuable par mois
**********/
SELECT `tel`, `nom`,MONTH(p.date),SUM(t.montant)
FROM contribuable c, taxes t, payer_taxe p 
WHERE c.ncont=p.ncont and t.ntaxe=p.ntaxe 
GROUP BY p.ncont, MONTH(p.date);

/*******requete 17
Donnez les informations des contribuables dont le nom contient entre 4 et 6 
caractères
***********/
SELECT * 
FROM contribuable
WHERE LENGTH(nom) BETWEEN 4 AND 6;


