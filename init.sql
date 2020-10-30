DROP DATABASE IF EXISTS DNE;
CREATE DATABASE DNE;
USE DNE;


CREATE TABLE Responsable(
  id int(8),
  nom varchar(25) not null,
  prenom varchar(25) not null,
  mail varchar(320) not null,
  CONSTRAINT pk_id PRIMARY KEY(id)
);


CREATE TABLE Formation(
  id int(8),
  nom varchar(25) not null,
  annnee int(4) not null,
  idResponsable int(8),
  CONSTRAINT pk_id PRIMARY KEY(id),
  CONSTRAINT fk_Formation_Responsable FOREIGN KEY(idResponsable) REFERENCES Responsable(id)

);


CREATE TABLE Etudiant(
  id int(10),
  nom varchar(25) not null,
  prenom varchar(25) not null,
  mail varchar(320) not null,
  idFormation int(8),
  CONSTRAINT pk_id PRIMARY KEY(id),
  CONSTRAINT fk_Etudiant_Formation FOREIGN KEY(idFormation) REFERENCES Formation(id)
);

CREATE TABLE Appartenir(
  idEtudiant int(10),
  idFormation int(8),
  effectif int(2),
  CONSTRAINT pk_id PRIMARY KEY(idEtudiant,idFormation),
  CONSTRAINT fk_Appartenir_Etudiant FOREIGN KEY(idEtudiant) REFERENCES Etudiant(id),
  CONSTRAINT fk_Appartenir_Formationc FOREIGN KEY(idFormation) REFERENCES Formation(id)
);

CREATE TABLE Tuteur(
  id int(8),
  nom varchar(25) not null,
  prenom varchar(25) not null,
  mail varchar(320) not null,
  societe varchar(25) not null,
  idEtudiant int(10),
  CONSTRAINT pk_id PRIMARY KEY(id),
  CONSTRAINT fk_Tuteur_Etudiant FOREIGN KEY(idEtudiant) REFERENCES Etudiant(id)
);


CREATE TABLE PersonnelAdministratif(
  id int(8),
  nom varchar(25) not null,
  prenom varchar(25) not null,
  mail varchar(320) not null,
  CONSTRAINT pk_id PRIMARY KEY(id)
);


CREATE TABLE Message(
  id int(8),
  contenu text,
  dateMessage timestamp,
  idAdministratif int(8),
  idEtudiant int(10),
  CONSTRAINT pk_id PRIMARY KEY(id),
  CONSTRAINT fk_Message_PersonnelAdministratif FOREIGN KEY(idAdministratif) REFERENCES PersonnelAdministratif(id),
  CONSTRAINT fk_Message_Etudiant FOREIGN KEY(idEtudiant) REFERENCES Etudiant(id)
);


CREATE TABLE Ue(
  id int(8),
  nom varchar(25),
  CONSTRAINT pk_id PRIMARY KEY(id)
);


CREATE TABLE Matiere(
  id int(8),
  nom varchar(25),
  coefficient int(1),
  CONSTRAINT pk_id PRIMARY KEY(id)
);

CREATE TABLE Comporte(
  idUe int(8),
  idMatiere int(8),
  coefficient int(1),
  CONSTRAINT pk_id PRIMARY KEY(idUe,idMatiere),
  CONSTRAINT fk_Comporte_Ue FOREIGN KEY(idUe) REFERENCES Ue(id),
  CONSTRAINT fk_Comporte_Matiere FOREIGN KEY(idMatiere) REFERENCES Matiere(id)
);

CREATE TABLE Salle(
  id int(8),
  numSalle varchar(10) UNIQUE,
  nbPlace int(3),
  CONSTRAINT pk_id PRIMARY KEY(id)
);


CREATE TABLE Intervenant(
  id int(8),
  nom varchar(25) not null,
  prenom varchar(25) not null,
  mail varchar(320) not null,
  CONSTRAINT pk_id PRIMARY KEY(id)
);


CREATE TABLE Cours(
  id int(8),
  heureDebut timestamp,
  heureFin timestamp,
  numSalle varchar(10),
  idMatiere int(8),
  idIntervenant int(8),
  idFormation int(8),
  CONSTRAINT pk_id PRIMARY KEY(id),
  CONSTRAINT fk_Cours_Salle FOREIGN KEY(numSalle) REFERENCES Salle(numSalle),
  CONSTRAINT fk_Cours_Matiere FOREIGN KEY(idMatiere) REFERENCES Matiere(id),
  CONSTRAINT fk_Cours_Intervenant FOREIGN KEY(idIntervenant) REFERENCES Intervenant(id),
  CONSTRAINT fk_Cours_Formation FOREIGN KEY(idFormation) REFERENCES Formation(id)
);

CREATE TABLE Possede(
  idMatiere int(8),
  idCours int(8),
  nbHeure int(3),
  CONSTRAINT pk_id PRIMARY KEY(idMatiere,idCours),
  CONSTRAINT fk_Possede_Matiere FOREIGN KEY(idMatiere) REFERENCES Matiere(id),
  CONSTRAINT fk_Possede_Cours FOREIGN KEY(idCours) REFERENCES Cours(id)
);


CREATE TABLE Note(
  id int(8),
  visible tinyint,
  idMatiere int(8),
  idEtudiant int(10),
  idIntervenant int(8),
  idFormation int(8),
  coefficient int(1),
  CONSTRAINT pk_id PRIMARY KEY(id),
  CONSTRAINT fk_Note_Matiere FOREIGN KEY(idMatiere) REFERENCES Matiere(id),
  CONSTRAINT fk_Note_Etudiant FOREIGN KEY(idEtudiant) REFERENCES Etudiant(id),
  CONSTRAINT fk_Note_Intervenant FOREIGN KEY(idIntervenant) REFERENCES Intervenant(id),
  CONSTRAINT fk_Note_Formation FOREIGN KEY(idFormation) REFERENCES Formation(id)
);

CREATE TABLE Participer(
	idCours int(8),
    idEtudiant int(10),
    present tinyint,
    CONSTRAINT pk_id PRIMARY KEY(idCours,idEtudiant),
    CONSTRAINT fk_Participer_Cours FOREIGN KEY(idCours) REFERENCES Cours(id),
    CONSTRAINT fk_Participer_Etudiant FOREIGN KEY(idEtudiant) REFERENCES Etudiant(id)
);
