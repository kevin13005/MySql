CREATE DATABASE Subvention;
USE Subvention;

DROP TABLE IF EXISTS Region;
CREATE TABLE Region(numregion INT NOT NULL,
nomregion VARCHAR(30) NOT NULL,
numPays INT NOT NULL,
PRIMARY KEY (numregion));

DROP TABLE IF EXISTS pays;
CREATE TABLE pays(numpays INT NOT NULL,
nompays VARCHAR(30)NOT NULL,
capitale VARCHAR(30) NOT NULL,
tauxcroissmoyen DECIMAL(4,1),
PRIMARY KEY (numpays));

DROP TABLE IF EXISTS subventions;
CREATE TABLE subventions(CodeType INT NOT NULL,
subvention INT NOT NULL,
LibelléTypeSubvention VARCHAR(30) NOT NULL,
PRIMARY KEY (CodeType));

DROP TABLE IF EXISTS annee;
CREATE TABLE annee(annee INT NOT NULL,
PRIMARY KEY (annee));

DROP TABLE IF EXISTS enveloppe;
CREATE TABLE enveloppe(numregion INT NOT NULL,
CodeType INT NOT NULL,
subvention INT NOT NULL,
annee INT NOT NULL,
montant INT NOT NULL,
PRIMARY KEY (numregion, CodeType, annee));

DROP TABLE IF EXISTS renseignement;
CREATE TABLE renseignement(numpays INT NOT NULL,
annee INT NOT NULL,
tauxcroiss DECIMAL(4, 1) NOT NULL,
population INT NOT NULL,
PRIMARY KEY (numpays, annee));

ALTER TABLE Region
ADD CONSTRAINT FK_Region_pays FOREIGN KEY (numpays)
REFERENCES pays(numpays);

ALTER TABLE renseignement
ADD CONSTRAINT FK_renseignement_pays FOREIGN KEY (numpays)
REFERENCES pays(numpays);

ALTER TABLE renseignement
ADD CONSTRAINT FK_renseignement_annee FOREIGN KEY (annee)
REFERENCES annee(annee);

ALTER TABLE enveloppe
ADD CONSTRAINT FK_enveloppe_Region FOREIGN KEY (numregion)
REFERENCES Region(numregion);

ALTER TABLE enveloppe
ADD CONSTRAINT FK_enveloppe_annee FOREIGN KEY (annee)
REFERENCES annee(annee);

ALTER TABLE enveloppe
ADD CONSTRAINT FK_enveloppe_subventions FOREIGN KEY (CodeType)
REFERENCES subventions(CodeType);



