DROP DATABASE IF EXISTS DNE;
CREATE DATABASE DNE;
USE DNE;

CREATE TABLE Personne(
    idPersonne INT(10),
    nom VARCHAR(45) NOT NULL,
    prenom VARCHAR(45) NOT NULL,
    CONSTRAINT pk_personne PRIMARY KEY(idPersonne)
);

CREATE TABLE InterneUniv(
    idInterne INT(10),
    idUniv VARCHAR(45) NOT NULL,
    emailUniv VARCHAR(320),
    CONSTRAINT pk_interneUniv PRIMARY KEY(idInterne),
    CONSTRAINT fk_interneUniv_personne FOREIGN KEY(idInterne) REFERENCES Personne(idPersonne)
);

CREATE TABLE Etudiant(
    idEtudiant INT(10),
    dateNaissance DATE,
    emailPersonnel VARCHAR(320),
    numeroTelephone VARCHAR(20),
    CONSTRAINT pk_etudiant PRIMARY KEY(idEtudiant),
    CONSTRAINT fk_etudiant_interneUniv FOREIGN KEY(idEtudiant) REFERENCES InterneUniv(idInterne)
);

CREATE TABLE Employe(
    idEmploye INT(10),
    telephoneUniv VARCHAR(20),
    bureau VARCHAR(45),
    CONSTRAINT pk_employe PRIMARY KEY(idEmploye), 
    CONSTRAINT fk_employe_interneUniv FOREIGN KEY(idEmploye) REFERENCES InterneUniv(idInterne)
);

CREATE TABLE Administratif(
    idAdministratif INT(10),
    fonction VARCHAR(45),
    CONSTRAINT pk_administratif PRIMARY KEY(idAdministratif),
    CONSTRAINT fk_administratif_employe FOREIGN KEY(idAdministratif) REFERENCES Employe(idEmploye)
);

CREATE TABLE Enseignant(
    idEnseignant INT(10),
    estVacataire BOOLEAN,
    telephone VARCHAR(20),
    CONSTRAINT pk_enseignant PRIMARY KEY(idEnseignant),
    CONSTRAINT fk_enseignant_employe FOREIGN KEY(idEnseignant) REFERENCES Employe(idEmploye)
);

CREATE TABLE ResponsableFormation(
    idResponsableFormation INT(10),
    CONSTRAINT pk_responsableFormation PRIMARY KEY(idResponsableFormation),
    CONSTRAINT fk_responsableFormation_enseignant FOREIGN KEY(idResponsableFormation) REFERENCES Enseignant(idEnseignant)
);

CREATE TABLE Tuteur(
    idTuteur INT(10),
    emailPro VARCHAR(320),
    telephonePro VARCHAR(20),
    societe VARCHAR(100),
    CONSTRAINT pk_tuteur PRIMARY KEY(idTuteur),
    CONSTRAINT fk_tuteur_personne FOREIGN KEY(idTuteur) REFERENCES Personne(idPersonne)
);

CREATE TABLE Communication(
    idCommunication INT(10),
    idEtudiant INT(10),
    idEmploye INT(10),
    dateHeure DATETIME,
    nature VARCHAR(20),
    description TEXT,
    CONSTRAINT pk_communication PRIMARY KEY(idCommunication),
    CONSTRAINT fk_communication_etudiant FOREIGN KEY(idEtudiant) REFERENCES Etudiant(idEtudiant),
    CONSTRAINT fk_communication_employe FOREIGN KEY(idEmploye) REFERENCES Employe(idEmploye)
);

CREATE TABLE Matiere(
    idMatiere INT(10),
    codeMatiere VARCHAR(45),
    quotaHeure TINYINT(1) UNSIGNED,
    creditsECTS TINYINT(1) UNSIGNED,
    intitule VARCHAR(100),
    description TEXT,
    semestre TINYINT(1) UNSIGNED,
    CONSTRAINT pk_matiere PRIMARY KEY(idMatiere)
);

CREATE TABLE UE(
    idUE INT(10),
    intitule VARCHAR(100),
    CONSTRAINT pk_ue PRIMARY KEY(idUE)
);

CREATE TABLE Diplome(
    idDiplome INT(10),
    intitule VARCHAR(100),
    totalECTS TINYINT(1) UNSIGNED,
    estActif BOOLEAN,
    CONSTRAINT pk_diplome PRIMARY KEY(idDiplome)
);

CREATE TABLE Promotion(
    idPromotion INT(10),
    annee DATE,
    idDiplome INT(10),
    idResponsableFormation INT(10),
    CONSTRAINT pk_promotion PRIMARY KEY(idPromotion),
    CONSTRAINT fk_promotion_diplome FOREIGN KEY(idDiplome) REFERENCES Diplome(idDiplome),
    CONSTRAINT fk_promotion_responsableFormation FOREIGN KEY(idResponsableFormation) REFERENCES ResponsableFormation(idResponsableFormation)
);

CREATE TABLE Inscrire(
    idEtudiant INT(10),
    idPromotion INT(10),
    idTuteur INT(10), 
    CONSTRAINT pk_inscrire PRIMARY KEY(idEtudiant, idPromotion),
    CONSTRAINT fk_inscrire_etudiant FOREIGN KEY(idEtudiant) REFERENCES Etudiant(idEtudiant),
    CONSTRAINT fk_inscrire_promotion FOREIGN KEY(idPromotion) REFERENCES Promotion(idPromotion),
    CONSTRAINT fk_inscrire_tuteur FOREIGN KEY(idTuteur) REFERENCES Tuteur(idTuteur)
);

