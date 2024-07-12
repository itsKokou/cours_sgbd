--1 Donner le nom et l’adresse des contribuables qui ont fait des déclarations publicitaires 
select `Nom`,`Adr` 
from `contribuable`,`declaration` 
where `contribuable`.`Ncont`=`declaration`.`Ncont` and `libelle`='publicité'

--2  Donner le numéro et le nom du premier contribuable qui a payé une amende 
select `Tel`,`Nom` 
from `contribuable` as c ,`payer_amende` as p 
where c.`Ncont`=p.`Ncont` and `Date`=(select MIN(`Date`) from `payer_amende` )
-- Ou 
SELECT `Tel`,`Nom` 
FROM `contribuable` 
WHERE `Ncont`=( SELECT `Ncont` FROM `payer_amende` 
ORDER BY `Date` ASC
LIMIT 1
);
--3  Donner le numéro, le nom, le libellé et le montant totale de l’amande payé pour 
     /*chaque contribuable selon le type(libellé) d’amande */
select `Tel`,`Nom`,`libelle`, SUM(`montant`) 
FROM `contribuable` as c, `amende` as a, `payer_amende` as p 
where p.`Ncont`=c.`Ncont` and a.`Namende`=p.`Namende`
GROUP by p.`Ncont`;

--4 Donner le numéro, le nom et le montant moyen des taxes payées par chaque contribuable
select `Tel`,`Nom`, AVG(`montant`) as 'Montant Moyen'
from `payer_taxe` as p, `contribuable` as c, `taxes` as t
where p.`Ncont`=c.`Ncont` and t.`Ntaxe`=p.`Ntaxe`
group by p.`Ncont`;

--5 Donner le numéro, le nom, le libellé et le montant des contribuables ayant payé l’amade minimale
select `Tel` as "Numéro",`Nom`,`libelle`,`montant`
from `contribuable` as c, `amende` as a, `payer_amende` as p 
where p.`Ncont`=c.`Ncont` and a.`Namende`=p.`Namende` and `montant` = (select MIN(`montant`) from `amende`)

--6 Donner le numéro, le nom le libellé et le montant des contribuables ayant payé la taxe maximale
select `Tel` as "Numéro",`Nom`,`type`,`montant`
from `contribuable` as c, `taxes` as t, `payer_taxe` as p 
where p.`Ncont`=c.`Ncont` and t.`Ntaxe`=p.`Ntaxe` and `montant` = (select MAX(`montant`) from `taxes`)

--7 Donner le numéro, le nom le libellé et le montant des 5(cinq) premiers contribuables ayant payé la taxe maximale
select c.`Ncont`,`Tel` as "Numéro",`Nom`,`type`,`montant`
from `contribuable` as c, `taxes` as t, `payer_taxe` as p 
where p.`Ncont`=c.`Ncont` and t.`Ntaxe`=p.`Ntaxe` and `montant` = (select MAX(`montant`) from `taxes`)
ORDER BY `Date` ASC
limit 5;

--8 Donner le libelle de la déclaration, le montant de la taxe et le nom du
    /*contribuable des taxes payées le 2020-06-05*/
select `libelle`, `montant`, `nom`
from `declaration` d, `taxes` t,`payer_taxe` p, `contribuable` c
where p.`Ncont`=c.`Ncont` and t.`Ntaxe`=p.`Ntaxe` and d.`Ncont`=c.`Ncont` and p.`date`=d.`date` and p.`date`='2020-06-05'
group by c.`Ncont`

--9 Donner le numéro et le nom des contribuables qui ont individuellement payé au 
    --total plus de 500.000F d’amende pour des déclarations de spectacles.
select `Tel`,`Nom` 
from `contribuable` as c ,`amende` as a,`payer_amende` as p, `declaration` d 
where p.`Ncont`=c.`Ncont` and a.`Namende`=p.`Namende` and d.`Ncont`=c.`Ncont` and d.`libelle`="spectacle"
GROUP BY c.`Ncont`
HAVING SUM(`montant`)>500000;

--10 Donner séparément les montants totaux des taxes de spectacles ou de publicités (une seule instruction SQL)
select SUM(`montant`) as 'Montant Total'
from `taxes`
where `type`="spectacle"
UNION
select SUM(`montant`) as 'Montant Total'
from `taxes`
where `type`="publicité"

--11 Donner le numéro et le nom des contribuables qui ont individuellement payé au 
    --total plus de 500.000F d’amende pour des déclarations de spectacles.
select `Tel`,`Nom` 
from `contribuable` as c ,`amende` as a,`payer_amende` as p, `declaration` d 
where p.`Ncont`=c.`Ncont` and a.`Namende`=p.`Namende` and d.`Ncont`=c.`Ncont` and d.`libelle`="spectacle"
GROUP BY c.`Ncont`,p.`Namende`
HAVING ROUND(SUM(`montant`))>500000;

--12 Donner le numéro et le nom des contribuables qui n’ont jamais payé d’amende
select DISTINCT `Tel` as 'Numéro', `nom`
from `contribuable`
where `Ncont` not IN (select `Ncont` from `payer_amende`)

--13 Donner le numéro et le nom des contribuables qui ont individuellement payé au total plus de quatre (4) amendes
select DISTINCT `Tel` as 'Numéro', `nom`
from `contribuable` c ,`payer_amende` p 
where p.`Ncont`=c.`Ncont` 
GROUP by c.`Ncont`
HAVING count(p.`Ncont`)>4;

--14 Donner le numéro et le nom du contribuable qui a payé plus de taxe
select DISTINCT  `Tel` as 'Numéro', `nom`
from `contribuable` c ,`payer_taxe` p 
where p.`Ncont`=c.`Ncont` 
GROUP by c.`Ncont` 
ORDER BY count(p.`ncont`) DESC
LIMIT 1;

--15 Donner les informations des contribuables qui habitent paris
select *
from `contribuable`
where `adr` LIKE "%poirier%"; 

--16 Donner le numéro et le nom des contribuables qui n’ont jamais payé d’amende.
select DISTINCT  `Tel` as 'Numéro', `nom`
from `contribuable`
where `ncont` NOT IN (select `ncont` from `payer_amende`)

--17 Donner le numéro et le nom des contribuables qui ont fait des déclarations entre 
    --le 4 avril 2020 et le 15 ou entre le 19Mai et le 25 mai
select DISTINCT  `Tel` as 'Numéro', `nom`
from `contribuable`
where `ncont` IN (select `ncont` from `declaration` where `date` BETWEEN '2020-04-04' and '2020-04-15' or `date` BETWEEN '2020-05-19' and '2020-05-25')
/* ou  */  
select DISTINCT  `Tel` as 'Numéro', `nom`
from `contribuable` c, `declaration` d 
where c.`ncont` = d.`ncont` and 
   ((`date` BETWEEN '2020-04-04' and '2020-04-15') or (`date` BETWEEN '2020-05-19' and '2020-05-25'))

--18 Donner le numéro et le nom, le mois et la taxe total payée par chaque contribuable par mois
select DISTINCT `Tel` as 'Numéro', `nom`, SUM(`montant`) as 'Taxe totale', MONTH(`date`) as 'Mois'
from `contribuable` as c, `taxes` as t, `payer_taxe` as p 
where p.`Ncont`=c.`Ncont` and t.`Ntaxe`=p.`Ntaxe`
group by c.`Ncont`, MONTH(`date`)

--19 Donnez les informations des contribuables dont le nom contient entre 4 et 6 caractères.
select *
from `contribuable`
HAVING length(`nom`) between 4 and 6
group by `ncont`

