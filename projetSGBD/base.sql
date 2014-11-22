drop table ELEVE cascade constraints;
drop table AVIS cascade constraints;
drop table CONCERNE cascade constraints;
drop table S_INSCRIT_SUR_LISTE_D_ATTENTE cascade constraints;
drop table TRAJET_INTERMEDIARE cascade constraints;
drop table PARTICIPE_AU_VOYAGE cascade constraints;
drop table CONTIENT cascade constraints;
drop table ANNONCE cascade constraints;
drop table VOITURE cascade constraints;


-- ============================================================
--   Table : ELEVE                                            
-- ============================================================
create table ELEVE
(
    ADRESSE_MAIL                    CHAR(30)               not null,
    NOM_ELEVE                       CHAR(20)               not null,
    PRENOM_ELEVE                    CHAR(20)               not null,
    MOT_DE_PASSE                    CHAR(10)               not null,
    constraint pk_eleve primary key (ADRESSE_MAIL)
);


-- ============================================================
--   Table : AVIS                                            
-- ============================================================
create table AVIS
(
    NUMERO_AVIS	                    NUMBER(8)              not null,
    NOTE                            CHAR(20)               not null,
    COMMENTAIRE                     CHAR(255)                      ,
    ADRESSE_MAIL                    CHAR(30)               not null,
    NUMERO_ANNONCE		    NUMBER(8)		   not null,
    constraint pk_avis primary key (NUMERO_AVIS)
);

-- ============================================================
--   Table : CONCERNE                                             
-- ============================================================
create table CONCERNE
(
    NUMERO_AVIS                     CHAR(30)               not null,
    ADRESSE_MAIL                    CHAR(30)               not null,
    constraint pk_concerne primary key (NUMERO_AVIS,ADRESSE_MAIL)
);


-- ============================================================
--   Table : S_INSCRIT_SUR_LISTE_D_ATTENTE                                             
-- ============================================================
create table S_INSCRIT_SUR_LISTE_D_ATTENTE
(
    ADRESSE_MAIL                    CHAR(30)               not null,
    VILLE_MONTEE          	    CHAR(20)               not null,
    VILLE_DESCENTE                  CHAR(20)               not null,
    NUMERO_ANNONCE		    NUMBER(8) 		   not null,
    VILLE_DEPART 		    CHAR(20)			   ,
    VILLE_ARRIVEE 		    CHAR(20)			   ,
    DUREE_ESTIMEE 		    NUMBER(3)			   ,
    DISTANCE			    NUMBER(4)			   ,
    constraint pk_s_inscrit_sur_liste_d_attente primary key (NUMERO_ANNONCE,ADRESSE_MAIL,VILLE_DEPART,VILLE_ARRIVEE,DUREE_ESTIMEE,DISTANCE)
);


-- ============================================================
--   Table : TRAJET_INTERMEDIAIRE                                             
-- ============================================================
create table TRAJET_INTERMEDIAIRE
(
    VILLE_DEPART 		    CHAR(20)		   not null,
    VILLE_ARRIVEE 		    CHAR(20)		   not null,
    DUREE_ESTIMEE 		    NUMBER(3)		   not null,
    DISTANCE			    NUMBER(4)		   not null,
    constraint pk_trajet_intermediare primary key (VILLE_DEPART,VILLE_ARRIVEE,DUREE_ESTIMEE,DISTANCE)
);

-- ============================================================
--   Table : VOITURE                                            
-- ============================================================
create table VOITURE
(
NUMERO_VOITURE		CHAR(4)			not null,
TYPE			CHAR(20)    	    	not null,
COULEUR 		CHAR(10)	        not null,
NOMBRE_DE_PLACE		NUMBER(1)		not null,
ETAT			CHAR(10)		 	,
DIVERS			CHAR(255)			,
ADRESSE_MAIL		CHAR(30)		not null,
constraint pk_voiture primary key (NUMERO_VOITURE)
)

-- ============================================================
--   Table : ANNONCE                                            
-- ============================================================
create table ANNONCE
(
NUMERO_ANNONCE		NUMBER(8)		not null,
PRIX_PAR_PERSONNE	NUMBER(3)		not null,
DATE_DE_DEPART		DATE				,		
HEURE_DE_DEPART		TIME				,
NOMBRE_MAX_PLACE	NUMBER(1)		not null,
NUMERO_VOITURE		CHAR(4)			not null,
constraint pk_annonce primary key (NUMERO_ANNONCE)
)

