DROP TABLE IF EXISTS DataLoad.ExternalTables;
GO

CREATE TABLE DataLoad.ExternalTables
(
    ExternalTableID int NOT NULL
        CONSTRAINT PK_DataLoad_ExternalTables PRIMARY KEY
        CONSTRAINT DF_DataLoad_ExternalTables_ExternalTableID 
            DEFAULT (NEXT VALUE FOR DataLoad.ExternalTableID),
    SourceSchemaName sysname NOT NULL,
    SourceTableName sysname NOT NULL,
    ExternalTableName AS CASE WHEN SourceSchemaName = N'dbo'
                              THEN SourceTableName
                              ELSE SourceSchemaName + N'_' + SourceTableName
                         END,
    PrimaryKeyColumns nvarchar(1000) NOT NULL,
    SourceColumnList nvarchar(max) NOT NULL
);
GO

INSERT DataLoad.ExternalTables 
(
    SourceSchemaName, 
    SourceTableName, 
    PrimaryKeyColumns,
    SourceColumnList
)
VALUES 
(
    N'dbo', N'tblBCatSpPr', N'recid',
    N'recid int NOT NULL, bus_cat_code varchar(8) NOT NULL, stock_code varchar(8) NOT NULL, discpercent decimal(18, 3) NOT NULL, discdollars decimal(18, 2) NOT NULL, established datetime NOT NULL, cost decimal(18, 2) NOT NULL, overrideprice smallint NOT NULL, promo_from datetime NOT NULL, promo_to datetime NOT NULL'
),
(
    N'dbo', N'tblBGrp', N'recid',
    N'recid int NOT NULL, bgrp_code varchar(8) NOT NULL, bgrpname varchar(35) NOT NULL'
),
(
    N'dbo', N'tblBGrpSpPr', N'recid',
    N'recid int NOT NULL, bgrp_code varchar(8) NOT NULL, stock_code varchar(8) NOT NULL, discpercent decimal(18, 3) NOT NULL, discdollars decimal(18, 2) NOT NULL, established datetime NOT NULL, cost decimal(18, 2) NOT NULL, overrideprice smallint NOT NULL, promo_from datetime NOT NULL, promo_to datetime NOT NULL'
),
(
    N'dbo', N'tblBusCat', N'recid',
    N'recid int NOT NULL, bcat_code varchar(8) NOT NULL, bcatname varchar(35) NOT NULL'
),
(
    N'dbo', N'tblContGnrl', N'recid',
    N'recid int NOT NULL, cont_code varchar(8) NOT NULL, cname varchar(35) NOT NULL, pcontact varchar(35) NULL, scontact varchar(35) NULL, phone_1 varchar(20) NOT NULL, phone_2 varchar(20) NULL, fax varchar(20) NULL, mobile varchar(20) NULL, email varchar(60) NULL, addr1 varchar(35) NOT NULL, addr2 varchar(35) NULL, addr3 varchar(35) NULL, pcode varchar(15) NULL, cntry varchar(50) NULL, maddr1 varchar(35) NULL, maddr2 varchar(35) NULL, maddr3 varchar(35) NULL, mpcode varchar(15) NULL, mcntry varchar(50) NULL, territ_code varchar(8) NOT NULL, buscat_code varchar(8) NOT NULL, bgrp_code varchar(8) NOT NULL, WebSite varchar(60) NULL, customer smallint NOT NULL, supplier smallint NOT NULL, transport smallint NOT NULL, credlimit money NULL, billto_code varchar(8) NOT NULL, acctopen smalldatetime NOT NULL, stddisc decimal(9,3) NOT NULL, supp_acct varchar(20) NULL, daysfrinv int NOT NULL, r_active smallint NOT NULL, comment varchar(4000) NULL, trns_code varchar(8) NULL, mapref varchar(300) NULL, stpcred smallint NOT NULL, wantsbackordr smallint NOT NULL' 
),
(
    N'dbo', N'tblContSpPr', N'recid',
    N'recid int NOT NULL, cont_code varchar(8) NOT NULL, stock_code varchar(8) NOT NULL, discpercent decimal(18, 3) NOT NULL, discdollars decimal(18, 2) NOT NULL, established datetime NOT NULL, cost decimal(18, 2) NOT NULL, overrideprice smallint NOT NULL, promo_from datetime NOT NULL, promo_to datetime NOT NULL'
),
(
    N'dbo', N'tblContTran', N'recid',
    N'recid int NOT NULL, cont_code varchar(8) NOT NULL, trannum int NOT NULL, dte smalldatetime NOT NULL, ttype_code varchar(1) NOT NULL, amnt decimal(18, 2) NOT NULL, tax decimal(18, 2) NOT NULL, ref varchar(20) NOT NULL, dueby smalldatetime NOT NULL, complete smallint NOT NULL, completed_date smalldatetime NOT NULL, ordnum varchar(20) NULL'
),
(
    N'dbo', N'tblCustBOrd', N'recid',
    N'recid int NOT NULL, cont_code varchar(8) NOT NULL, orddate smalldatetime NOT NULL, stock_code varchar(8) NOT NULL, [desc] varchar(50) NOT NULL, ordered int NOT NULL, recd int NOT NULL, unit decimal(18, 2) NOT NULL'
),
(
    N'dbo', N'tblCustInvL', N'recid',
    N'recid int NOT NULL, invnum int NOT NULL, lnenum int NOT NULL, stock_code varchar(8) NOT NULL, [desc] varchar(50) NOT NULL, ordered int NOT NULL, delivered int NOT NULL, bckordered int NOT NULL, pkg_code varchar(8) NOT NULL, unit decimal(18, 2) NOT NULL, discpercent decimal(18, 3) NOT NULL, discdollars decimal(18, 2) NOT NULL, subtotal decimal(18, 2) NOT NULL, tax decimal(18, 3) NOT NULL, linetotal decimal(18, 2) NOT NULL'
),
(
    N'dbo', N'tblCustInvo', N'recid',
    N'recid int NOT NULL, cont_code varchar(8) NOT NULL, invdate smalldatetime NOT NULL, ordnum varchar(20) NULL, comm1 varchar(35) NULL, comm2 varchar(35) NULL, comm3 varchar(35) NULL, comm4 varchar(35) NULL, expected smalldatetime NULL, deliv_inst_1 varchar(35) NULL, deliv_inst_2 varchar(35) NULL, deliv_inst_3 varchar(35) NULL, run varchar(8) NULL, position int NULL, trnsprt varchar(8) NULL, orduser varchar(8) NOT NULL, pckuser varchar(8) NOT NULL'
),
(
    N'dbo', N'tblCustOrdL', N'recid',
    N'recid int NOT NULL, ordnum NOT NULL, lnenum NOT NULL, stock_code NOT NULL, [desc] NOT NULL, ordered NOT NULL, picked NOT NULL, pkg_code NOT NULL, unit NOT NULL, discpercent NOT NULL, discdollars NOT NULL, tax NOT NULL'
),
(
    N'dbo', N'tblCustOrdr', N'recid',
    N'recid int NOT NULL, cont_code NOT NULL, orddate NOT NULL, ordnum NULL, comm1 NULL, comm2 NULL, comm3 NULL, comm4 NULL, expected NULL, deliv_inst_1 NULL, deliv_inst_2 NULL, deliv_inst_3 NULL, run NULL, position NULL, trnsprt NULL, picked NOT NULL, orduser NOT NULL, pckuser NULL'
),
(
    N'dbo', N'tblPkg', N'recid',
    N'recid int NOT NULL, pkg_code varchar(8) NOT NULL, pkgname varchar(35) NOT NULL'
),
(
    N'dbo', N'tblStkCat', N'recid',
    N'recid int NOT NULL, scat_code varchar(8) NOT NULL, scatname varchar(35) NOT NULL'
),
(
    N'dbo', N'tblStokGnrl', N'recid',
    N'recid int NOT NULL, stock_code varchar(8) NOT NULL,desc varchar(50) NOT NULL,size varchar(20) NULL,pkg_code varchar(8) NOT NULL,wgt decimal(18, 3) NOT NULL,scat_code varchar(8) NOT NULL,bcode varchar(20) NULL,taxprcnt decimal(18,3) NOT NULL,trk_qty smallint NOT NULL,unit decimal(18,2) NOT NULL,bulk decimal(18,2) NOT NULL,wsale decimal(18,2) NOT NULL,agent decimal(18,2) NOT NULL,rrp decimal(18,2) NOT NULL,promo decimal(18,2) NULL,promo_from smalldatetime NULL,promo_to smalldatetime NULL,outerqty int NOT NULL,ctnqty int NOT NULL,palletqty int NOT NULL,pricelist smallint NOT NULL,added smalldatetime NOT NULL,lstpricechange smalldatetime NOT NULL,brand varchar(15) NOT NULL,orderpkg varchar(8) NOT NULL,weight decimal(18, 3) NOT NULL,onhand int NOT NULL,lststocktake int NULL,reorder int NOT NULL,leadtime int NOT NULL,r_active smallint NOT NULL,l_cost decimal(18, 2) NULL,comment varchar(4000) NULL,supplier varchar(8) NULL,altsupplier varchar(8) NULL,suppstk_code varchar(20) NULL,altsuppstk_code varchar(20) NULL'
),
(
    N'dbo', N'tblStokTran', N'recid',
    N'recid int NOT NULL, trannum int NULL, trndate smalldatetime NOT NULL, stock_code varchar(8) NOT NULL, qty int NOT NULL, unit decimal(18, 2) NOT NULL, cont_code varchar(8) NULL, lne int NULL, stake smallint NOT NULL'
),
(
    N'dbo', N'tblSuppOrdL', N'recid',
    N'recid int NOT NULL, ordnum int NOT NULL, lnenum int NOT NULL, stock_code varchar(8) NOT NULL, suppstk_code varchar(20) NOT NULL, desc varchar(50) NOT NULL, ordered int NOT NULL, recd int NOT NULL, pkg_code varchar(8) NOT NULL, unit decimal(18,2) NOT NULL, discpercent decimal(18, 3) NOT NULL, discdollars decimal(18, 2) NOT NULL, tax decimal(18,3) NOT NULL'
),
(
    N'dbo', N'tblSuppOrdr', N'recid',
    N'recid int NOT NULL, cont_code varchar(8) NOT NULL, orddate smalldatetime NOT NULL, ordnum varchar(20) NOT NULL, contact varchar(35) NOT NULL, comm1 varchar(35) NULL, comm2 varchar(35) NULL, comm3 varchar(35) NULL, comm4 varchar(35) NULL, expected smalldatetime NULL, deliv_inst_1 varchar(35) NULL, deliv_inst_2 varchar(35) NULL, deliv_inst_3 varchar(35) NULL, trnsprt varchar(8) NULL, orduser varchar(8) NOT NULL, final smallint NOT NULL'
),
(
    N'dbo', N'tblTerrit', N'recid',
    N'recid int NOT NULL, territ_code varchar(8) NOT NULL, territname varchar(35) NOT NULL'
),
(
    N'dbo', N'tblUser', N'recid',
    N'recid int NOT NULL, user varchar(8) NOT NULL, staff varchar(30) NOT NULL, sperson smallint NOT NULL'
);
GO
