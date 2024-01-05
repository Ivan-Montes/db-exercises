TRUNCATE TABLE employee;
TRUNCATE TABLE pub_info;
TRUNCATE TABLE jobs;
TRUNCATE TABLE discounts;
TRUNCATE TABLE roysched;
TRUNCATE TABLE sales;
TRUNCATE TABLE stores;
TRUNCATE TABLE titleauthor;
TRUNCATE TABLE titles;
TRUNCATE TABLE publishers;
TRUNCATE TABLE authors;

DROP TABLE employee;
DROP TABLE pub_info;
DROP TABLE jobs;
DROP TABLE discounts;
DROP TABLE roysched;
DROP TABLE sales;
DROP TABLE stores;
DROP TABLE titleauthor;
DROP TABLE titles;
DROP TABLE publishers;
DROP TABLE authors;

DROP SEQUENCE job_id_seq;


CREATE TABLE authors
(
   au_id          VARCHAR2(12)

         CONSTRAINT check_au_id CHECK (REGEXP_LIKE(au_id, '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]'))

         CONSTRAINT UPKCL_auidind PRIMARY KEY,

   au_lname       VARCHAR2(40) NOT NULL,
   au_fname       VARCHAR2(20) NOT NULL,

   phone          CHAR(12) DEFAULT ('UNKNOWN') NOT NULL,
   address        VARCHAR2(40),
   city           VARCHAR2(20),
   state          CHAR(2),

   zip            CHAR(5)

         CONSTRAINT check_zip CHECK (REGEXP_LIKE(zip, '[0-9][0-9][0-9][0-9][0-9]')),

   contract       NUMBER(1,0)       NOT NULL
);

CREATE TABLE publishers
(
   pub_id         CHAR(4)           NOT NULL

         CONSTRAINT UPKCL_pubind PRIMARY KEY

         CONSTRAINT check_pub_id CHECK (pub_id in ('1389', '0736', '0877', '1622', '1756')
            OR REGEXP_LIKE(pub_id, '99[0-9][0-9]')),

   pub_name       VARCHAR2(40),
   city           VARCHAR2(20),
   state          CHAR(2),

   country        VARCHAR2(30)

         DEFAULT('USA')
);

CREATE TABLE titles
(
   title_id       VARCHAR2(20)

         CONSTRAINT UPKCL_titleidind PRIMARY KEY,

   title          VARCHAR2(80)       NOT NULL,

   type           CHAR(12)  DEFAULT ('UNDECIDED') NOT NULL,

   pub_id         CHAR(4)

         REFERENCES publishers(pub_id),

   price          NUMBER(10,2)           NULL,
   advance        NUMBER(10,2)           NULL,
   royalty        NUMBER(10,0)           NULL,
   ytd_sales      NUMBER(10,0)           NULL,
   notes          VARCHAR2(200)          NULL,

   pubdate        DATE  DEFAULT (SYSDATE) NOT NULL
);
CREATE TABLE titleauthor
(
   au_id          VARCHAR2(12)

         REFERENCES authors(au_id),

   title_id       VARCHAR2(20)

         REFERENCES titles(title_id),

   au_ord         NUMBER(3,0)           NULL,
   royaltyper     NUMBER(10,0)           NULL,

   CONSTRAINT UPKCL_taind PRIMARY KEY (au_id, title_id)
);
CREATE TABLE stores
(
   stor_id        CHAR(4)           NOT NULL

         CONSTRAINT UPK_storeid PRIMARY KEY,

   stor_name      VARCHAR2(40),
   stor_address   VARCHAR2(40),
   city           VARCHAR2(20),
   state          CHAR(2),
   zip            CHAR(5)
);

CREATE TABLE sales
(
   stor_id        CHAR(4) REFERENCES stores(stor_id)  NOT NULL,
   ord_num        VARCHAR2(20)       NOT NULL,
   ord_date       DATE          NOT NULL,
   qty            NUMBER(5,0)          NOT NULL,
   payterms       VARCHAR2(12)       NOT NULL,
   title_id       VARCHAR2(20) REFERENCES titles(title_id),

   CONSTRAINT UPKCL_sales PRIMARY KEY (stor_id, ord_num, title_id)
);

CREATE TABLE roysched
(
   title_id       VARCHAR2(20) REFERENCES titles(title_id),
   lorange        NUMBER(10,0)           NULL,
   hirange        NUMBER(10,0)           NULL,
   royalty        NUMBER(10,0)           NULL
);

CREATE TABLE discounts
(
   discounttype   varchar(40)       NOT NULL,
   stor_id        char(4) REFERENCES stores(stor_id) NULL,
   lowqty         smallint              NULL,
   highqty        smallint              NULL,
   discount       dec(4,2)          NOT NULL
)

CREATE SEQUENCE job_id_seq START WITH 1;

CREATE TABLE jobs
(
   job_id         NUMBER(5,0) DEFAULT job_id_seq.NEXTVAL
         CONSTRAINT job_id_pk PRIMARY KEY,

   job_desc       VARCHAR2(50)DEFAULT 'New Position - title not formalized yet' NOT NULL,
   min_lvl        NUMBER(3,0)           NOT NULL
         CONSTRAINT check_min_lvl CHECK (min_lvl >= 10),

   max_lvl        NUMBER(3,0)           NOT NULL
         CONSTRAINT check_max_lvl CHECK (max_lvl <= 250)
);

CREATE TABLE pub_info
(
   pub_id         CHAR(4) REFERENCES publishers(pub_id)  NOT NULL
   CONSTRAINT UPKCL_pubinfo PRIMARY KEY,
   
   logo           BLOB                 NULL,
   pr_info        CLOB                 NULL
);

CREATE TABLE employee
(
   emp_id         VARCHAR2(10)
         CONSTRAINT PK_emp_id PRIMARY KEY
         CONSTRAINT CK_emp_id CHECK (REGEXP_LIKE(emp_id, '[A-Z][A-Z][A-Z][1-9][0-9][0-9][0-9][0-9][FM]') or
            REGEXP_LIKE(emp_id, '[A-Z]-[A-Z][1-9][0-9][0-9][0-9][0-9][FM]')),

   fname          VARCHAR2(20)       NOT NULL,
   minit          CHAR(1)               NULL,
   lname          VARCHAR2(30)       NOT NULL,
   job_id         NUMBER(5) DEFAULT 1 REFERENCES jobs(job_id)NOT NULL,
   job_lvl        NUMBER(3) DEFAULT 10,
   pub_id         CHAR(4) DEFAULT '9952' REFERENCES publishers(pub_id) NOT NULL,
   hire_date      DATE   DEFAULT SYSDATE  NOT NULL         
)
