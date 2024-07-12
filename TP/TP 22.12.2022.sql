--Donner le nom et l’adresse des contribuables qui ont fait des déclarations 
--publicitaires
select `Nom`,`Adr` from `Declaration`, where `Ncont` 

select  from `Declaration` INNER JOIN `contribuable` WHERE `Ncont` = `Ncont`

--Donner le numéro et le nom du premier contribuable qui a payé une amende

select MIN(`Date`),`Tel`, `Nom` from `contribuable`, `payer_amende` where `contribuable`.`Ncont` = `payer_amende`.`Ncont`