CREATE DATABASE `my_db`
CREATE TABLE `fournisseur`
(
    `numF` INT PRIMARY KEY NOT NULL,
    `nomf` VARCHAR(60),
    `prenomf` VARCHAR(80),
    `adresse` VARCHAR(150), 
);
CREATE TABLE `commande`
(
    `numC` INT PRIMARY KEY NOT NULL,
    `dateAchat` DATE,
    `etat` VARCHAR(50),
    `prixliv` INT NOT NULL,
    `bonC` VARCHAR(1000),
    `numF` INT REFERENCES `fournisseur`(`numF`) 
);
CREATE TABLE `produit`
(
    `numP` INT PRIMARY KEY NOT NULL,
    `nomP` VARCHAR(60),
    `prixU` INT NOT NULL,
    `poids` INT ,
    `couleur` VARCHAR(50), 
);
CREATE TABLE `appartenir`
(
    `numC` INT REFERENCES `commande`(`numC`),
    `numP` INT REFERENCES `produit`(`numP`),
    PRIMARY KEY (`numP`,`numC`)
    `nbreProduit` INT,
);