-- ============================================================
--   Table : CONTIENT                                            
-- ============================================================
create table CONTIENT
(
NUMERO_ANNONCE		NUMBER(8)			not null,
VILLE_DEPART		CHAR(20)			not null,
VILLE_ARRIVEE		CHAR(20)			not null,
DUREE_ESTIMEE		NUMBER(3)				,
DISTANCE		NUMBER(4)				,
constraint pk_contient primary key (NUMERO_ANNONCE, VILLE_DEPART, VILLE_ARRIVEE, DUREE_ESTIMEE, DISTANCE)
)

-- ============================================================
--   Table : PARTICIPE_AU_VOYAGE                                            
-- ============================================================
create table PARTICIPE_AU_VOYAGE
(
ADRESSE_MAIL		CHAR(30)			not null,
NUMERO_ANNONCE		NUMBER(8)			not null,
constraint pk_participe primary key (NUMERO_ANNONCE, ADRESSE_MAIL)
	
)






alter table AVIS
    add constraint fk1_avis foreign key (NUMERO_ANNONCE)
       references ANNONCE (NUMERO_ANNONCE);

alter table AVIS
    add constraint fk2_avis foreign key (ADRESSE_MAIL)
       references ELEVE (ADRESSE_MAIL);

alter table CONCERNE
    add constraint fk1_concerne foreign key (NUMERO_AVIS)
       references AVIS (NUMERO_AVIS);

alter table CONCERNE
    add constraint fk2_concerne foreign key (ADRESSE_MAIL)
       references ELEVE (ADRESSE_MAIL);

alter table S_INSCRIT_SUR_LISTE_D_ATTENTE
    add constraint fk1_s_inscrit_sur_liste_d_attente foreign key (ADRESSE_MAIL)
       references ELEVE (ADRESSE_MAIL);

alter table S_INSCRIT_SUR_LISTE_D_ATTENTE
    add constraint fk2_s_inscrit_sur_liste_d_attente foreign key (NUMERO_ANNONCE)
       references ANNONCE (NUMERO_ANNONCE);

alter table S_INSCRIT_SUR_LISTE_D_ATTENTE
    add constraint fk3_s_inscrit_sur_liste_d_attente foreign key (VILLE_DEPART)
       references TRAJET_INTERMEDIARE (VILLE_DEPART);

alter table S_INSCRIT_SUR_LISTE_D_ATTENTE
    add constraint fk4_s_inscrit_sur_liste_d_attente foreign key (VILLE_ARRIVEE)
       references TRAJET_INTERMEDIARE (VILLE_ARRIVEE);

alter table S_INSCRIT_SUR_LISTE_D_ATTENTE
    add constraint fk5_s_inscrit_sur_liste_d_attente foreign key (DUREE_ESTIMEE)
       references TRAJET_INTERMEDIARE (DUREE_ESTIMEE);

alter table S_INSCRIT_SUR_LISTE_D_ATTENTE
    add constraint fk6_s_inscrit_sur_liste_d_attente foreign key (DISTANCE)
       references TRAJET_INTERMEDIARE (DISTANCE);

alter table VOITURE
    add constraint fk1_voiture foreign key (ADRESSE_MAIL)
       references ELEVE (ADRESSE_MAIL);

alter table CONTIENT
    add constraint fk1_contient foreign key (NUMERO_ANNONCE)
       references ANNONCE (NUMERO_ANNONCE);


alter table CONTIENT
    add constraint fk2_contient foreign key (VILLE_DEPART)
       references TRAJET_INTERMEDIAIRE (VILLE_DEPART);

alter table CONTIENT
    add constraint fk3_contient foreign key (VILLE_ARRIVEE)
       references TRAJET_INTERMEDIARE (VILLE_ARRIVEE);

alter table CONTIENT
    add constraint fk4_contient foreign key (DUREE_ESTIMEE)
       references TRAJET_INTERMEDIAIRE (DUREE_ESTIME);

alter table CONTIENT
    add constraint fk5_contient foreign key (DISTANCE)
       references TRAJET_INTERMEDIAIRE (DISTANCE);


alter table PARTICE_AU_VOYAGE
    add constraint fk1_participe_au_voyage foreign key (ADRESSE_MAIL)
       references ELEVE (ADRESSE_MAIL);


alter table PARTICE_AU_VOYAGE
    add constraint fk2_participe_au_voyage foreign key (NUMERO_ANNONCE)
       references ANNONCE (NUMERO_ANNONCE);