CREATE TABLE MatiereDansUE(
    idMatiere INT(10),
    idUE INT(10),
    CONSTRAINT pk_matiereDansUE PRIMARY KEY(idMatiere, idUE),
    CONSTRAINT fk_matiereDansUE_matiere FOREIGN KEY(idMatiere) REFERENCES Matiere(idMatiere),
    CONSTRAINT fk_matiereDansUE_UE FOREIGN KEY(idUE) REFERENCES UE(idUE)
);

CREATE TABLE UEDansDiplome(
    idUE INT(10),
    idDiplome INT(10),
    CONSTRAINT pk_UEDansDiplome PRIMARY KEY(idUE, idDiplome),
    CONSTRAINT fk_UEDansDiplome_UE FOREIGN KEY(idUE) REFERENCES UE(idUE),
    CONSTRAINT fk_UEDansDiplome_diplome FOREIGN KEY(idDiplome) REFERENCES Diplome(idDiplome)    
);

CREATE TABLE Note(
    idNote INT(10),
    idEtudiant INT(10),
    idMatiere INT(10),
    idUE INT(10),
    idDiplome INT(10),
    idPromotion INT(10),
    note TINYINT(1) UNSIGNED,
    dateObtention DATETIME,
    coefficient TINYINT(1) UNSIGNED,
    typeNote VARCHAR(45),
    estVisible BOOLEAN,
    CONSTRAINT pk_note PRIMARY KEY(idNote),
    CONSTRAINT fk_note_etudiant FOREIGN KEY(idEtudiant) REFERENCES Etudiant(idEtudiant),
    CONSTRAINT fk_note_matiere FOREIGN KEY(idMatiere) REFERENCES Matiere(idMatiere),
    CONSTRAINT fk_note_ue FOREIGN KEY(idUE) REFERENCES UE(idUE),
    CONSTRAINT fk_note_diplome FOREIGN KEY(idDiplome) REFERENCES Diplome(idDiplome),
    CONSTRAINT fk_note_promotion FOREIGN KEY(idPromotion) REFERENCES Promotion(idPromotion)
);

CREATE TABLE Session(
    idSession INT(10),
    dateHeure DATETIME,
    duree TINYINT(1) UNSIGNED,
    salle VARCHAR(45),
    idMatiere INT(10) NOT NULL,
    idUE INT(10) NOT NULL,
    idDiplome INT(10) NOT NULL,
    idPromotion INT(10) NOT NULL,
    CONSTRAINT pk_session PRIMARY KEY(idSession),
    CONSTRAINT fk_session_matiere FOREIGN KEY(idMatiere) REFERENCES Matiere(idMatiere),
    CONSTRAINT fk_session_ue FOREIGN KEY(idUE) REFERENCES UE(idUE),
    CONSTRAINT fk_session_diplome FOREIGN KEY(idDiplome) REFERENCES Diplome(idDiplome),
    CONSTRAINT fk_session_promotion FOREIGN KEY(idPromotion) REFERENCES Promotion(idPromotion)
);

CREATE TABLE AnimerSession(
    idEnseignant INT(10),
    idSession INT(10),
    estPresent BOOLEAN,
    CONSTRAINT pk_animerSession PRIMARY KEY(idEnseignant, idSession),
    CONSTRAINT fk_animerSession_enseignant FOREIGN KEY(idEnseignant) REFERENCES Enseignant(idEnseignant),
    CONSTRAINT fk_animerSession_session FOREIGN KEY(idSession) REFERENCES Session(idSession)
);

CREATE TABLE AssisterSession(
    idEtudiant INT(10),
    idSession INT(10),
    estPresent BOOLEAN,
    CONSTRAINT pk_assisterSession PRIMARY KEY(idEtudiant, idSession),
    CONSTRAINT fk_assisterSession_enseignant FOREIGN KEY(idEtudiant) REFERENCES Etudiant(idEtudiant),
    CONSTRAINT fk_assisterSession_session FOREIGN KEY(idSession) REFERENCES Session(idSession)
);

CREATE TABLE Enseigner(
    idEnseignant INT(10),
    idMatiere INT(10),
    idUE INT(10),
    idDiplome INT(10),
    idPromotion INT(10),
    CONSTRAINT pk_enseigner PRIMARY KEY(idEnseignant, idMatiere, idUE, idDiplome, idPromotion),
    CONSTRAINT fk_enseigner_enseignant FOREIGN KEY(idEnseignant) REFERENCES Enseignant(idEnseignant),
    CONSTRAINT fk_enseigner_matiere FOREIGN KEY(idMatiere) REFERENCES Matiere(idMatiere),
    CONSTRAINT fk_enseigner_ue FOREIGN KEY(idUE) REFERENCES UE(idUE),
    CONSTRAINT fk_enseigner_diplome FOREIGN KEY(idDiplome) REFERENCES Diplome(idDiplome),
    CONSTRAINT fk_enseigner_promotion FOREIGN KEY(idPromotion) REFERENCES Promotion(idPromotion)
);

