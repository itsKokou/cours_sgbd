CREATE TABLE `contribuable`
(
    `Ncont` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `Nom` VARCHAR,
    `Ard` VARCHAR,
    `Tel` INT NOT NULL,
);
CREATE TABLE `Quittance`
(
    `Nquit` INT NOT NULL, 
    `DateQuit` DATE,
    `Libelle` VARCHAR,
    CONSTRAINT `Ncont` INT FOREIGN KEY  REFERENCES `contribuable`(`Ncont`)
);
CREATE TABLE `Taxes`
(
    `Ntaxe` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `type` VARCHAR,
    `montant` INT,
);
CREATE TABLE `PayerTaxe`
(
    `Ncont` INT FOREIGN KEY  REFERENCES `contribuable`(`Ncont`),
    `Ntaxe` INT FOREIGN KEY  REFERENCES `Taxes`(`Ntaxe`),
    PRIMARY KEY (`Ntaxe`,`Ncont`)
    `Date` DATE, 
    `Nquit` INT FOREIGN KEY  REFERENCES `Quittance`(`Nquit`),
);
CREATE TABLE `Declaration`
(
    `Ndec` INT NOT NULL PRIMARY KEY,
    `Libelle` VARCHAR,
    `Date` DATE,
    `Ncont` INT FOREIGN KEY REFERENCES `contribuable`(`Ncont`),
);
CREATE TABLE `Amende`
(
    `Namende` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `Libelle` VARCHAR,
    `Montant` INT NOT,
);
CREATE TABLE `PayerAmende`
(
    `Ncont` INT FOREIGN KEY  REFERENCES `contribuable`(`Ncont`),
    `Namende` INT FOREIGN KEY  REFERENCES `Amende`(`Namende`),
    PRIMARY KEY (`Ntaxe`,`Ncont`)
    `Date` DATE,
);
CREATE TABLE `contribuable`(`Ncont` INT,`Nom` VARCHAR(155),`Ard` VARCHAR(158),`Tel` INT);