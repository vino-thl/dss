alter PROCEDURE SBO_SP_TransactionNotification
(
	in object_type nvarchar(30), 				-- SBO Object Type
	in transaction_type nchar(1),			-- [A]dd, [U]pdate, [D]elete, [C]ancel, C[L]ose
	in num_of_cols_in_key int,
	in list_of_key_cols_tab_del nvarchar(255),
	in list_of_cols_val_tab_del nvarchar(255)
)
LANGUAGE SQLSCRIPT
AS
-- Return values
error  int;				-- Result (0 for no error)
error_message nvarchar (200); 		-- Error string to be displayed
cnt int;
zcnt int;
counter int;
counter1 int;
LockForsales int;
VDPCHK int;
counterV int;
DeliveryVME int;
VBasePriceDiff int;
BasePriceDiff int;
VDescSalesOr int;
VJEDIV int;
VinoCountso int;
VBatchProd int;
VinCash int;
VPurFrght int;
VCounterPrice int;
VCounterPrice1 int;
VCounterPrice2 int;
VCounterPrice3 int;
VCounterPrice4 int;
salesCreditLimit int;
DeliveryCredit int;
VContactP int;
VContactP1 int;
VContactP2 int;
VContactP3 int;
VContactP4 int;
VContactP5 int;
VtaxORCT int;
Notnullvalue int;
VgrnWHS int;
VtaxOVPM int;
JtaxD int ;
ORCTVLINE int;
VIPCancel int;
counterVi int;
VDivVORCT int;
VDivOVPM int;
VDivOVPMAset int;
VDivOVPMEmp int;
counterVMT int;
counterSQ int;
counterSQvIN int;
counterVPCS int;
counterUSDV2 int;
counterLOCURV2 int;
counterV2 int;
counterVV int;
counter7 int;
IncotermsV int;
Vinocounter int;
VinocounterCRMEMO int;
VinocounterGRFP int;
VinocounterDOOCRCODV int;
VinocounterGRNOCRCODV int;
VinocounterAPOCRCODV int;
VinocounterSOOCRCODV int;
VCounterPricngGroup int;
VinocounterGISP int;
VinocounterGR int;
VinocounterSR int;
VinoSpack Varchar(100);
VinoPpack Varchar(100);
VinoPpackMsr Varchar(100);
VinoSpackUn Varchar(100);
counteritem int;
basetype int;
name char(100);
fname nvarchar (200);
qty decimal(19,6);
varLineNum int;
ItemCode nvarchar (50);
Type nvarchar (10);
GroupName nvarchar (100);
DocType nvarchar (1);
Account nvarchar (20);
Account2 nvarchar (20);
 RecordCount int;
  DraftCount  int;	
DocumentCount  int;	
DREF nvarchar (100);
DocTotal decimal(19,6);
SDocTotal decimal(19,6);
DocEntry int;	
RelParty nvarchar (20);
temp_var_0 Varchar(100);
temp_var_1 Varchar(100);
temp_var_3 Varchar(100);
temp_var_4 Varchar(100);
WMSCNTADVTYPE int;
WMScounterState1 int;
WMScounterState2 int;
WMScounterOITM int;
begin

error := 0;
error_message := N'Ok';
ItemCode :=N'';
DraftCount  :=null;	
DocumentCount :=null;	
DREF:=null;	
GroupName:= NULL;
DocEntry:= NULL;
-- Select the return values

/*
IF(:object_type !='410000000' )
Then 
CALL "DSSLLC_PROD_SBO_10800"."CTX_IC_SP_TRANSACTIONNOTIFICATION"(object_type,transaction_type, num_of_cols_in_key,list_of_key_cols_tab_del,list_of_cols_val_tab_del,:error,:error_message );

End IF;
*/

--------------------------------------------------------------------------------------------------------------------------------


--	ADD	YOUR	CODE	HERE
/* Inventory Transfer Blocking*/
/*
 
IF (:object_type = '67' AND (:transaction_type='A' )) THEN
ItemCode:='';


SELECT 
count(T1."Quantity")  into VRltdWhs   

FROM OWTR T0  
INNER JOIN WTR1 T1 ON T0."DocEntry" = T1."DocEntry"  
INNER JOIN OWHS T2 ON T1."FromWhsCod"=T2."WhsCode" 
INNER JOIN OWHS T3 ON T1."WhsCode"=T3."WhsCode" 
---`WHERE T2."U_DefaultBP" <>T3."U_DefaultBP" 
WHERE 
T2."U_WOrigin"<>T3."U_WOrigin"
---AND (T1."FromWhsCod" NOT IN ('01-065','01-067','01-068','01-069','01-070','01-084','01-085','01-086','01-096')
--or

and

 T1."WhsCode" NOT IN ('01-065','01-067','01-068','01-069','01-070','01-084','01-085','01-086','01-096') 
and  T0."DocEntry" = :list_of_cols_val_tab_del;

if (ifnull(:VRltdWhs,0)>0)
	then
	error := -1;
	error_message := N'Not allowed to Transfer to Other  Party Warehouses';
 end if ;
   
 END IF;
*/
---------------------------------------------------------------------
 
/* Inventory Transfer Request Blockage*/
/*
 
IF (:object_type = '1250000001' AND (:transaction_type='A' AND :transaction_type='U')) THEN
ItemCode:='';

SELECT 
count(T1."Quantity")  into VRltdWhsr   

FROM OWTR T0  
INNER JOIN WTR1 T1 ON T0."DocEntry" = T1."DocEntry"  
INNER JOIN OWHS T2 ON T1."FromWhsCod"=T2."WhsCode" 
INNER JOIN OWHS T3 ON T1."WhsCode"=T3."WhsCode" 
---WHERE T2."U_DefaultBP" <>T3."U_DefaultBP" 
WHERE T2."U_WOrigin"<>T3."U_WOrigin"
AND (T1."FromWhsCod" NOT IN ('01-065','01-067','01-068','01-069','01-070','01-084','01-085','01-086','01-096')
or T1."WhsCode" NOT IN ('01-065','01-067','01-068','01-069','01-070','01-084','01-085','01-086','01-096') )

and  T0."DocEntry" = :list_of_cols_val_tab_del;

if (ifnull(:VRltdWhsr,0)>0)
	then
	error := -1;
	error_message := N'Not allowed to Transfer to Other Party Warehouses';
 end if ;
   
 END IF;
 -------------------
 
IF (:object_type = '67' AND (:transaction_type='A' )) THEN
ItemCode:='';


SELECT 
count(T1."Quantity")  into VRltdWhs   

FROM OWTR T0  
INNER JOIN WTR1 T1 ON T0."DocEntry" = T1."DocEntry"  
INNER JOIN OWHS T2 ON T1."FromWhsCod"=T2."WhsCode" 
INNER JOIN OWHS T3 ON T1."WhsCode"=T3."WhsCode" 
WHERE T2."U_DefaultBP" <>T3."U_DefaultBP" 
AND (T1."FromWhsCod" NOT IN ('01-065','01-067','01-068','01-069','01-070','01-084','01-085','01-086','01-096')
or T1."WhsCode" NOT IN ('01-065','01-067','01-068','01-069','01-070','01-084','01-085','01-086','01-096') )
and  T0."DocEntry" = :list_of_cols_val_tab_del;

if (ifnull(:VRltdWhs,0)>0)
	then
	error := -1;
	error_message := N'Not allowed to Transfer to Other Related Party Warehouses';
 end if ;
   
 END IF;
*/
---------------------------------------------------------------------

/* Inventory Transfer Request Blockage*/

/*
 
IF (:object_type = '1250000001' AND (:transaction_type='A' AND :transaction_type='U')) THEN
ItemCode:='';

SELECT 
count(T1."Quantity")  into VRltdWhsr   

FROM OWTR T0  
INNER JOIN WTR1 T1 ON T0."DocEntry" = T1."DocEntry"  
INNER JOIN OWHS T2 ON T1."FromWhsCod"=T2."WhsCode" 
INNER JOIN OWHS T3 ON T1."WhsCode"=T3."WhsCode" 
WHERE T2."U_DefaultBP" <>T3."U_DefaultBP" 
AND (T1."FromWhsCod" NOT IN ('01-065','01-067','01-068','01-069','01-070','01-084','01-085','01-086','01-096')
or T1."WhsCode" NOT IN ('01-065','01-067','01-068','01-069','01-070','01-084','01-085','01-086','01-096') )

and  T0."DocEntry" = :list_of_cols_val_tab_del;

if (ifnull(:VRltdWhsr,0)>0)
	then
	error := -1;
	error_message := N'Not allowed to Transfer to Other Related Party Warehouses';
 end if ;
   
 END IF;

*/

/* Inventory Transfer Request Blockage*/


IF (:object_type = '1250000001' AND (:transaction_type='A' AND :transaction_type='U')) THEN
ItemCode:='';

SELECT count(T1."Quantity")  into qty   FROM OWTQ T0  INNER JOIN WTQ1 T1 ON T0."DocEntry" = T1."DocEntry"  INNER JOIN OITW T2 ON T1."ItemCode"=T2."ItemCode"
and T1."FromWhsCod"=T2."WhsCode" WHERE T2."IsCommited">T2."OnHand" and  T0."DocEntry" = :list_of_cols_val_tab_del ;

if (ifnull(:qty,0)>0)
then
error := -1;
error_message := N'Kindly post Purchasee Request instead. InStock is less than commited';
 end if ;
 END IF;

--	ADD	YOUR	CODE	HERE
/* Inventory Transfer Blocking*/


IF (:object_type = '67' AND (:transaction_type='A' )) THEN
ItemCode:='';

SELECT count(T1."Quantity")  into qty   FROM OWTR T0  INNER JOIN WTR1 T1 ON T0."DocEntry" = T1."DocEntry"  INNER JOIN OITW T2 ON T1."ItemCode"=T2."ItemCode"
and T1."FromWhsCod"=T2."WhsCode" WHERE T2."IsCommited">T2."OnHand" and  T0."DocEntry" = :list_of_cols_val_tab_del;

if (ifnull(:qty,0)>0)
	then
	error := -1;
	error_message := N'Can Not Transfer Item/s for which Committed Quantity is more than Instock in From Warehouse';
 end if ;
   
 END IF;



---------------Related Party Material Receipt -------------------------------------------------- 

IF (:object_type = '22' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into VgrnWHS FROM OPOR T0 
	INNER JOIN POR1 T1 ON T0."DocEntry" =T1."DocEntry" 
	INNER JOIN OITM T2 ON T1."ItemCode"=T2."ItemCode"
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T0."CardCode" IN ('S_10601','S_10600','S_10200','S_10500','S_10401')
	AND 
	---T1."ItemCode" IN (SELECT  V."ItemCode" FROM "VITEMPROPERTIES" V WHERE V."ParentGroup" IN ('Ms Pipe (Black)','Ms Pipe (Painted)','Galvanized Pipe')) AND 
	T2."ItmsGrpCod" IN ('382','381','389','407','390','408','387','397','384','398','399','400','388','401','402','404','403','423','409','410','412','386','424','391','420')
	AND 
	T1."WhsCode" NOT IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042','01-105','01-106','02-043','03-044','04-044','01-107','01-108','02-044','03-045','04-045','01-111','01-112','IC_DS(G)')
	;
	IF (:VgrnWHS> 0) 
			THEN
				error := -6919;
				error_message := N'Kindly Choose the Respective Related Party Warehouse';
		END IF;

	END IF; 

IF (:object_type = '22' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

	SELECT COUNT(*) INTO VDPCHK FROM POR1 A WHERE A."DocEntry"=:list_of_cols_val_tab_del 
	AND (SELECT COUNT(*) FROM OITM WHERE "ItemName"=A."Dscription")=0 AND A."ItemCode"<>'Service';
			
	IF (:VDPCHK> 0) THEN
		error := 4;
		error_message := N'Item Description is not matching into the ItemName of Item Master Data';
	END IF;
END IF;
	

---------------Related Party Material Receipt -------------------------------------------------- 

IF (:object_type = '20' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into VgrnWHS FROM OPDN T0 
	INNER JOIN PDN1 T1 ON T0."DocEntry" =T1."DocEntry" 
	INNER JOIN OITM T2 ON T1."ItemCode"=T2."ItemCode"
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T0."CardCode" IN ('S_10601','S_10600','S_10200','S_10500','S_10401')
	AND
	T2."ItmsGrpCod" IN ('382','381','389','407','390','408','387','397','384','398','399','400','388','401','402','404','403','423','409','410','412','386','424','391','420')
	AND  
	---T1."ItemCode" IN (SELECT  V."ItemCode" FROM "VITEMPROPERTIES" V WHERE V."ParentGroup" IN ('Ms Pipe (Black)','Ms Pipe (Painted)','Galvanized Pipe')) AND 
	T1."WhsCode" NOT IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042','IC_DS(G)')
	;
	IF (:VgrnWHS> 0) 
			THEN
				error := -6917;
				error_message := N'Kindly Choose the Respective Related Party Warehouse';
		END IF;

	END IF; 
 ----------------------------------------------------- Cancel deposit before Incoming Paymnent Cancellation ----------
IF (:object_type ='24' AND (:transaction_type='C'))

THEN

SELECT count(T0."DocEntry") into VIPCancel 
	FROM ORCT T0 INNER JOIN RCT4 T1 ON T0."DocEntry"=T1."DocNum" 
	LEFT JOIN (SELECT I."DepCancel", N."RcptNum", V."CnclDps"
	FROM ODPS V INNER JOIN DPS1 I ON V."DeposId" =  I."DepositId"
	INNER JOIN OCHH N ON I."CheckKey"= N."CheckKey") K ON T0."DocEntry"=K."RcptNum"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del 	AND
	 K."DepCancel" <>'Y' AND K."CnclDps"= '-1' ;

	If (:VIPCancel > 0) 
		then 
		error := 246;
		error_message := N'Cancel the deposit First';
	end if;
END IF;		
------------------------------------------------------------------------------------------------------------------------------- 

 --------------------- Tax checking in Outgoing Payment

IF (:object_type ='46' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(T0."DocEntry") into VtaxOVPM 
	FROM OVPM T0 INNER JOIN VPM4 T1 ON T0."DocEntry"=T1."DocNum" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."DocType"='A' AND
	IFNULL(T1."VatGroup",'')=''; 
	if (:VtaxOVPM > 0) 
		then 
		error := 247;
		error_message := N'Choose the Tax Code';
	end if;
END IF;		

--------------------- Tax checking in Incoming  Payment

IF (:object_type ='24' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(T0."DocEntry") into VtaxORCT 
	FROM ORCT T0 INNER JOIN RCT4 T1 ON T0."DocEntry"=T1."DocNum" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."DocType"='A' AND
    IFNULL(T1."VatGroup",'')=''; 
	if (:VtaxORCT > 0) 
		then 
		error := 248;
		error_message := N'Choose the Tax Code';
	end if;
END IF;		
------------------------------------------------------------------------------
-------Sales Blocking based on Price list ----
/*
IF (:object_type = '23' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
SELECT count(*) into VCounterPrice FROM OQUT T0 
INNER JOIN QUT1 T1 ON T0."DocEntry" =T1."DocEntry"
--	INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 
INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del 
AND (T1."Price" < (SELECT R."Price" FROM ViAllPrice R WHERE R."UomCode"=T1."UomCode" AND R."ItemCode"=T1."ItemCode" AND R."WhsCode"=T1."WhsCode"));

IF (:VCounterPrice> 0) 
			THEN
				error := 249;
				error_message := N'You are Trying to Sell Items below Alloted Price, Check the Price List';
		END IF;

	END IF; 
		
	----Sales Quotation -----------

IF (:object_type = '23' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
SELECT count(*) into VCounterPrice FROM OQUT T0 
INNER JOIN QUT1 T1 ON T0."DocEntry" =T1."DocEntry"
--	INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 
INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del 
AND (T1."Price" < (SELECT R."Price" FROM ViAllPrice R WHERE R."UomCode"=T1."UomCode" AND R."ItemCode"=T1."ItemCode" AND R."WhsCode"=T1."WhsCode"));

IF (:VCounterPrice> 0) 
			THEN
				error := 250;
				error_message := N'You are Trying to Sell Items below Alloted Price, Check the Price List';
		END IF;

	END IF; 
	
----Sales Order -----------

	IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
SELECT count(*) into VCounterPrice FROM ORDR T0 
INNER JOIN RDR1 T1 ON T0."DocEntry" =T1."DocEntry"
INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del 
AND (T1."Price" < (SELECT R."Price" FROM ViAllPrice R WHERE R."UomCode"=T1."UomCode" AND R."ItemCode"=T1."ItemCode" AND R."WhsCode"=T1."WhsCode"));

IF (:VCounterPrice> 0) 
			THEN
				error := 251;
				error_message := N'You are Trying to Sell Items below Alloted Price, Check the Price List';
		END IF;

	END IF; 

------Delivery ----
	
	IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
SELECT count(*) into VCounterPrice FROM ODLN T0 
INNER JOIN DLN1 T1 ON T0."DocEntry" =T1."DocEntry"
INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del 
AND (T1."Price" < (SELECT R."Price" FROM ViAllPrice R WHERE R."UomCode"=T1."UomCode" AND R."ItemCode"=T1."ItemCode" AND R."WhsCode"=T1."WhsCode"));

IF (:VCounterPrice> 0) 
			THEN
				error := 252;
				error_message := N'You are Trying to Sell Items below Alloted Price, Check the Price List';
		END IF;

	END IF; 

	------Invoice ----
	
	IF (:object_type = '13' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
SELECT count(*) into VCounterPrice FROM OINV T0 
INNER JOIN INV1 T1 ON T0."DocEntry" =T1."DocEntry"
INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del 
AND (T1."Price" < (SELECT R."Price" FROM ViAllPrice R WHERE R."UomCode"=T1."UomCode" AND R."ItemCode"=T1."ItemCode" AND R."WhsCode"=T1."WhsCode"));

IF (:VCounterPrice> 0) 
			THEN
				error := 253;
				error_message := N'You are Trying to Sell Items below Alloted Price, Check the Price List';
		END IF;

	END IF; 

*/
--------------------------------------------------------------
-------------------------------------------------------

----------------- ASTM ITEMS IN SALES QUOTATION--- 
/*
IF (:object_type = '23' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into counterSQ FROM OQUT T0 
	INNER JOIN QUT1 T1 ON T0."DocEntry" =T1."DocEntry" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T3."GroupCode"<>'104'
	AND 
	T1."ItemCode" IN (SELECT  V."ItemCode" FROM "VITEMPROPERTIES" V WHERE V."ParentGroup" IN ('Ms Pipe (Black)','Ms Pipe (Painted)','Galvanized Pipe'))
	AND T1."WhsCode" IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042')
	;
	IF (:counterSQ> 0) 
			THEN
				error := 254;
				error_message := N'You are not Authorised to Sell these Items';
		END IF;

	END IF;

---------------- Sales Order -------------------------

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into counterSQvIN FROM ORDR T0 
	INNER JOIN RDR1 T1 ON T0."DocEntry" =T1."DocEntry" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T3."GroupCode"<>'104'
	AND 
	T1."ItemCode" IN (SELECT  V."ItemCode" FROM "VITEMPROPERTIES" V WHERE V."ParentGroup" IN ('Ms Pipe (Black)','Ms Pipe (Painted)','Galvanized Pipe'))
	AND T1."WhsCode" IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042')
	;
	IF (:counterSQvIN> 0) 
			THEN
				error := 255;
				error_message := N'You are not Authorised to Sell these Items';
		END IF;

	END IF;

		---------------- Sales Delivery -------------------------

IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into counterSQvIN FROM ODLN T0 
	INNER JOIN DLN1 T1 ON T0."DocEntry" =T1."DocEntry" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T3."GroupCode"<>'104'
	AND 
	T1."ItemCode" IN (SELECT  V."ItemCode" FROM "VITEMPROPERTIES" V WHERE V."ParentGroup" IN ('Ms Pipe (Black)','Ms Pipe (Painted)','Galvanized Pipe'))
	AND T1."WhsCode" IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042')
	;
	IF (:counterSQvIN> 0) 
			THEN
				error := 256;
				error_message := N'You are not Authorised to Sell these Items';
		END IF;

	END IF;



	---------------- Sales Invoice -------------------------

IF (:object_type = '13' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into counterSQvIN FROM OINV T0 
	INNER JOIN INV1 T1 ON T0."DocEntry" =T1."DocEntry" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T3."GroupCode"<>'104'
	AND 
	T1."ItemCode" IN (SELECT  V."ItemCode" FROM "VITEMPROPERTIES" V WHERE V."ParentGroup" IN ('Ms Pipe (Black)','Ms Pipe (Painted)','Galvanized Pipe'))
	AND T1."WhsCode" IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042')
	;
	IF (:counterSQvIN> 0) 
			THEN
				error := 257;
				error_message := N'You are not Authorised to Sell these Items';
		END IF;

	END IF;
*/

----------------------------------------
 ----------------- ASTM MT--- 
 ----------------- ASTM MT Delivery ------------------------- 

IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into counterVMT FROM ODLN T0 
	INNER JOIN DLN1 T1 ON T0."DocEntry" =T1."DocEntry"
	INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T3."GroupCode"<>'104'
	AND (T1."Price" > (SELECT R."Price" FROM ASTM_MAX_V_MT R WHERE R."ItemCode"=T1."ItemCode"))
	AND T1."ItemCode" IN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS)
	AND T1."UomCode"='MT'
	AND T1."WhsCode" IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042','01-105','01-106','02-043','03-044','04-044','01-107','01-108','02-044','03-045','04-045','01-111','01-112')
	
	;

	IF (:counterVMT> 0) 
			THEN
				error := 258;
				error_message := N'You are Trying to Sell ASTM in Wrong Price, Check the Price';
		END IF;

	END IF; 

----------------- ASTM MAXIMUM PRICE MT IN SALES QUOTATION--- 

IF (:object_type = '23' AND (:transaction_type='A' OR :transaction_type='U'))

THEN
	SELECT count(*) into counterVMT FROM OQUT T0 
	INNER JOIN QUT1 T1 ON T0."DocEntry" =T1."DocEntry"
	INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T3."GroupCode"<>'104'
	AND (T1."Price" > (SELECT R."Price" FROM ASTM_MAX_V_MT R WHERE R."ItemCode"=T1."ItemCode"))
	AND T1."ItemCode" IN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS)
	AND T1."UomCode"='MT'
	AND T1."WhsCode" IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042','01-105','01-106','02-043','03-044','04-044','01-107','01-108','02-044','03-045','04-045','01-111','01-112')
	
	;

	IF (:counterVPCS> 0) 
			THEN
				error := 259;
				error_message := N'You are Trying to Sell ASTM in Wrong Price, Check the Price';
		END IF;

	END IF;
	
----------------- ASTM MAXIMUM PRICE PCS IN SALES QUOTATION--- 

IF (:object_type = '23' AND (:transaction_type='A' OR :transaction_type='U'))

THEN
	SELECT count(*) into counterVPCS FROM OQUT T0 
	INNER JOIN QUT1 T1 ON T0."DocEntry" =T1."DocEntry"
	INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T3."GroupCode"<>'104'
	AND (T1."Price" > (SELECT R."Price" FROM ASTM_MAX_V_PCS R WHERE R."ItemCode"=T1."ItemCode"))
	AND T1."ItemCode" IN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS)
	AND T1."UomCode"='PCS'
	AND T1."WhsCode" IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042')
	
	;

	IF (:counterVPCS> 0) 
			THEN
				error := 260;
				error_message := N'You are Trying to Sell ASTM in Wrong Price, Check the Price';
		END IF;

	END IF;

 ----------------- ASTM MT--- 

IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into counterVMT FROM ODLN T0 
	INNER JOIN DLN1 T1 ON T0."DocEntry" =T1."DocEntry"
	INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T3."GroupCode"<>'104'
	AND (T1."Price" > (SELECT R."Price" FROM ASTM_MAX_V_PCS R WHERE R."ItemCode"=T1."ItemCode"))
	AND T1."ItemCode" IN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS)

	AND T1."UomCode"='PCS'
	AND T1."WhsCode" IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042')
	
	;

	IF (:counterVMT> 0) 
			THEN
				error := 261;
				error_message := N'You are Trying to Sell ASTM in Wrong Price, Check the Price';
		END IF; 

	END IF; 

	---------- ASTM MT--- 

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U'))

THEN
	SELECT count(*) into counterVMT FROM ORDR T0 
	INNER JOIN RDR1 T1 ON T0."DocEntry" =T1."DocEntry"
	INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T3."GroupCode"<>'104'
	AND (T1."Price" > (SELECT R."Price" FROM ASTM_MAX_V_MT R WHERE R."ItemCode"=T1."ItemCode"))
	AND T1."ItemCode" IN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS)
	AND T1."UomCode"='MT' 
	AND T1."WhsCode" IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042')
	
	;

	IF (:counterVMT> 0) 
			THEN
				error := 262;
				error_message := N'You are Trying to Sell ASTM in Wrong Price, Check the Price';
		END IF;

	END IF;

 ----------------- ASTM PCS--- 


IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U'))

THEN
	SELECT count(*) into counterVPCS FROM ORDR T0 
	INNER JOIN RDR1 T1 ON T0."DocEntry" =T1."DocEntry"
	INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  T3."GroupCode"<>'104'
	AND (T1."Price" > (SELECT R."Price" FROM ASTM_MAX_V_PCS R WHERE R."ItemCode"=T1."ItemCode"))
	AND T1."ItemCode" IN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS)
	AND T1."UomCode"='PCS'
	AND T1."WhsCode" IN ('02-040','03-040','04-040','01-078','01-079','02-041','03-041','04-041','01-080','01-081','02-042','03-042','01-082','01-083','04-042')
	
	;

	IF (:counterVPCS> 0) 
			THEN
				error := 263;
				error_message := N'You are Trying to Sell ASTM in Wrong Price, Check the Price';
		END IF;

	END IF;

-------------------------------------------------  Cannot Post StandAlone Purchase Return -----------------------------------------------------

IF (:object_type = '21' AND (:transaction_type='A' ))
 THEN

SELECT count(T1."BaseType") INTO VinocounterGR
 FROM ORPD T0 INNER JOIN RPD1 T1 ON T0."DocEntry" = T1."DocEntry"
 WHERE T1."BaseType" ='-1' AND T0."DocType" = 'I'
 AND 	T0."DocEntry" = :list_of_cols_val_tab_del;
 
IF (:VinocounterGR> 0) 
		THEN
			error := 264;
			error_message := N'Can Not Post Goods Return Without Goods Receipt PO';
	END IF;

END IF;

-------------------------------------------------  Cannot Post StandAlone Sales order vino -----------------------------------------------------

IF (:object_type = '17' AND (:transaction_type='A' ))
 THEN

SELECT count(T1."BaseType") INTO VinoCountso
 FROM ORDR T0 
 INNER JOIN RDR1 T1 ON T0."DocEntry" = T1."DocEntry"
 INNER JOIN OCRD T2 ON T0."CardCode"=T2."CardCode"
 WHERE T1."BaseType" ='-1' AND T0."DocType" = 'I' AND T0."CardCode"<>'UNI-00000001' AND  T2."GroupCode"<>'110'
 AND 	T0."DocEntry" = :list_of_cols_val_tab_del;
 
IF (:VinoCountso> 0) 
		THEN
			error := 2641;
			error_message := N'Can Not Post Sales Order Without Sales Quotation';
	END IF;

END IF;

------------------------------------------------- Credit Memo Blocking -----------------------------------------------------
IF (:object_type = '14' AND (:transaction_type='A' ))
 THEN

SELECT count(T1."BaseType") INTO VinocounterCRMEMO
 FROM ORIN T0 INNER JOIN RIN1 T1 ON T0."DocEntry" = T1."DocEntry"
 WHERE T1."BaseType" ='-1' AND T0."DocType" = 'I' AND T0."CardCode"  <> 'UNI-00000001'
 AND 	T0."DocEntry" = :list_of_cols_val_tab_del;
 
IF (:VinocounterCRMEMO> 0) 
		THEN
			error := 265;
			error_message := N'Can Not Post Sales Credit Memo Without Sales Invoice';
	END IF;

END IF;


---********* Division Mismatch as per Numbering  Series ************----------------------------------------------------------------


---------------------JE  ------------------------
/*
IF (:object_type = '30' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into VJEDIV 
	FROM OJDT T0 
	INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId" 
	WHERE T1."TransType" = '30' AND 
	IFNULL(T1."ProfitCode",'A') NOT IN (SELECT V."PrcCode" FROM OPRC V WHERE V."DimCode"='1');		
	
IF (:VJEDIV> 0) 	THEN
		error := 181;
		error_message := N'PLease Choose the Division';
	END IF;
END IF;
*/
---------------------------Sales Quotation -------------------

IF (:object_type ='23' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM OQUT T0 INNER JOIN QUT1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";
	
	if (:zcnt > 0) 
		then 
		error := 266;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;		

-------------------------- Sales Order ---------------------------------

IF (:object_type ='17' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM ORDR T0 INNER JOIN RDR1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";
	
	if (:zcnt > 0) 
		then 
		error := 267;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;		

-------------------------- Sales Delivery -------------------------------

IF (:object_type ='15' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM ODLN T0 INNER JOIN DLN1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";

	if (:zcnt > 0) 
		then 
		error := 268;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;		

------------------Sales Invoice --------------------------

IF (:object_type ='13' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM OINV T0 INNER JOIN INV1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";
	
	if (:zcnt > 0) 
		then 
		error := 269;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;	


--------------------------A/R Credit Memo------------------------

IF (:object_type ='14' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM ORIN T0 INNER JOIN RIN1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";

	if (:zcnt > 0) 
		then 
		error := 270;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;	

-----------------A/R Sales Return--------------------------

IF (:object_type ='16' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM ORDN T0 INNER JOIN RDN1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";

	if (:zcnt > 0) 
		then 
		error := 271;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;		
	
-------------------------- Purchase Quotation ------------------------

IF (:object_type ='540000006' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM OPQT T0 INNER JOIN PQT1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";

	if (:zcnt > 0) 
		then 
		error := 272;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;	
	
--------------------------Purchase order------------------------

IF (:object_type ='22' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM OPOR T0 INNER JOIN POR1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";
	
	if (:zcnt > 0) 
		then 
		error := 273;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;		

--------------------------- GRPO------------------------

IF (:object_type ='20' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM OPDN T0 INNER JOIN PDN1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";

	if (:zcnt > 0) 
		then 
		error := 274;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;	
	

--------------------------A/P Invoice ------------------------

IF (:object_type ='18' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM OPCH T0 INNER JOIN PCH1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";

	if (:zcnt > 0) 
		then 
		error := 275;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;

--------------------------A/P Credit Memo------------------------

IF (:object_type ='19' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM ORPC T0 INNER JOIN RPC1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";

	if (:zcnt > 0) 
		then 
		error := 276;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;	

--------------------------A/P PURCHASE RETURN ------------------------

IF (:object_type ='21' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM ORPD T0 INNER JOIN RPD1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";
	
	if (:zcnt > 0) 
		then 
		error := 277;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;	

-----------------------------------------------------------------------------------
-----------------------Incoterms Blocking in Sales---------------------------------
-------------------------- Sales Order --------------------------------------------

IF (:object_type ='17' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into IncotermsV 
	FROM ORDR T0 INNER JOIN RDR1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and T0."DocType" = 'I' AND 
	IFNULL(T0."U_IncoTerms",'A') NOT IN ('EXW','FOB','FCA','FAS','CFR','CIF','CPT','CIP','DAT','DAP','DDP');
	
	if (:IncotermsV > 0) 
		then 
		error := 278;
		error_message := N'Choose Inco-terms';
	end if;
END IF;		
-------------------------- Sales Delivery -------------------------------

IF (:object_type ='15' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into IncotermsV 
	FROM ODLN T0 INNER JOIN DLN1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and T0."DocType" = 'I' AND 
	IFNULL(T0."U_IncoTerms",'A') NOT IN ('EXW','FOB','FCA','FAS','CFR','CIF','CPT','CIP','DAT','DAP','DDP');

	if (:IncotermsV > 0) 
		then 
		error := 279;
		error_message := N'Choose Inco-terms';
	end if;
END IF;		
------------------Sales Invoice --------------------------
IF (:object_type ='13' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into IncotermsV 
	FROM OINV T0 INNER JOIN INV1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and T0."DocType" = 'I' AND 
	IFNULL(T0."U_IncoTerms",'A') NOT IN ('EXW','FOB','FCA','FAS','CFR','CIF','CPT','CIP','DAT','DAP','DDP');
	
	if (:IncotermsV > 0) 
		then 
		error := 280;
		error_message := N'Choose Inco-terms';
	end if;
END IF;	
--------------------------A/R Credit Memo------------------------

IF (:object_type ='14' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into IncotermsV 
	FROM ORIN T0 INNER JOIN RIN1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and T0."DocType" = 'I' AND 
	IFNULL(T0."U_IncoTerms",'A') NOT IN ('EXW','FOB','FCA','FAS','CFR','CIF','CPT','CIP','DAT','DAP','DDP');

	if (:IncotermsV > 0) 
		then 
		error := 281;
		error_message := N'Choose Inco-terms';
	end if;
END IF;	

-----------------A/R Sales Return--------------------------

IF (:object_type ='16' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into IncotermsV 
	FROM ORDN T0 INNER JOIN RDN1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and T0."DocType" = 'I' AND 
	IFNULL(T0."U_IncoTerms",'A') NOT IN ('EXW','FOB','FCA','FAS','CFR','CIF','CPT','CIP','DAT','DAP','DDP');
	
	if (:IncotermsV > 0) 
		then 
		error := 282;
		error_message := N'Choose Inco-terms';
	end if;
END IF;		

---- INVENTORY TRANSACTION CHECKING FOR DIVISION MISMATCH
--Production Order

IF (:object_type ='202' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM OWOR T0 INNER JOIN WOR1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";
if (:zcnt > 0) 
		then 
		error := 283;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;	

--Goods Receipt

IF (:object_type ='59' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM OIGN T0 INNER JOIN IGN1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";
	if (:zcnt > 0) 
		then 
		error := 284;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;

-- Goods Issue
/*

vino

IF (:object_type ='60' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM OIGE T0 INNER JOIN IGE1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";

	if (:zcnt > 0) 
		then 
		error := 285;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;		
*/
--Inventory Posting 

IF (:object_type ='10000071' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM OIQR T0 INNER JOIN IQR1 T1 ON T0."DocEntry"=T1."DocEntry" 
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	IFNULL(T1."OcrCode",'A') <> T3."PrcCode";
	 
	 if (:zcnt > 0) 
		then 
		error := 286;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;		
--------------------- Division checking in Incoming  Payment

IF (:object_type ='24' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(T0."DocEntry") into VDivVORCT 
	FROM ORCT T0 INNER JOIN RCT4 T1 ON T0."DocEntry"=T1."DocNum" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."DocType"='A' AND
	(IFNULL(T1."OcrCode",'') ='') ;
	if (:VDivVORCT > 0)  
		then 
		error := 27;
		error_message := N'Choose the Divsion';
	end if;
END IF;		

--Incoming Payment  

IF (:object_type ='24' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into OrctVLine 
	FROM ORCT T0 
	LEFT JOIN RCT2 T1 ON T0."DocEntry"=T1."DocNum"  
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."CardCode" <> 'UNI-00000001'  AND 
	(IFNULL(T1."OcrCode",'A') <> T3."PrcCode" OR IFNULL(T1."OcrCode",'')='' ) AND T0."PayNoDoc"='N'
	
	AND IFNULL(T0."U_MarginTransNo",'A')='A' ;
	if (:OrctVLine > 0) 
		then 
		error := 2881;
		error_message := N'Division Blank or  Mismatch with Document Numbering series';
	end if;
END IF;	

--Outgoing  Payment  

IF (:object_type ='46' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into zcnt 
	FROM OVPM T0 INNER JOIN VPM2 T1 ON T0."DocEntry"=T1."DocNum"
	LEFT JOIN NNM1 T2 ON T0."Series" =T2."Series"
	LEFT JOIN OPRC T3 ON T2."GroupCode"=T3."GrpCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del and 
	(IFNULL(T1."OcrCode",'A') <> T3."PrcCode" OR IFNULL(T1."OcrCode",'')='' ) AND T0."PayNoDoc"='N' AND T0."DocType"='S'
 AND IFNULL(T0."U_MarginTransNo",'A')='A' 
;

if (:zcnt > 0) 
		then 
		error := 288;
		error_message := N'Division Blank or  Mismatch with Document Numbering series INV';
	end if;
END IF;		

--------------------------------------------------------------------------------------------------  

--------------------------------------------------------------------------------------------------  
	IF (:object_type ='46' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into VDivOVPM 
	FROM OVPM T0 INNER JOIN VPM4 T1 ON T0."DocEntry"=T1."DocNum" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."DocType"='A' AND 
	(IFNULL(T1."OcrCode",'') ='') ;

if (:VDivOVPM > 0) 
		then 
		error := 289;
		error_message := N'Chose the Division';
	end if;
END IF;		

-------------------------------------------------------------------------------------------------  
	IF (:object_type ='46' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into VDivOVPMAset 
	FROM OVPM T0 
	INNER JOIN VPM4 T1 ON T0."DocEntry"=T1."DocNum" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."DocType"='A' AND (IFNULL(T1."OcrCode4",'') ='') 
	AND T1."AcctCode" IN ('5300608000','6300109000','6100505000','6200105000','6200104000','6200101000','6100302000','6200102000','6100301000');

if (:VDivOVPMAset > 0) 
		then 
		error := 290;
		error_message := N'Chose the Asset';
	end if;
END IF;		

--------------------------------------------------------------------------------------------------  
	IF (:object_type ='46' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into VDivOVPMEmp 
	FROM OVPM T0 
	INNER JOIN VPM4 T1 ON T0."DocEntry"=T1."DocNum" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."DocType"='A' AND (IFNULL(T1."OcrCode3",'') ='') 
	AND T1."AcctCode" IN ('5300608000','6300109000','6100505000','6200105000','6200104000','6200101000','6100302000','6200102000','6100301000');

if (:VDivOVPMEmp > 0) 
		then 
		error := 291;
		error_message := N'Chose the Employee';
	end if;
END IF;		

IF (:object_type ='46' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(T0."DocEntry") into Notnullvalue 
	FROM OVPM T0 INNER JOIN VPM4 T1 ON T0."DocEntry"=T1."DocNum" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."DocType"='A' AND
    IFNULL(T1."U_DocumentReceiptDate",'')='' AND T1."VatGroup" <> 'NAI'; 
	if (:Notnullvalue > 0) 
		then 
		error := 24805;
		error_message := N'Document ReceiptDate is Missing';
	end if;
END IF;		

IF (:object_type ='46' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(T0."DocEntry") into Notnullvalue 
	FROM OVPM T0 INNER JOIN VPM4 T1 ON T0."DocEntry"=T1."DocNum" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."DocType"='A' AND
    IFNULL(T1."U_VendorInvoiceDate",'')='' AND T1."VatGroup" <> 'NAI'; 
	if (:Notnullvalue > 0) 
		then 
		error := 24804;
		error_message := N'Vendor Invoice Date is Missing';
	end if;
END IF;		

IF (:object_type ='46' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(T0."DocEntry") into Notnullvalue 
	FROM OVPM T0 INNER JOIN VPM4 T1 ON T0."DocEntry"=T1."DocNum" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."DocType"='A' AND
    IFNULL(T1."U_VendorInvoiceNo",'')='' AND T1."VatGroup" <> 'NAI'; 
	if (:Notnullvalue > 0) 
		then 
		error := 24803;
		error_message := N'Vendor Invoice No. is Missing';
	end if;
END IF;		

IF (:object_type ='46' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(T0."DocEntry") into Notnullvalue 
	FROM OVPM T0 INNER JOIN VPM4 T1 ON T0."DocEntry"=T1."DocNum" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."DocType"='A' AND
    IFNULL(T1."U_VendorName",'')='' AND T1."VatGroup" <> 'NAI'; 
	if (:Notnullvalue > 0) 
		then 
		error := 24802;
		error_message := N'Vendor Name is Missing';
	end if;
END IF;		

IF (:object_type ='46' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(T0."DocEntry") into Notnullvalue 
	FROM OVPM T0 INNER JOIN VPM4 T1 ON T0."DocEntry"=T1."DocNum" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."DocType"='A' AND
    IFNULL(T1."U_TRNNO",'')='' AND T1."VatGroup" <> 'NAI'; 
	if (:Notnullvalue > 0) 
		then 		
		error := 24801;
		error_message := N'TRN No. is Missing';
	end if;
END IF;		
	
----End of DIVISION MISMATCH CHECKING********-------------------------------------------------------

-------------------------------------------------  Cannot Post StandAlone Sales Return -----------------------------------------------------


IF (:object_type = '16' AND (:transaction_type='A' ))
 THEN

SELECT count(T1."BaseType") INTO VinocounterSR
 FROM ORDN T0 INNER JOIN RDN1 T1 ON T0."DocEntry" = T1."DocEntry"
 WHERE T1."BaseType" ='-1' AND T0."DocType" = 'I'
 AND 	T0."DocEntry" = :list_of_cols_val_tab_del;
 
IF (:VinocounterSR> 0) 
		THEN
			error := 2911;
			error_message := N'Can Not Post Sales Return Without Sales Delivery';
	END IF;

END IF;

-------------------------------------------------Stand Alone Goods Receipt Blocking  -----------------------------------------------------
/*
IF (:object_type = '59' AND (:transaction_type='A' ))

 THEN
     SELECT count(T1."BaseType") INTO VinocounterGRFP
	 FROM OIGN T0 INNER JOIN IGN1 T1 ON T0."DocEntry" = T1."DocEntry"
	 WHERE T1."BaseType" ='-1' AND T0."DocType" = 'I'
	 AND 	T0."DocEntry" = :list_of_cols_val_tab_del;
 
IF (:VinocounterGRFP> 0) 
 THEN
	error := 290;
	error_message := N'Can Not Post Stand Alone Goods Receipt';
	END IF;

END IF;
*/
-------------------------------------------------Stand Alone Goods Issue Blocking  -----------------------------------------------------
/*
IF (:object_type = '60' AND (:transaction_type='A' ))

 THEN
     SELECT count(T1."BaseType") INTO VinocounterGISP
	 FROM OIGE T0 INNER JOIN IGE1 T1 ON T0."DocEntry" = T1."DocEntry"
	 WHERE T1."BaseType" ='-1' AND T0."DocType" = 'I'
	 AND 	T0."DocEntry" = :list_of_cols_val_tab_del;
 
IF (:VinocounterGISP> 0) 
 THEN
	error := 291;
	error_message := N'Can Not Post Stand Alone Goods Issue';
	END IF;

END IF;
*/
-------------------------------------------------  Cannot Edit Invoice -----------------------------------------------------

IF (:object_type = '13' AND (:transaction_type='A' ))
 THEN

SELECT count(T1."BaseType") INTO Vinocounter 
 FROM OINV T0 INNER JOIN INV1 T1 ON T0."DocEntry" = T1."DocEntry"
 WHERE T1."BaseType" ='-1' AND T0."CardCode"<>'UNI-00000001'
  AND T0."DocType" = 'I'  AND T0."IsICT"='N'  AND 	T0."DocEntry" = :list_of_cols_val_tab_del;
 
IF (:Vinocounter> 0) 
		THEN
			error := 292;
			error_message := N'Can Not change the Item. Close this and Open the Delivery again and Try';
	END IF;

END IF;

------------------------------------------------- Invoice -----------------------------------------------------

IF (:object_type = '13' AND (:transaction_type='A' ))
 THEN

SELECT count(T1."BaseType") INTO VinCash 
 FROM OINV T0 INNER JOIN INV1 T1 ON T0."DocEntry" = T1."DocEntry"
 WHERE T0."CardCode"='UNI-00000001'
  AND T0."DocType" = 'I' 
  --AND T0."IsICT"='Y'  
  
  AND 	(T0."DocTotal"- T0."PaidToDate") > 0 AND 
    T0."DocEntry" = :list_of_cols_val_tab_del;
 
IF (:VinCash> 0) 
		THEN
			error := 1292;
			error_message := N'Can Not enter Cash Sales without payment';
	END IF;

END IF;

-------------------------------------Outgoing Payment Due to Due From-------------------------------------------------------------------------------------------

IF (:object_type = '46' AND (:transaction_type='A' )) THEN

	 RecordCount :=0;
	 Type:=NULL;
	 DocType:=NULL;
	 Account := NULL;
	 GroupName:= NULL;
	SELECT COUNT(T4."U_DueType") INTO RecordCount FROM OJDT T0 
	INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId" 
	INNER JOIN OCRD T2 ON T1."ShortName"=T2."CardCode" 
	INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
	INNER JOIN OVPM T4 ON T0."TransId" = T4."TransId" 
	WHERE  T4."DocEntry" = :list_of_cols_val_tab_del
		and T4."PayNoDoc"='Y';
		if (:RecordCount>0)
			then
			
				SELECT T4."U_DueType",T1."Account" ,T4."DocType",T3."GroupName" 
				INTO Type,Account,DocType,GroupName 
				FROM OJDT T0 
				INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId" 
				INNER JOIN OCRD T2 ON T1."ShortName"=T2."CardCode" 
				INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
				INNER JOIN OVPM T4 ON T0."TransId" = T4."TransId" 
				WHERE  T4."DocEntry" = :list_of_cols_val_tab_del
				;
			
			IF ( (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party') and Type='NA') 
			THEN
					error := 293;
					error_message := N'Select Type First';

 			ELSEIF ( DocType='C' and ( (:Type='AT' AND :Account<>'1500901000') or (:Type='TR' AND :Account<>'1500201000')) and (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')) 
 			THEN
					error := 294;
					error_message := N'Select 1500201000-Trade Receivables - Related Party or 1500901000-Advance to Related Parties';
			
			ELSEIF ( DocType='S' and( (:Type='AF' AND :Account<>'2200801000') or (:Type='TP' AND :Account<>'2200501000')) and (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party'))
			THEN
					error := 295;
					error_message := N'Select 2200801000- Trade Payables - Related Party or 2200501000-Advance from Related Parties';

 			ELSEIF ( (DocType='C' and Account<>'1500202000') and (:GroupName <>'S - Related Party' AND :GroupName <>'Related Parties' AND :GroupName <>'C - Related Party')) 
 			THEN
					error := 296;
					error_message := N'Select 1500202000-Trade Receivables - Third Party';
			
			ELSEIF ( (DocType='S' and Account<>'2200502000') and (:GroupName <>'S - Related Party' AND :GroupName <>'Related Parties' AND :GroupName <>'C - Related Party')) 
			THEN
					error := 297;
					error_message := N'Select 2200502000- Trade Payables - Third Party';
			ELSEIF ( DocType='S' AND (Type<>'TP' AND  Type<>'AF')and (:GroupName ='S - Related Party' OR :GroupName ='Related Parties' OR :GroupName ='C - Related Party')) 
			THEN
					error := 298;
					error_message := N'Only Type =Trade Payble  or Advance From allowed';		
							
			ELSEIF ( DocType='C' AND (Type<>'TR' AND  Type<>'AT')and (:GroupName ='S - Related Party' OR :GroupName ='Related Parties' OR :GroupName ='C - Related Party')) 
			THEN
					error := 299;
					error_message := N'Only Type =Trade Receivable or Advance To allowed';		
					
			END IF;			
				
				
		END IF;
 END IF;

-------------------------------------Incoming Payment Due to Due From-------------------------------------------------------------------------------------------
IF (:object_type = '24' AND (:transaction_type='A' )) THEN

	 RecordCount :=0;
	 Type:=NULL;
	 DocType:=NULL;
	 Account := NULL;
	 GroupName:= NULL;
	SELECT COUNT(T4."U_DueType") INTO RecordCount FROM OJDT T0 
	INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId" 
	INNER JOIN OCRD T2 ON T1."ShortName"=T2."CardCode" 
	INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
	INNER JOIN ORCT T4 ON T0."TransId" = T4."TransId" 
	WHERE  T4."DocEntry" = :list_of_cols_val_tab_del
		and T4."PayNoDoc"='Y';
		if (:RecordCount>0)
			then
			
				SELECT T4."U_DueType",T1."Account" ,T4."DocType",T3."GroupName" 
				INTO Type,Account,DocType,GroupName 
				FROM OJDT T0 
				INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId" 
				INNER JOIN OCRD T2 ON T1."ShortName"=T2."CardCode" 
				INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
				INNER JOIN ORCT T4 ON T0."TransId" = T4."TransId" 
				WHERE  T4."DocEntry" = :list_of_cols_val_tab_del
				;
			
			IF ( (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party') and Type='NA') 
			THEN
					error := 300;
					error_message := N'Select Type First';

 			 			ELSEIF ( DocType='C' and ( (:Type='AT' AND :Account<>'1500901000') or (:Type='TR' AND :Account<>'1500201000')) and (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')) 
 			THEN
					error := 301;
					error_message := N'Select 1500201000-Trade Receivables - Related Party or 1500901000-Advance to Related Parties';
			
			ELSEIF ( DocType='S' and( (:Type='AF' AND :Account<>'2200801000') or (:Type='TP' AND :Account<>'2200501000')) and (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party'))
			THEN
					error := 302;
					error_message := N'Select 2200801000- Trade Payables - Related Party or 2200501000-Advance from Related Parties';
 			ELSEIF ( (DocType='C' and Account<>'1500202000') and (:GroupName <>'S - Related Party' AND :GroupName <>'Related Parties' AND :GroupName <>'C - Related Party')) 
 			THEN
					error := 303;
					error_message := N'Select 1500202000-Trade Receivables - Third Party';
			
			ELSEIF ( (DocType='S' and Account<>'2200502000') and (:GroupName <>'S - Related Party' AND :GroupName <>'Related Parties' AND :GroupName <>'C - Related Party')) 
			THEN
					error := 304;
					error_message := N'Select 2200502000- Trade Payables - Third Party';

			ELSEIF ( DocType='S' AND (Type<>'TP' AND  Type<>'AF')and (:GroupName ='S - Related Party' OR :GroupName ='Related Parties' OR :GroupName ='C - Related Party')) 
			THEN
					error := 305;
					error_message := N'Only Type =Trade Payble or Advance From allowed';		
					

			
			ELSEIF ( DocType='C' AND (Type<>'TR' AND  Type<>'AT')and (:GroupName ='S - Related Party' OR :GroupName ='Related Parties' OR :GroupName ='C - Related Party')) 
			THEN
					error := 306;
					error_message := N'Only Type =Trade Recivable or Advance To allowed';		
					
			END IF;							
				
		END IF;
 END IF;

----BEGIN ******###########-----PDC Validation on INCOMING PAYMENT -----#####****-----
/*
      IF (:object_type = '24' and :transaction_type='A') THEN
      -- ********** IF PDC Received  already booked then manual Incoming not allowed 
      cnt := 0;
      counter := 0;
      counter1 := 0;
    Select COUNT(T2."DocNum") , MAX(T2."DocNum") , MAX(P2."DocNum") 
    INTO cnt , counter , counter1
      
      From ORCT P0
      INNER JOIN RCT2 P1 ON P1."DocNum" = P0."DocEntry" 
      INNER JOIN OINV P2 ON P1."DocEntry" = P2."DocEntry" 
      INNER JOIN  "@NS_IOCP1" T3 ON  T3."U_DocEntry" = P1."DocEntry" 
                              and P1."InvType" = '13'
      INNER JOIN "@NS_IOCP"  T2 ON T3."DocEntry" = T2."DocEntry" AND T2."U_BPCode" = P0."CardCode"
      WHERE  T2."Canceled" = 'N' and P0."DocEntry" = :list_of_cols_val_tab_del  --AND T3."U_baseAbs" = '961'
      GROUP BY  T2."DocNum";
      if(:cnt>0) THEN 
            error := 307;
            error_message := 'PDC Received Document (' || CAST (:counter AS VARCHAR )|| ')  for invoice (' || CAST (:counter1 AS VARCHAR )||') is alreday Posted'  ;
      END IF;
      END IF; 
      --*****************************************************************************
*/
---- END ******###########-----INCOMING PAYMENT -----#####****----- 

-------------------------------------A/P Invoice Due to Due From-------------------------------------------------------------------------------------------
IF (:object_type = '18' AND (:transaction_type='A' )) THEN

	 RecordCount :=0;
	 	 Type:=NULL;
	 Account := NULL;
	  GroupName:= NULL;
	SELECT COUNT(T4."U_PDueType") INTO RecordCount FROM OJDT T0 
	INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId" 
	INNER JOIN OCRD T2 ON T1."ShortName"=T2."CardCode" 
	INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
	INNER JOIN OPCH T4 ON T0."TransId" = T4."TransId" 
	WHERE T3."GroupName" in ('S - Related Party','Related Parties','C - Related Party')
	AND T4."DocEntry" = :list_of_cols_val_tab_del
	AND T2."CardType"='S'
	AND T4."U_PDueType"='NA';
	
	SELECT T0."U_PDueType", T0."CtlAccount",T3."GroupName" INTO 
	Type,Account ,GroupName
	FROM OPCH T0 
	INNER JOIN OCRD T2 ON T0."CardCode" =T2."CardCode" 
	INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
	WHERE 
	T0."DocEntry" = :list_of_cols_val_tab_del;

			IF (  Account<>'2200502000' and (:GroupName <>'S - Related Party' AND :GroupName <>'Related Parties' AND :GroupName <>'C - Related Party')) 
			then
						error := 308;
						error_message := N'Select 2200502000- Trade Payables - Third Party';
		
			ELSEIF (:RecordCount>0)
			then
			
				error := 309;
				error_message := N'Select Type First';
	
			ELSEIF ( ( (:Type='AF' AND :Account<>'2200801000') or (:Type='TP' AND :Account<>'2200501000')) and (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')) 
				THEN
						error := 310;
						error_message := N'Select 2200801000- Trade Payables - Related Party or 2200501000-Advance from Related Parties';
			 END IF;
 END IF; 
-------------------------------------A/P Credit Invoice Due to Due From-------------------------------------------------------------------------------------------
IF (:object_type = '19' AND (:transaction_type='A' )) THEN


	 RecordCount :=0;
	 	 Type:=NULL;
	 Account := NULL;
	  GroupName:= NULL;
	SELECT COUNT(T4."U_PDueType") INTO RecordCount FROM OJDT T0 
	INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId" 
	INNER JOIN OCRD T2 ON T1."ShortName"=T2."CardCode" 
	INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
	INNER JOIN ORPC T4 ON T0."TransId" = T4."TransId" 
	WHERE T3."GroupName" in ('S - Related Party','Related Parties','C - Related Party')
	AND T4."DocEntry" = :list_of_cols_val_tab_del
	AND T2."CardType"='S'
	AND T4."U_PDueType"='NA';
	
	SELECT T0."U_PDueType", T0."CtlAccount",T3."GroupName" INTO 
	Type,Account ,GroupName
	FROM ORPC T0 
	INNER JOIN OCRD T2 ON T0."CardCode" =T2."CardCode" 
	INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
	WHERE 
	T0."DocEntry" = :list_of_cols_val_tab_del;

			IF (  Account<>'2200502000' and (:GroupName <>'S - Related Party' AND :GroupName <>'Related Parties' AND :GroupName <>'C - Related Party')) 
			then
						error := 311;
						error_message := N'Select 2200502000- Trade Payables - Third Party';
			ELSEIF (:RecordCount>0)
			then
				error := 312;
				error_message := N'Select Type First';
	
			ELSEIF ( ( (:Type='AF' AND :Account<>'2200801000') or (:Type='TP' AND :Account<>'2200501000')) and (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')) 
				THEN
						error := 313;
						error_message := N'Select 2200801000- Trade Payables - Related Party or 2200501000-Advance from Related Parties';
			 END IF;
				
 END IF; 

-------------------------------------A/R Invoice Due to Due From-------------------------------------------------------------------------------------------
IF (:object_type = '13' AND (:transaction_type='A' )) THEN

	 RecordCount :=0;
	 	 Type:=NULL;
	 Account := NULL;
	SELECT COUNT(T4."U_SDueType") INTO RecordCount FROM OJDT T0 
	INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId" 
	INNER JOIN OCRD T2 ON T1."ShortName"=T2."CardCode" 
	INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
	INNER JOIN OINV T4 ON T0."TransId" = T4."TransId" 
	WHERE T3."GroupName" in ('S - Related Party','Related Parties','C - Related Party')
	AND T4."DocEntry" = :list_of_cols_val_tab_del
	AND T4."U_SDueType"='NA';
	
		SELECT T0."U_SDueType", T0."CtlAccount",T3."GroupName" INTO 
	Type,Account ,GroupName
	FROM OINV T0 
	INNER JOIN OCRD T2 ON T0."CardCode" =T2."CardCode" 
	INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
	WHERE 
	T0."DocEntry" = :list_of_cols_val_tab_del;

			IF (  Account<>'1500202000'  and (:GroupName <>'S - Related Party' AND :GroupName <>'Related Parties' AND :GroupName <>'C - Related Party')) 
			then
						error := 314;
						error_message := N'Select 2200502000- Trade Payables - Third Party';
		
			ELSEIF (:RecordCount>0)
			then
			
				error := 315;
				error_message := N'Select Type First';
	
			ELSEIF ( ( (:Type='AT' AND :Account<>'1500901000') or (:Type='TR' AND :Account<>'1500201000')) and (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')) 
				THEN
						error := 316;
						error_message := N'Select 2200801000- Trade Payables - Related Party or 2200501000-Advance from Related Parties';
	
			 END IF;
			
 END IF;


-------------------------------------A/R Credit Invoice Due to Due From-------------------------------------------------------------------------------------------

IF (:object_type = '14' AND (:transaction_type='A' )) THEN

	 RecordCount :=0;
	 	 Type:=NULL;
	 Account := NULL;
	SELECT COUNT(T4."U_SDueType") INTO RecordCount FROM OJDT T0 
	INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId" 
	INNER JOIN OCRD T2 ON T1."ShortName"=T2."CardCode" 
	INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
	INNER JOIN ORIN T4 ON T0."TransId" = T4."TransId" 
	WHERE T3."GroupName" in ('S - Related Party','Related Parties','C - Related Party')
	AND T4."DocEntry" = :list_of_cols_val_tab_del
	AND T4."U_SDueType"='NA';

		SELECT T0."U_SDueType", T0."CtlAccount",T3."GroupName" INTO 
	Type,Account ,GroupName
	FROM ORIN T0 
	INNER JOIN OCRD T2 ON T0."CardCode" =T2."CardCode" 
	INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
	WHERE 
	T0."DocEntry" = :list_of_cols_val_tab_del;

			IF (  Account<>'1500202000'  and (:GroupName <>'S - Related Party' AND :GroupName <>'Related Parties' AND :GroupName <>'C - Related Party')) 
			then
						error := 317;
						error_message := N'Select 2200502000- Trade Payables - Third Party';
		
			ELSEIF (:RecordCount>0)
			then
			
				error := 318;
				error_message := N'Select Type First';
	
			ELSEIF ( ( (:Type='AT' AND :Account<>'1500901000') or (:Type='TR' AND :Account<>'1500201000')) and (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')) 
				THEN
						error := 319;
						error_message := N'Select 2200801000- Trade Payables - Related Party or 2200501000-Advance from Related Parties';
			 END IF;
 END IF;
-------------------------------------Reconcilliation Due to Due From-------------------------------------------------------------------------------------------
/*
IF (:object_type = '321' AND (:transaction_type='A' )) THEN

	 RecordCount :=0;
	 Type:=NULL;
	 Account := NULL;
	 Account2 := NULL;
--SELECT count(*) INTO RecordCount   FROM ITR1 T0 WHERE T0."ReconNum" =:list_of_cols_val_tab_del
--AND  T0."SrcObjTyp" ='321';
SELECT  count(distinct T2."AcctCode") INTO RecordCount FROM ITR1 T0 , JDT1 T1 , OACT T2 WHERE T0."TransId"= T1."TransId" and  T2."AcctCode"= T1."Account"
and T2."LocManTran"='Y' and T0."IsCredit"=T1."DebCred"
and T0."ReconNum" =:list_of_cols_val_tab_del;
-- and( (T1."Account"='2200801000' and T1."Account"='1500901000') or (T1."Account"='1500201000' and T1."Account"='2200501000'));
		if (:RecordCount=2)
		then
			SELECT top 1 distinct  T2."AcctCode" INTO Account FROM ITR1 T0 , JDT1 T1 , OACT T2 
			WHERE T0."TransId"= T1."TransId" and  T2."AcctCode"= T1."Account"
			and T0."IsCredit"=T1."DebCred"
			and T2."LocManTran"='Y' and T0."ReconNum" =:list_of_cols_val_tab_del;	  
			
			SELECT top 1 distinct T2."AcctCode" INTO Account2 FROM ITR1 T0 , JDT1 T1 , OACT T2 WHERE T0."TransId"= T1."TransId" and  T2."AcctCode"= T1."Account"
			and T2."LocManTran"='Y' and T0."IsCredit"=T1."DebCred"
			and T0."ReconNum" =:list_of_cols_val_tab_del and T2."AcctCode"<>:Account;
		end if;
		if (:RecordCount>2)
		then
		
				error := 320;
			error_message := N'Can Not Select More Than Two control account';
		 elseif (
		 			(  --1500901000 2200801000 1500202000
		 					(
		 						(:Account='2200801000' AND :Account2<>'1500901000') 
		 					OR (:Account='1500901000' and :Account2<>'2200801000')
		 					) 
		 					or  
		 					(
		 						(:Account='1500201000' AND :Account2<>'2200501000')
		 					OR  (:Account2='2200501000' AND :Account<>'1500201000')
		 					)
		 					OR 
		 					(
		 						(:Account='1500201000' AND :Account2='2200501000')
		 					OR  (:Account2='2200501000' AND :Account='1500201000')
		 					)
		 				) 
		 			and :RecordCount=2 and :Account<>:Account2
		 		)
		 then
		 error := 321;
		 error_message := N'Can not select transaction with different pair of account. Correct Pair is 2200801000 and 1500901000 or  1500201000 and 2200501000 -'||:Account||' ' || :Account2|| '-'||:RecordCount ;

		 end if;
		 
 END IF;

*/
-------------------------------------------------InterCompany-------------------------------------------------------------------
/*	
---------------------------------------------------Can Not change InterCompanny PO When Posting-----------------------------------------------------------------------------
IF (:object_type = '22' AND (:transaction_type='A' )) THEN

Select distinct count(*) into DraftCount from (

SELECT T3."ItemCode", T3."Quantity", T3."LineTotal" FROM OPOR T0  INNER JOIN ODRF T2 ON T0."draftKey" = T2."DocEntry" INNER JOIN DRF1 T3 ON T2."DocEntry" = T3."DocEntry" AND T2."UserSign"=2
WHERE T0."DocEntry" = :list_of_cols_val_tab_del

UNION 
SELECT T1."ItemCode", T1."Quantity", T1."LineTotal" FROM OPOR T0 INNER JOIN POR1 T1 ON T0."DocEntry" = T1."DocEntry" INNER JOIN ODRF T2 ON   T0."draftKey" = T2."DocEntry"  AND T2."UserSign"=2 INNER JOIN DRF1 T3 ON  T2."DocEntry" = T3."DocEntry" AND T3."LineNum"= T1."LineNum"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				

)A;

SELECT distinct count(*) into DocumentCount FROM OPOR T0  INNER JOIN POR1 T1 ON T0."DocEntry" = T1."DocEntry" INNER JOIN ODRF T2 ON T0."draftKey" = T2."DocEntry" INNER JOIN DRF1 T3 ON T2."DocEntry" = T3."DocEntry" AND T1."LineNum" = T3."LineNum" AND T2."UserSign"=2
WHERE  T0."DocEntry" = :list_of_cols_val_tab_del;

					

IF (:DraftCount<> :DocumentCount) 
		THEN
			error := 322;
			error_message := N'Can Not Change Intercommpany Document '||DraftCount||' '||DocumentCount;
	END IF;

END IF;

*/
---------------------------------------------------Can Not change InterCompanny SO When Posting-----------------------------------------------------------------------------
/*
IF (:object_type = '17' AND (:transaction_type='A' )) THEN

Select distinct count(*) into DraftCount from (

SELECT T3."ItemCode", T3."Quantity", T3."LineTotal" FROM ORDR T0  INNER JOIN ODRF T2 ON T0."draftKey" = T2."DocEntry" INNER JOIN DRF1 T3 ON T2."DocEntry" = T3."DocEntry" AND T2."UserSign"=2
WHERE T0."DocEntry" = :list_of_cols_val_tab_del

UNION 
SELECT T1."ItemCode", T1."Quantity", T1."LineTotal" FROM ORDR T0 INNER JOIN RDR1 T1 ON T0."DocEntry" = T1."DocEntry" INNER JOIN ODRF T2 ON   T0."draftKey" = T2."DocEntry"  AND T2."UserSign"=2 
INNER JOIN DRF1 T3 ON  T2."DocEntry" = T3."DocEntry" AND T3."LineNum"= T1."LineNum"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				

)A;

SELECT distinct count(*) into DocumentCount FROM ORDR T0  INNER JOIN RDR1 T1 ON T0."DocEntry" = T1."DocEntry" INNER JOIN ODRF T2 ON T0."draftKey" = T2."DocEntry" INNER JOIN DRF1 T3 ON T2."DocEntry" = T3."DocEntry" AND T1."LineNum" = T3."LineNum" AND T2."UserSign"=2
WHERE  T0."DocEntry" = :list_of_cols_val_tab_del;				

IF (:DraftCount<> :DocumentCount) 
		THEN
			error := 323;
			error_message := N'Can Not Change Intercommpany Document '||DraftCount||' '||DocumentCount;
	END IF;

END IF;
*/
---------------------------------------------------Can Not change InterCompanny GRPO When Posting-----------------------------------------------------------------------------
/*
IF (:object_type = '20' AND (:transaction_type='A' )) THEN

Select distinct count(*) into DraftCount from (

SELECT T3."ItemCode", T3."Quantity", T3."LineTotal" FROM OPDN T0  INNER JOIN ODRF T2 ON T0."draftKey" = T2."DocEntry" INNER JOIN DRF1 T3 ON T2."DocEntry" = T3."DocEntry" AND T2."UserSign"=2
WHERE T0."DocEntry" = :list_of_cols_val_tab_del

UNION 
SELECT T1."ItemCode", T1."Quantity", T1."LineTotal" FROM OPDN T0 INNER JOIN PDN1 T1 ON T0."DocEntry" = T1."DocEntry" INNER JOIN ODRF T2 ON   T0."draftKey" = T2."DocEntry"  AND T2."UserSign"=2 INNER JOIN DRF1 T3 ON  T2."DocEntry" = T3."DocEntry" AND T3."LineNum"= T1."LineNum"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				

)A;

SELECT distinct count(*) into DocumentCount FROM OPDN T0  INNER JOIN PDN1 T1 ON T0."DocEntry" = T1."DocEntry" INNER JOIN ODRF T2 ON T0."draftKey" = T2."DocEntry" INNER JOIN DRF1 T3 ON T2."DocEntry" = T3."DocEntry" AND T1."LineNum" = T3."LineNum" AND T2."UserSign"=2
WHERE  T0."DocEntry" = :list_of_cols_val_tab_del;				

IF (:DraftCount<> :DocumentCount) 
		THEN
			error := 324;
			error_message := N'Can Not Change Intercommpany Document '||DraftCount||' '||DocumentCount;
	END IF;

END IF;
*/
---------------------------------------------------Can Not change InterCompanny A/P Invoice When Posting-----------------------------------------------------------------------------
/*
IF (:object_type = '18' AND (:transaction_type='U' )) THEN

Select distinct count(*) into DraftCount from (

SELECT T3."ItemCode", T3."Quantity", T3."LineTotal" FROM OPCH T0  INNER JOIN ODRF T2 ON T0."draftKey" = T2."DocEntry" INNER JOIN DRF1 T3 ON T2."DocEntry" = T3."DocEntry" AND T2."UserSign"=2
WHERE T0."DocEntry" = :list_of_cols_val_tab_del

UNION 
SELECT T1."ItemCode", T1."Quantity", T1."LineTotal" FROM OPCH T0 INNER JOIN PCH1 T1 ON T0."DocEntry" = T1."DocEntry" INNER JOIN ODRF T2 ON   T0."draftKey" = T2."DocEntry"  AND T2."UserSign"=2 INNER JOIN DRF1 T3 ON  T2."DocEntry" = T3."DocEntry" AND T3."LineNum"= T1."LineNum"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				

)A;

SELECT distinct count(*) into DocumentCount FROM OPCH T0  INNER JOIN PCH1 T1 ON T0."DocEntry" = T1."DocEntry" INNER JOIN ODRF T2 ON T0."draftKey" = T2."DocEntry" INNER JOIN DRF1 T3 ON T2."DocEntry" = T3."DocEntry" AND T1."LineNum" = T3."LineNum" AND T2."UserSign"=2
WHERE  T0."DocEntry" = :list_of_cols_val_tab_del;

					

IF (:DraftCount<> :DocumentCount) 
		THEN
			error := 325;
			error_message := N'Can Not Change Intercommpany Document '||DraftCount||' '||DocumentCount;
	END IF;

END IF;
*/

---------------------------------------------------Can Not change InterCompanny A/P Credit Memo When Posting-----------------------------------------------------------------------------
/*
IF (:object_type = '19' AND (:transaction_type='U' )) THEN

Select distinct count(*) into DraftCount from (

SELECT T3."ItemCode", T3."Quantity", T3."LineTotal" FROM ORPC T0  INNER JOIN ODRF T2 ON T0."draftKey" = T2."DocEntry" INNER JOIN DRF1 T3 ON T2."DocEntry" = T3."DocEntry" AND T2."UserSign"=2
WHERE T0."DocEntry" = :list_of_cols_val_tab_del

UNION 
SELECT T1."ItemCode", T1."Quantity", T1."LineTotal" FROM ORPC T0 INNER JOIN RPC1 T1 ON T0."DocEntry" = T1."DocEntry" INNER JOIN ODRF T2 ON   T0."draftKey" = T2."DocEntry"  AND T2."UserSign"=2 INNER JOIN DRF1 T3 ON  T2."DocEntry" = T3."DocEntry" AND T3."LineNum"= T1."LineNum"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				

)A;

SELECT distinct count(*) into DocumentCount FROM ORPC T0  INNER JOIN RPC1 T1 ON T0."DocEntry" = T1."DocEntry" INNER JOIN ODRF T2 ON T0."draftKey" = T2."DocEntry" INNER JOIN DRF1 T3 ON T2."DocEntry" = T3."DocEntry" AND T1."LineNum" = T3."LineNum" AND T2."UserSign"=2
WHERE  T0."DocEntry" = :list_of_cols_val_tab_del;

					

IF (:DraftCount<> :DocumentCount) 
		THEN
			error := 326;
			error_message := N'Can Not Change Intercommpany Document '||DraftCount||' '||DocumentCount;
	END IF;

END IF;

---------------------------------------------------Can Not Update InterCompanny Draft-----------------------------------------------------------------------------
IF (:object_type = '112' AND (:transaction_type='U' )) THEN

SELECT Count(*) into DraftCount FROM ODRF T0  
WHERE T0."DocEntry" = :list_of_cols_val_tab_del
AND  T0."UserSign"=2;
					

IF (:DraftCount= 1) 

		THEN
		SELECT "DocTotal","U_CTX_STPD" into DocTotal, SDocTotal FROM ODRF T0  
		WHERE T0."DocEntry" = :list_of_cols_val_tab_del;
		IF (:DocTotal<>:SDocTotal) 
		THEN
			error := 327;
			error_message := N'Can Not Change Intercommpany Document '||DraftCount;
		END IF;
	END IF;

END IF;
*/
--------------------------------------------------Can Not Update InterCompanny PO-----------------------------------------------------------------------------

/*
IF (:object_type = '22' AND (:transaction_type='U' )) THEN
GroupName :=NULL;
counter :=NULL;
				select count("DocEntry")
				into  counter
				from ADOC 
				where "ObjType"=22 
				and "DocEntry"=:list_of_cols_val_tab_del and "UserSign2"=2;
			
			if (:counter>0)
			then
				SELECT ifnull(T3."GroupName" ,'a')
				INTO GroupName 
				FROM OPOR T4 
				INNER JOIN OCRD T2 ON T4."CardCode" =T2."CardCode" 
				INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
 
				WHERE  T4."DocEntry" = :list_of_cols_val_tab_del
				and T4."UserSign2"<>2
				and ( select "DocEntry"

				from ADOC 
				where "ObjType"=22 
				and "DocEntry"=:list_of_cols_val_tab_del and "UserSign2"=2) =:list_of_cols_val_tab_del 
				;
				
				
				IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
				THEN
						error := 328;
						error_message := N'Can Not Update Intercompany Purchase Order';
				END IF; 
			END IF; 



END IF;
*/
---------------------------------------------------Can Not Update InterCompanny SO-----------------------------------------------------------------------------
/*
IF (:object_type = '17' AND (:transaction_type='U' )) THEN

				SELECT T3."GroupName" 
				INTO GroupName 
				FROM ORDR T4 
				INNER JOIN OCRD T2 ON T4."CardCode" =T2."CardCode" 
				INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
				
				WHERE  T4."DocEntry" = :list_of_cols_val_tab_del
								and T4."UserSign2"<>2
				;
			IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
			THEN
					error := 329;
					error_message := N'Can Not Update Intercompany Sales Order';
			END IF;
END IF;
*/
---------------------------------------------------Can Not Cancel InterCompanny PO-----------------------------------------------------------------------------
/*
IF (:object_type = '22' AND (:transaction_type='C' )) THEN
				Select  count(*) into DocumentCount
				FROM OPOR T4 
					INNER JOIN OCRD T2 ON T4."CardCode" =T2."CardCode" 
					INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
					
					WHERE  T4."DocEntry" = :list_of_cols_val_tab_del
					and T4."UserSign2"<>2
				;
				
				if (:DocumentCount>0)				
			then
			
					SELECT ifnull(T3."GroupName" ,'a')
					INTO GroupName 
					FROM OPOR T4 
					INNER JOIN OCRD T2 ON T4."CardCode" =T2."CardCode" 
					INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
					
					WHERE  T4."DocEntry" = :list_of_cols_val_tab_del
					and T4."UserSign2"<>2
					;
					if (:GroupName is not null)
								THEN
						IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
						THEN
								error := 330;
								error_message := N'Can Not Cancel Intercompany Purchase Order';
						END IF;
					END IF;
				END IF;
END IF;
*/
---------------------------------------------------Can Not Cancel InterCompanny SO-----------------------------------------------------------------------------
/*
IF (:object_type = '17' AND (:transaction_type='C' )) THEN

				SELECT T3."GroupName" 
				INTO GroupName 
				FROM ORDR T4 
				INNER JOIN OCRD T2 ON T4."CardCode" =T2."CardCode" 
				INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
				
				WHERE  T4."DocEntry" = :list_of_cols_val_tab_del
				;
			IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
			THEN
					error := 331;
					error_message := N'Can Not Cancel Intercompany Sales Order';
			END IF;
END IF;
*/
---------------------------------------------------Can Not Cancel InterCompanny GRPO-----------------------------------------------------------------------------
/*
IF (:object_type = '20' AND (:transaction_type='A' )) THEN
				Select  count(*) into DocumentCount
				FROM OPDN T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C'
				;
		if (:DocumentCount>0)				
		then
				SELECT T2."GroupName" 
				INTO GroupName
				FROM OPDN T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C';
				
				IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
				THEN
					error := 332;
					error_message := N'Can Not Cancel Intercompany Goods Receipt PO';
			END IF;
				
		end	if	;
END IF;
	*/
---------------------------------------------------Can Not Cancel InterCompanny Delivery-----------------------------------------------------------------------------
/*
IF (:object_type = '15' AND (:transaction_type='A' )) THEN
				
				Select  count(*) into DocumentCount
				FROM ODLN T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C'
				;
		if (:DocumentCount>0)				
		then
				SELECT T2."GroupName" 
				INTO GroupName
				FROM ODLN T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C';
				
				IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
				THEN
					error := 333;
					error_message := N'Can Not Cancel Intercompany Delivery';
			END IF;
				
		end	if	;

				
END IF;
*/
---------------------------------------------------Can Not Cancel InterCompanny Goods Return-----------------------------------------------------------------------------
/*
IF (:object_type = '21' AND (:transaction_type='A' )) THEN

				Select  count(*) into DocumentCount
				FROM ORPD T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C'
				;
		if (:DocumentCount>0)				
		then
				SELECT T2."GroupName" 
				INTO GroupName
				FROM ORPD T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C';
				
				IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
				THEN
					error := 334;
					error_message := N'Can Not Cancel Intercompany Goods Return';
			END IF;
				
		end	if	;

END IF;
*/
---------------------------------------------------Can Not Cancel InterCompanny Purchase Return-----------------------------------------------------------------------------
/*
IF (:object_type = '16' AND (:transaction_type='A' )) THEN

				Select  count(*) into DocumentCount
				FROM ORDN T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C'
				;
		if (:DocumentCount>0)				
		then
				SELECT T2."GroupName" 
				INTO GroupName
				FROM ORDN T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C';
				
				IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
				THEN
					error := 335;
					error_message := N'Can Not Cancel Intercompany Returns';
			END IF;
				
		end	if	;

END IF;
*/
---------------------------------------------------Can Not Cancel InterCompanny A/P Invoice-----------------------------------------------------------------------------
/*
IF (:object_type = '18' AND (:transaction_type='A' )) THEN

				Select  count(*) into DocumentCount
				FROM OPCH T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C'
				;
		if (:DocumentCount>0)				
		then
				SELECT T2."GroupName" 
				INTO GroupName
				FROM OPCH T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C';
				
				IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
				THEN
					error := 336;
					error_message := N'Can Not Cancel Intercompany A/P Invoice';
			END IF;
				
		end	if	;

END IF;
*/
---------------------------------------------------Can Not Cancel InterCompanny A/R Invoice-----------------------------------------------------------------------------
/*

IF (:object_type = '13' AND (:transaction_type='A' )) THEN

				Select  count(*) into DocumentCount
				FROM OINV T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C'
				;
		if (:DocumentCount>0)				
		then
				SELECT T2."GroupName" 
				INTO GroupName
				FROM OINV T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C';
				
				IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
				THEN
					error := 337;
					error_message := N'Can Not Cancel Intercompany A/R Invoice';
			END IF;
				
		end	if	;

END IF;

*/
---------------------------------------------------Can Not Cancel InterCompanny A/P Credit Memo-----------------------------------------------------------------------------
/*
IF (:object_type = '19' AND (:transaction_type='A' )) THEN

				Select  count(*) into DocumentCount
				FROM ORPC T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C'
				;
		if (:DocumentCount>0)				
		then
				SELECT T2."GroupName" 
				INTO GroupName
				FROM ORPC T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C';
				
				IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
				THEN
					error := 338;
					error_message := N'Can Not Cancel Intercompany A/P Credit Memo';
			END IF;
				
		end	if	;

END IF;
*/
---------------------------------------------------Can Not Cancel InterCompanny A/R cREDIT Memo-----------------------------------------------------------------------------
/*

IF (:object_type = '14' AND (:transaction_type='A' )) THEN

				Select  count(*) into DocumentCount
				FROM ORIN T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C'
				;
		if (:DocumentCount>0)				
		then
				SELECT T2."GroupName" 
				INTO GroupName
				FROM ORIN T0  INNER JOIN OCRD T1 ON T0."CardCode" = T1."CardCode" 
				INNER JOIN OCRG T2 ON T1."GroupCode" = T2."GroupCode" 
				WHERE T0."DocEntry" = :list_of_cols_val_tab_del
				AND T0."CANCELED"='C';
				
				IF  (:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  
				THEN
					error := 339;
					error_message := N'Can Not Cancel Intercompany A/R Credit Memo';
			END IF;
				
		end	if	;

END IF;
*/
---------------------------------------------------Can Not Post Sales Return with Purchase Return in InterCompanny PO-----------------------------------------------------------------------------
/*
IF (:object_type = '16' AND (:transaction_type='C' )) THEN

				SELECT T3."GroupName" ,T4."U_CTX_DREF"
				INTO GroupName ,DREF
				FROM ORDN T4 
				INNER JOIN OCRD T2 ON T4."CardCode" =T2."CardCode" 
				INNER JOIN OCRG T3 ON T2."GroupCode" = T3."GroupCode" 
				
				WHERE  T4."DocEntry" = :list_of_cols_val_tab_del
				;
			IF  ((:GroupName ='S - Related Party' or :GroupName ='Related Parties' or :GroupName ='C - Related Party')  and DREF is null)
			THEN
					error := 340;
					error_message := N'Can Not Post Sales Return Without Purchase Return by Related Company';
			END IF;
END IF;
*/		
---------------------------------------------------Select Division while Outgoing Payment Type account When Posting-----------------------------------------------------------------------------

IF (:object_type = '46' AND (:transaction_type='A' )) THEN


SELECT count(*) into counter FROM OVPM T0 
WHERE T0."DocEntry" = :list_of_cols_val_tab_del
and T0."U_IntraDivision"='NA'
and  T0."DocType" ='A';
					

IF (:counter> 0) 
		THEN
			error := 342;
			error_message := N'Select Division ';
	END IF;

END IF;

-------------------------------------------------  Cannot Provide Discount in Sale Invoice------------------------------------------------------------------

IF (:object_type = '13' AND (:transaction_type='A' )) THEN

SELECT count(*) into counter FROM OINV T0 
WHERE T0."DocEntry" = :list_of_cols_val_tab_del
and T0."DiscPrcnt"<> 0 ;		

IF (:counter> 0) 
		THEN
			error := 343;
			error_message := N'Can Not Provide Discount in Header, Provide Discount in Item Level';
	END IF;

END IF;

-------------------------------------------------  Cannot Provide Discount in A/R Credit Memo------------------------------------------------------------------

	IF (:object_type = '14' AND (:transaction_type='A' )) THEN

	SELECT count(*) into counter FROM ORIN T0 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del
	and T0."DiscSum"<> 0 ;
			

	IF (:counter> 0) 
			THEN
				error := 344;
				error_message := N'Can Not Provide Discount in Header, Provide Discount in Item Level';
		END IF;

	END IF;

-------------------------------------------------  Cannot Provide Discount in Sale Invoice------------------------------------------------------------------
	IF (:object_type = '13' AND (:transaction_type='A' )) THEN

	SELECT count(*) into counter FROM OINV T0 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del
	and T0."DiscSum"<> 0 ;
			

	IF (:counter> 0) 
			THEN
				error := 345;
				error_message := N'Can Not Provide Discount in Header, Provide Discount in Item Level';
		END IF;

	END IF;
------------------------------------Below Cost Checking in Delivery-----------------------------------------------------------------------------------------------------------
/*
IF (:object_type = '15' AND (:transaction_type='A' )) THEN
	SELECT count(*) into counterVi FROM ODLN T0 
	INNER JOIN DLN1 T1 ON T0."DocEntry" =T1."DocEntry"
	INNER JOIN (SELECT V."ItemCode", V."AvgPrice", V."WhsCode", V."OnHand"
	FROM OITW V INNER JOIN OITM I ON V."ItemCode"= I."ItemCode"
	WHERE V."OnHand" <>0) V ON T1."ItemCode" =V."ItemCode" AND T1."WhsCode" =V."WhsCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T1."Price"<=V."AvgPrice" 
	AND T1."WhsCode" NOT IN ('01-066','02-036','03-036','04-036');

	IF (:counterVi> 0) 
			THEN
				error := 346;
				error_message := N'You are Trying to Sell for Below Cost, Check the Price';
		END IF;

	END IF;
*/

--------------------------------------Below Cost Checking in Invoice-----------------------------------------------------------------------------------------------------------
/*
IF (:object_type = '13' AND (:transaction_type='A' )) THEN
	SELECT count(*) into counterUSDV2 FROM OINV T0 
	INNER JOIN INV1 T1 ON T0."DocEntry" =T1."DocEntry"
	INNER JOIN (SELECT V."ItemCode", V."AvgPrice", V."WhsCode", V."OnHand"
	FROM OITW V INNER JOIN OITM I ON V."ItemCode"= I."ItemCode"
	WHERE V."OnHand" <>0) V ON T1."ItemCode" =V."ItemCode" AND T1."WhsCode" =V."WhsCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."CurSource" <>'L' 
	AND (T1."Price"<=(V."AvgPrice"/T0."DocRate"))
	AND T1."WhsCode" NOT IN ('01-066','02-036','03-036','04-036');

	IF (:counterUSDV2> 0) 
			THEN
				error := 347;
				error_message := N'You are Trying to Sell for Below Cost, Check the Price';
		END IF;

	END IF;
	*/
	--------------------------------------Below Cost Checking in Invoice-----------------------------------------------------------------------------------------------------------
     /*
IF (:object_type = '13' AND (:transaction_type='A' )) THEN
	SELECT count(*) into counterLOCURV2 FROM OINV T0 
	INNER JOIN INV1 T1 ON T0."DocEntry" =T1."DocEntry"
	INNER JOIN (SELECT V."ItemCode", V."AvgPrice", V."WhsCode", V."OnHand"
	FROM OITW V INNER JOIN OITM I ON V."ItemCode"= I."ItemCode"
	WHERE V."OnHand" <>0) V ON T1."ItemCode" =V."ItemCode" AND T1."WhsCode" =V."WhsCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND T0."CurSource"='L' 
	AND T1."Price"<=V."AvgPrice"
	AND T1."WhsCode" NOT IN ('01-066','02-036','03-036','04-036');

	IF (:counterLOCURV2> 0) 
			THEN
				error := 348;
				error_message := N'You are Trying to Sell for Below Cost, Check the Price';
		END IF;

	END IF;
	
	*/
	
----------------------------------------------- Blocking Multiple Payments Against Multiple Invoices -------------------------------------------------------------------------

IF (:object_type = '321' AND (:transaction_type='A' )) THEN

	SELECT count(*) into counterV FROM OITR T0
	INNER JOIN (select R."ReconNum",R."ReconDate", (select COUNT(V."SrcObjTyp") from ITR1 V WHERE V."ReconNum" = K."ReconNum" AND V."SrcObjTyp" ='13') "invNumber"
	, (select COUNT(V."SrcObjTyp") from ITR1 V WHERE V."ReconNum" = K."ReconNum" AND V."SrcObjTyp" ='24') "PaymentNumber"
		,J."U_NAME", R."ReconType"
		from  OITR R 
		LEFT JOIN ITR1 K ON R."ReconNum" =K."ReconNum" 
		LEFT JOIN JDT1 F ON K."TransId" =F."TransId" AND K."ShortName"=F."ShortName"
		LEFT JOIN OINV S ON K."SrcObjAbs" =S."DocEntry"
		LEFT JOIN OUSR J ON R."UserSign"= J."INTERNAL_K"
		WHERE R."Canceled"<>'C') V ON T0."ReconNum" =V."ReconNum"
	 	WHERE T0."ReconNum" =:list_of_cols_val_tab_del 
	 	
	 and V."invNumber">1 AND V."PaymentNumber">1  ;
				IF (:counterV> 0) 
			THEN
				error := 349;
				error_message := N'Multiple Payments cannot be reconciled with Multiple invoices in single reconciliation';
		END IF;

	END IF;
	
-------------------------------------------------A/P Invoice without GRN ------------------------------------------------------------------

IF (:object_type = '18' AND (:transaction_type='A' )) THEN

			SELECT count(*) into counter7 
			FROM  OPCH I INNER JOIN (SELECT
					IFNULL(COUNT( T1."BaseEntry"),0) "Link", T0."DocEntry"
					FROM OPCH T0
					LEFT JOIN PCH1 T1 ON T0."DocEntry"=T1."DocEntry"
					LEFT JOIN OITM T2 ON T1."ItemCode"=T2."ItemCode"
					LEFT JOIN PDN1 T5 ON T1."BaseEntry"=T5."DocEntry" AND T1."BaseLine" = T5."LineNum"
					LEFT JOIN OPDN T3 ON T3."DocEntry"=T5."DocEntry"
					WHERE T0."DocType" ='I' Group BY T0."DocEntry" ) V	ON I."DocEntry" = V."DocEntry"
					
		WHERE V."Link" < 1 
		AND I."DocType" ='I'
				AND I."DocEntry" =:list_of_cols_val_tab_del ;
				IF (:counter7> 0) 
			THEN
				error := 350;
				error_message := N'You are not Allowed to Post Invoice Without Grn "First Post Grn and then post Ap Invoice"';
		END IF;

	END IF;
	----------------------------------Stop Intercompany update to cost center-----------------------------------------------------
	/*
	IF (:object_type = '61' AND (:transaction_type='U' )) THEN
	SELECT count(*) into counter FROM OPRC T0 
	
	WHERE T0."PrcCode" = :list_of_cols_val_tab_del 
	and "UserSign2"='2';
	
	IF (:counter> 0) 
			THEN
				error := 351;
				error_message := N'Intercompany can  not update cost center Name';
		END IF;

	END IF;
	*/
	---------------------Sales Order - Division & COGS Division Must be same ------------------------
IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into counter 
	from 	RDR1 T0, ORDR T1
	where 	T1."DocEntry"=T0."DocEntry"
	and		T1."DocEntry" = :list_of_cols_val_tab_del 
	and 	T0."OcrCode"<>T0."CogsOcrCod";					
IF (:counter> 0) 
	THEN
		error := 352;
		error_message := N'Choose Your division and ensure COGS Division is also same';
	END IF;
END IF;
---------------------Sales Delivery - Division & COGS Division Must be same ------------------------

IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into counter 
	from 	DLN1 T0, ODLN T1
	where 	T1."DocEntry"=T0."DocEntry"
	and		T1."DocEntry" = :list_of_cols_val_tab_del 
	and 	T0."OcrCode"<>T0."CogsOcrCod";					
IF (:counter> 0) 
	THEN
		error := 353;
		error_message := N'Choose Your division and ensure COGS Division is also same';
	END IF;
END IF;
---------------------Sales Invoice - Division & COGS Division Must be same ------------------------
IF (:object_type = '13' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into counter 
	from 	INV1 T0, OINV T1
	where 	T1."DocEntry"=T0."DocEntry"
	and		T1."DocEntry" = :list_of_cols_val_tab_del 
	and 	T0."OcrCode"<>T0."CogsOcrCod";					
IF (:counter> 0) 
	THEN
		error := 354;
		error_message := N'Choose Your division and ensure COGS Division is also same';
	END IF;
END IF;

---------------------Sales Credit Note - Division & COGS Division Must be same ------------------------

IF (:object_type = '14' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into counter 
	from 	RIN1 T0, ORIN T1
	where 	T1."DocEntry"=T0."DocEntry"
	and		T1."DocEntry" = :list_of_cols_val_tab_del 
	and 	T0."OcrCode"<>T0."CogsOcrCod";					
IF (:counter> 0) 
	THEN
		error := 355;
		error_message := N'Choose Your division and ensure COGS Division is also same';
	END IF;
END IF;

---------------------Sales Return - Division & COGS Division Must be same ------------------------

IF (:object_type = '16' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into counter 
	from 	RDN1 T0, ORDN T1
	where 	T1."DocEntry"=T0."DocEntry"
	and		T1."DocEntry" = :list_of_cols_val_tab_del 
	and 	T0."OcrCode"<>T0."CogsOcrCod";					
IF (:counter> 0) 
	THEN
		error := 356;
		error_message := N'Choose Your division and ensure COGS Division is also same';
	END IF;
END IF;

---------------------Purchase Order - Division & COGS Division Must be same ------------------------
IF (:object_type = '22' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into counter 
	from 	POR1 T0, OPOR T1
	where 	T1."DocEntry"=T0."DocEntry"
	and		T1."DocEntry" = :list_of_cols_val_tab_del 
	and 	T0."OcrCode"<>T0."CogsOcrCod";					
IF (:counter> 0) 
	THEN
		error := 357;
		error_message := N'Choose Your division and ensure COGS Division is also same';
	END IF;
END IF;
---------------------Purchase GRPO - Division & COGS Division Must be same ------------------------
/*
IF (:object_type = '20' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into counter 
	from 	PDN1 T0, OPDN T1
	where 	T1."DocEntry"=T0."DocEntry"
	and		T1."DocEntry" = :list_of_cols_val_tab_del 
	and 	T0."OcrCode"<>T0."CogsOcrCod";					
IF (:counter> 0) 
	THEN
		error := 358;
		error_message := N'Choose Your division and ensure COGS Division is also same';
	END IF;
END IF;
*/
---------------------Purchase Invoice - Division & COGS Division Must be same ------------------------
/*
IF (:object_type = '18' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into counter 
	from 	PCH1 T0, OPCH T1
	where 	T1."DocEntry"=T0."DocEntry"
	and		T1."DocEntry" = :list_of_cols_val_tab_del 
	and 	T0."OcrCode"<>T0."CogsOcrCod";					
IF (:counter> 0) 
	THEN
		error := 359;
		error_message := N'Choose Your division and ensure COGS Division is also same';
	END IF;
END IF;
*/
---------------------Purchase Credit Note - Division & COGS Division Must be same ------------------------

IF (:object_type = '19' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into counter 
	from 	RPC1 T0, ORPC T1
	where 	T1."DocEntry"=T0."DocEntry"
	and		T1."DocEntry" = :list_of_cols_val_tab_del 
	and 	T0."OcrCode"<>T0."CogsOcrCod";					
IF (:counter> 0) 
	THEN
		error := 360;
		error_message := N'Choose Your division and ensure COGS Division is also same';
	END IF;
END IF;

---------------------Purchase Return - Division & COGS Division Must be same ------------------------
 /* 
IF (:object_type = '21' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into counter 
	from 	RPD1 T0, ORPD T1
	where 	T1."DocEntry"=T0."DocEntry"
	and		T1."DocEntry" = :list_of_cols_val_tab_del 
	and 	T0."OcrCode"<>T0."CogsOcrCod";					
IF (:counter> 0) 
	THEN
		error := 361;
		error_message := N'Choose Your division and ensure COGS Division is also same';
	END IF;
END IF;
*/
--------------------------Item Price Variance - GRPO-----------------------------------
 /*      
IF (:object_type = '20' AND :transaction_type='A' ) 
                                 
Then 
              
 	select Count(*) into counter1
 	from 	PDN1 
 	where 	"DocEntry" = :list_of_cols_val_tab_del
 	and 	"BaseType" = 22 
 	and 	"BaseEntry" is not null ; 
	
 	IF (:counter1> 0) 
	THEN
	   
		select  count(*) into counter        
	    from 	PDN1 b,POR1 a            
	  	where 	a."DocEntry" = (select Top 1 a."BaseEntry"	from PDN1 a where a."DocEntry" = :list_of_cols_val_tab_del )                    
	 	and  	b."DocEntry" = :list_of_cols_val_tab_del  
	    and 	a."DocEntry" = b."BaseEntry"                               
	    and  	a."ItemCode" = b."ItemCode"      
	    and  	a."LineNum"  = b."BaseLine"  
	    and  	a."Price" 	<> b."Price" ;                                             
    
    IF (:counter> 0) 
	THEN 
		error := 362;
		error_message := N'Price must be same as Base document';
	END IF;
END IF; 
END IF;
*/                     

--------------------------Item Price Variance - AP Invoice-----------------------------------
/* 
         
IF (:object_type = '18' AND :transaction_type='A' ) 
                                 
Then 
              
 	select Count(*) into counter1
 	from 	PCH1 
 	where 	"DocEntry" = :list_of_cols_val_tab_del
 	and 	"BaseType" = 20 
 	and 	"BaseEntry" is not null ; 
	
 	IF (:counter1> 0) 
	THEN
	   
		select  count(*) into counter        
	    from 	PCH1 b,PDN1 a            
	  	where 	a."DocEntry" = (select Top 1 a."BaseEntry"	from PCH1 a where a."DocEntry" = :list_of_cols_val_tab_del )                    
	 	and  	b."DocEntry" = :list_of_cols_val_tab_del  
	    and 	a."DocEntry" = b."BaseEntry"                               
	    and  	a."ItemCode" = b."ItemCode"      
	    and  	a."LineNum"  = b."BaseLine"  
	    and  	a."Price" 	<> b."Price" ;                                             
    
    IF (:counter> 0) 
	THEN 
		error := 363;
		error_message := N'Price must be same as Base document';
	END IF;
END IF; 
END IF;                     

*/
--------------------------Item Price Variance - Delivery-----------------------------------

IF (:object_type = '15' AND :transaction_type='A' ) 
                                 
Then 
              
 	select Count(*) into counter1
 	from 	DLN1
 	where 	"DocEntry" = :list_of_cols_val_tab_del
 	and 	"BaseType" = 17 
 	and 	"BaseEntry" is not null ; 
	
 	IF (:counter1> 0) 
	THEN
	   
		select  count(*) into counter        
	    from 	DLN1 b,RDR1 a            
	  	where 	a."DocEntry" = (select Top 1 a."BaseEntry"	from DLN1 a where a."DocEntry" = :list_of_cols_val_tab_del )                    
	 	and  	b."DocEntry" = :list_of_cols_val_tab_del  
	    and 	a."DocEntry" = b."BaseEntry"                               
	    and  	a."ItemCode" = b."ItemCode"      
	    and  	a."LineNum"  = b."BaseLine"  
	    and  	a."Price" 	<> b."Price";                                             
    
    IF (:counter> 0) 
	THEN 
		error := 364;
		error_message := N'Price must be same as Base document';
	END IF;
END IF; 
END IF;

--------------------------Item Price Variance - AR Invoice-----------------------------------
         
IF (:object_type = '13' AND :transaction_type='A' ) 
                                 
Then 
              
 	select Count(*) into counter1
 	from 	INV1
 	where 	"DocEntry" = :list_of_cols_val_tab_del
 	and 	"BaseType" = 15 
 	and 	"BaseEntry" is not null ; 
	
 	IF (:counter1> 0) 
	THEN
	   
		select  count(*) into counter        
	    from 	INV1 b, DLN1 a            
	  	where 	a."DocEntry" = (select Top 1 a."BaseEntry"	from INV1 a where a."DocEntry" = :list_of_cols_val_tab_del )                    
	 	and  	b."DocEntry" = :list_of_cols_val_tab_del  
	    and 	a."DocEntry" = b."BaseEntry"                               
	    and  	a."ItemCode" = b."ItemCode"      
	    and  	a."LineNum"  = b."BaseLine"  
	    and  	a."Price" 	<> b."Price";                                             
    
    IF (:counter> 0) 
	THEN 
		error := 365;
		error_message := N'Price must be same as Base document';
	END IF;
END IF; 
END IF;


---------------------------------------------------Update Series - Sales Order -  InterCompanny Draft-----------------------------------------------------------------------------
/*
IF (:object_type = '112' AND (:transaction_type='A' )) THEN

SELECT Count(*) into DraftCount 
from 	ODRF a, OFPR b, NNM1 c
where	a."DocEntry" 	= 	:list_of_cols_val_tab_del
and 	a."DocDate" 	between "F_RefDate" and "T_RefDate"
and 	a."ObjType" 	=	'17'
and 	c."ObjectCode" 	=	'17'
--and 	a."UserSign" 	=	'2'
and 	b."Indicator" 	= 	c."Indicator";

	
	IF (:DraftCount >0) 
	THEN
	
	Select  "U_RelPartyDiv" into RelParty
	from 	ODRF a 
	where	a."DocEntry" = 	:list_of_cols_val_tab_del 
	and 	a."ObjType" 	=	'17'	;
				
	
	
		Update 	ODRF
		Set 	"Series" =	(Select Case 	when :RelParty = 'DX' then (Select Top 1 x."Series"
																		from 	NNM1 x, OFPR y,ODRF z
																		where 	x."Indicator" 	= y."Indicator"
																		and 	z."DocDate" between y."F_RefDate" and y."T_RefDate"
																		and 	x."GroupCode"  =1 
																		and 	x."ObjectCode" ='17'
																		and 	z."ObjType"    ='17'
																		and 	z."DocEntry"   =:list_of_cols_val_tab_del 
																		)
											
											When :RelParty = 'AA' then (Select Top 1 x."Series"
																		from 	NNM1 x, OFPR y,ODRF z
																		where 	x."Indicator" 	= y."Indicator"
																		and 	z."DocDate" between y."F_RefDate" and y."T_RefDate"
																		and 	x."GroupCode" = 3 
																		and 	x."ObjectCode" = '17'
																		and 	z."ObjType"    ='17'
																		and 	z."DocEntry" = 	:list_of_cols_val_tab_del )
																		
											When :RelParty = 'RK' then (Select Top 1 x."Series"
																		from 	NNM1 x, OFPR y,ODRF z
																		where 	x."Indicator" 	= y."Indicator"
																		and 	z."DocDate" between y."F_RefDate" and y."T_RefDate"
																		and 	x."GroupCode" = 4 
																		and 	x."ObjectCode" = '17'
																		and 	z."ObjType"    ='17'
																		and 	z."DocEntry" = 	:list_of_cols_val_tab_del 
																		 )
											
											When :RelParty = 'AJ' then (Select Top 1 x."Series"
																		from 	NNM1 x, OFPR y,ODRF z
																		where 	x."Indicator" 	= y."Indicator"
																		and 	z."DocDate" between y."F_RefDate" and y."T_RefDate"
																		and 	x."GroupCode" = 2 
																		and 	x."ObjectCode" = '17'
																		and 	z."ObjType"    ='17'
																		and 	z."DocEntry" = 	:list_of_cols_val_tab_del 
																		 )
									End  from Dummy),
									

				"DocNum" =	(Select Case 	when :RelParty = 'DX' then (Select Top 1 x."NextNumber"
																		from 	NNM1 x, OFPR y,ODRF z
																		where 	x."Indicator" 	= y."Indicator"
																		and 	z."DocDate" between y."F_RefDate" and y."T_RefDate"
																		and 	x."GroupCode" = 1 
																		and 	x."ObjectCode" = '17'
																		and 	z."ObjType"    ='17'
																		and 	z."DocEntry" = 	:list_of_cols_val_tab_del 
																		)
											
											When :RelParty = 'AA' then (Select Top 1 x."NextNumber"
																		from 	NNM1 x, OFPR y,ODRF z
																		where 	x."Indicator" 	= y."Indicator"
																		and 	z."DocDate" between y."F_RefDate" and y."T_RefDate"
																		and 	x."GroupCode" = 3 
																		and 	x."ObjectCode" = '17'
																		and 	z."ObjType"    ='17'
																		and 	z."DocEntry" = 	:list_of_cols_val_tab_del )
																		
											When :RelParty = 'RK' then (Select Top 1 x."NextNumber"
																		from 	NNM1 x, OFPR y,ODRF z
																		where 	x."Indicator" 	= y."Indicator"
																		and 	z."DocDate" between y."F_RefDate" and y."T_RefDate"
																		and 	x."GroupCode" = 4 
																		and 	x."ObjectCode" = '17'
																		and 	z."ObjType"    ='17'
																		and 	z."DocEntry" = 	:list_of_cols_val_tab_del 
																		 )
											
											When :RelParty = 'AJ' then (Select Top 1  x."NextNumber"
																		from 	NNM1 x, OFPR y,ODRF z
																		where 	x."Indicator" 	= y."Indicator"
																		and 	z."DocDate" between y."F_RefDate" and y."T_RefDate"
																		and 	x."GroupCode"  =2 
																		and 	x."ObjectCode" ='17'
																		and 	z."ObjType"    ='17'
																		and 	z."DocEntry"   =:list_of_cols_val_tab_del 
																		 )
									End  
									from Dummy)
			
		where	"DocEntry" = 	:list_of_cols_val_tab_del ;
		
	END IF;

END IF;
*/
------------------------------VAT------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------	
--------------------------------------------SALES INVOICE -------------------------------------------------------------------
/*
IF :object_type = '13' and (:transaction_type='A' or :transaction_type='U'  ) THEN
select Count(*) into counter from "OINV" where (IFNULL("Address",'') = '')  and "DocEntry" = :list_of_cols_val_tab_del;
 if :counter > 0 THEN
	 		error := -1101;
			error_message := 'BilLing Address Is Mandatory For Invoice';
	 END IF;
	

 select Count(*) into counter1 from "OINV" where (IFNULL("Address2",'') = '') and "DocEntry" = :list_of_cols_val_tab_del;
 if :counter1 > 0 THEN
	 		error := -1102;
			error_message := 'Shipping Address Is Mandatory For Invoice';
	 END IF;
	
 END IF;
 

 
--Validation for State is mandatory where the country is UAE.

IF :object_type = '13' and (:transaction_type='A' or :transaction_type='U'  ) THEN

select Count(*) into counter from  INV12 T2 --ON T1."DocEntry"= T2."DocEntry"
--where (IFNULL(T2."StateS",'') = '' ) and T2."DocEntry" = :list_of_cols_val_tab_del;
where (IFNULL(T2."StateS",'') = '' ) AND ( T2."CountryS"='' ) and T2."DocEntry" = :list_of_cols_val_tab_del;
 if :counter > 0 THEN
      error := -1103;
      error_message := 'State is mandatory in Shipping Address';
	 END IF;
 
select Count(*) into counter1 from INV12 T2 
--where (IFNULL(T2."StateB",'') = '') and T2."DocEntry" = :list_of_cols_val_tab_del;
where (IFNULL(T2."StateB",'') = '') and  T2."CountryB"=''  and T2."DocEntry" = :list_of_cols_val_tab_del;
 if :counter1 > 0 THEN
      error := -1104;
      error_message := 'State is mandatory Billing Address';
	 END IF;	 

 END IF;

----------------------------------------BUSINESS PARTENR -----------------------------------
-- BilLing/Shipping Addres Validation 


IF :object_type = '2' AND (:transaction_type = n'A' OR :transaction_type = n'U') THEN

SELECT ( SELECT Distinct T0."CardCode" FROM CRD1 T0 WHERE T0."AdresType"='S'  AND  T0."CardCode" = :list_of_cols_val_tab_del )
INTO temp_var_1 FROM DUMMY;
 
  IF IFNULL(:temp_var_1,'') = '' THEN
    error_message := 'Shipto Address missing';
    error := 366;
   END IF;
   
END IF;
-----------------------------------------------------------------------------------------------------------

IF :object_type = '2' AND (:transaction_type = n'A' OR :transaction_type = n'U') THEN
    
SELECT ( SELECT Distinct T0."CardCode" FROM CRD1 T0 WHERE T0."AdresType"='B'  AND  T0."CardCode" = :list_of_cols_val_tab_del )
INTO temp_var_4 FROM DUMMY;
 
  IF IFNULL(:temp_var_4,'') = '' THEN
    error_message := 'BillTo Address missing';
    error := 367;
   END IF;
   
END IF;
-----------------------------------------------------------------------------------------
---Fedral Tax ID  validation in Business Partner

IF :Object_type ='2' And (:transaction_type = 'A' OR :transaction_type = 'U') then
BEGIN
Select Count(*) into counter from "OCRD" T1  inner join "CRD1" T2 on T1."CardCode"=T2."CardCode"
Where  ifnull(LENGTH(T1."LicTradNum"),0) <>'15' and  T1."CardCode" = :list_of_cols_val_tab_del;
 
 If :counter > 0 Then
 error := 368;
 error_message := 'Either select NOT REGISTERED (15 CHAR) or any 15 digit no.';
 End If ;

END ;
End if ;

---Fedral Tax ID  validation in Business Partner

IF :Object_type ='2' And (:transaction_type = 'A' OR :transaction_type = 'U') then
BEGIN
Select Count(*) into counter from "OCRD" T1  inner join "CRD1" T2 on T1."CardCode"=T2."CardCode"
Where  IFNULL(T1."LicTradNum",'') = '' and T2."Country"='AE' and  T1."CardCode" = :list_of_cols_val_tab_del;
 
 If :counter > 0 Then
 error := 369;
 error_message := 'Please Enter Fedral Tax ID ';
 End If ;

END ;
End if ; 

IF :Object_type ='2' And (:transaction_type = 'A' OR :transaction_type = 'U') then
BEGIN
Select Count(*) into counter from "OCRD" T1  inner join "CRD1" T2 on T1."CardCode"=T2."CardCode"
Where  LENGTH(T1."LicTradNum") >'15' and  T1."CardCode" = :list_of_cols_val_tab_del;
 
 If :counter > 0 Then
 error := 370;
 error_message := 'Lenght Fedral Tax ID is greater than 15';
 End If ;

END ;
End if ;

--State/Country validation in Billing Address

IF :Object_type ='2' And (:transaction_type = 'A' OR :transaction_type = 'U') then
BEGIN
Select Count(*) into counter from "OCRD" T1  inner join "CRD1" T2 on T1."CardCode"=T2."CardCode"
Where (IFNULL(T2."State",'') = '' OR  IFNULL(T2."Country",'') = '' )
and T2."AdresType"='S'  and  T1."CardCode" = :list_of_cols_val_tab_del;
 
 If :counter > 0 Then
 error := 371;
 error_message := 'Can not create BP without State/Country in Shipping Address';
 End If;

END ;
End if;

--State/Country validation in Shipping  Address

IF :Object_type ='2' And (:transaction_type = 'A' OR :transaction_type = 'U') then
BEGIN
Select Count(*) into counter from "OCRD" T1  inner join "CRD1" T2 on T1."CardCode"=T2."CardCode"
Where (IFNULL(T2."State",'') = '' OR  IFNULL(T2."Country",'') = '' )
 and T2."AdresType"='B'  and  T1."CardCode" = :list_of_cols_val_tab_del;
  
 If :counter > 0 Then
 error := 372;
 error_message := 'Can not create BP without State/Country in Billing Address';
 End If ;

END ;
End if ;

--------------------------------------------------------------------------------------------------------------------------------

---Contact person name / Contact mobile number /Contact Telephone/Email/Designation in Supplier

IF :Object_type ='2' And (:transaction_type = 'A' OR :transaction_type = 'U') then
BEGIN
Select Count(*) into VContactP from "OCRD" T1  inner join "OCPR" T2 on T1."CardCode"=T2."CardCode"
Where IFNULL(T2."Name",'') = ''
AND 
T1."CardCode" = :list_of_cols_val_tab_del
AND T1."CardType"='S' ;
  
 If :VContactP > 0 Then
 error := 373;
 error_message := 'Can not create BP without Contact person name  in Supplier';
 End If ;

END ;
End if ;


---Contact person name / Contact mobile number /Contact Telephone/Email/Designation in Supplier

IF :Object_type ='2' And (:transaction_type = 'A' OR :transaction_type = 'U') then
BEGIN
Select Count(*) into VContactP1 from "OCRD" T1  inner join "OCPR" T2 on T1."CardCode"=T2."CardCode"
Where  IFNULL(T2."Cellolar",'') = '' 
AND 
T1."CardCode" = :list_of_cols_val_tab_del
AND T1."CardType"='S' ;
  
 If :VContactP1 > 0 Then
 error := 395;
 error_message := 'Can not create BP without Contact mobile number  in Supplier';
 End If ;

END ;
End if ;


---Contact person name / Contact mobile number /Contact Telephone/Email/Designation in Supplier

IF :Object_type ='2' And (:transaction_type = 'A' OR :transaction_type = 'U') then
BEGIN
Select Count(*) into VContactP2 from "OCRD" T1  inner join "OCPR" T2 on T1."CardCode"=T2."CardCode"
Where  IFNULL(T2."Tel1",'') = '' 
AND 
T1."CardCode" = :list_of_cols_val_tab_del
AND T1."CardType"='S' ;
  
 If :VContactP2 > 0 Then
 error := 396;
 error_message := 'Can not create BP without Contact Telephone in Supplier';
 End If ;

END ;
End if ;


---Contact person name / Contact mobile number /Contact Telephone/Email/Designation in Supplier

IF :Object_type ='2' And (:transaction_type = 'A' OR :transaction_type = 'U') then
BEGIN
Select Count(*) into VContactP3 from "OCRD" T1  inner join "OCPR" T2 on T1."CardCode"=T2."CardCode"
Where IFNULL(T2."E_MailL",'') = '' 
AND 
T1."CardCode" = :list_of_cols_val_tab_del
AND T1."CardType"='S' ;
  
 If :VContactP3 > 0 Then
 error := 397;
 error_message := 'Can not create BP without Email in Supplier';
 End If ;

END ;
End if ;


---Contact person name / Contact mobile number /Contact Telephone/Email/Designation in Supplier

IF :Object_type ='2' And (:transaction_type = 'A' OR :transaction_type = 'U') then
BEGIN
Select Count(*) into VContactP4 from "OCRD" T1  inner join "OCPR" T2 on T1."CardCode"=T2."CardCode"
Where  IFNULL(T2."Profession",'') = '' 
AND 
T1."CardCode" = :list_of_cols_val_tab_del
AND T1."CardType"='S' ;
  
 If :VContactP4 > 0 Then
 error := 398;
 error_message := 'Can not create BP without Designation in Supplier';
 End If ;

END ;
End if ;

--State/Country validation in Shipping  Address

IF :Object_type ='2' And (:transaction_type = 'A' OR :transaction_type = 'U') then
BEGIN
Select Count(*) into VContactP5 from "OCRD" T1 
Where (IFNULL(T1."CntctPrsn",'') = '' ) AND
T1."CardCode" = :list_of_cols_val_tab_del
AND T1."CardType"='S' ;
  
 If :VContactP5 > 0 Then
 error := 399;
 error_message := 'Can not create BP without Contact person ';
 End If ;

END ;
End if ;


*/
---------------------------------------------------------------------------------------------------------------
--------------------------------------------AR credit note -----------------------------------------------------------------
/*
IF :object_type = '14' and (:transaction_type='A' or :transaction_type='U'  ) THEN
select Count(*) into counter from "ORIN" where (IFNULL("Address",'') = '')  and "DocEntry" = :list_of_cols_val_tab_del;
 if :counter > 0 THEN
	 		error := -2101;
			error_message := 'BilLing Address Is Mandaory For Invoice';
	 END IF;
	

 select Count(*) into counter1 from "ORIN" where (IFNULL("Address2",'') = '') and "DocEntry" = :list_of_cols_val_tab_del;
 if :counter1 > 0 THEN
	 		error := -2102;
			error_message := 'Shipping Address Is Mandaory For Invoice';
	 END IF;
	
 END IF;
 
--Validation for State is mandatory where the country is UAE.


IF :object_type = '14' and (:transaction_type='A' or :transaction_type='U'  ) THEN

select Count(*) into counter from  RIN12 T2 --ON T1."DocEntry"= T2."DocEntry"
where (IFNULL(T2."StateS",'') = '' ) and T2."DocEntry" = :list_of_cols_val_tab_del;
 if :counter > 0 THEN
      error := -2103;
      error_message := 'State is mandatory in Shipping Address';
	 END IF;
 
select Count(*) into counter1 from RIN12 T2 
where (IFNULL(T2."StateB",'') = '') and T2."DocEntry" = :list_of_cols_val_tab_del;
 if :counter1 > 0 THEN
      error := -2104;
      error_message := 'State is mandatory Billing Address';
	 END IF;	 

 END IF;
 
*/
--------------------------------------------Delivery Note -----------------------------------------------------------------
/*
IF :object_type = '15' and (:transaction_type='A' or :transaction_type='U'  ) THEN
select Count(*) into counter from "ODLN" where (IFNULL("Address",'') = '')  and "DocEntry" = :list_of_cols_val_tab_del;
 if :counter > 0 THEN
	 		error := -3101;
			error_message := 'BilLing Address Is Mandaory For Invoice';
	 END IF;
	

 select Count(*) into counter1 from "ODLN" where (IFNULL("Address2",'') = '') and "DocEntry" = :list_of_cols_val_tab_del;
 if :counter1 > 0 THEN
	 		error := -3106;
			error_message := 'Shipping Address Is Mandaory For Invoice';
	 END IF;
	
 END IF;
 
--Validation for State is mandatory where the country is UAE.

IF :object_type = '15' and (:transaction_type='A' or :transaction_type='U'  ) THEN

select Count(*) into counter from  DLN12 T2 --ON T1."DocEntry"= T2."DocEntry"
where (IFNULL(T2."StateS",'') = '' ) and T2."DocEntry" = :list_of_cols_val_tab_del;
 if :counter > 0 THEN
      error := -3103;
      error_message := 'State is mandatory in Shipping Address';
	 END IF;
 
select Count(*) into counter1 from DLN12 T2 
where (IFNULL(T2."StateB",'') = '') and T2."DocEntry" = :list_of_cols_val_tab_del;
 if :counter1 > 0 THEN
      error := -3104;
      error_message := 'State is mandatory Billing Address';
	 END IF;	 

 END IF;
*/
---------------------Sales Invoice Advance Type validation ------------------------------------------------------------------

IF (:object_type = '13' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	SELECT COUNT(T0."DocEntry") INTO WMSCNTADVTYPE 
	FROM OINV T0 
	WHERE IFNULL(T0."U_SDueType",'NA')= 'AT'  AND ifnull(T0."U_AdvanceSubcategory",'-') = '-' 
	AND T0."DocEntry" = :list_of_cols_val_tab_del ;
	
IF (:WMSCNTADVTYPE> 0) 
	THEN
		error := 375;
		error_message := N'PLease Choose Advance Sub Category';
	END IF;
END IF;
---------------------Sales Credit Memo Advance Type validation ------------------------------------------------------------------

IF (:object_type = '14' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	SELECT COUNT(T0."DocEntry") INTO WMSCNTADVTYPE 
	FROM ORIN T0 
	WHERE IFNULL(T0."U_SDueType",'NA')= 'AT'  AND ifnull(T0."U_AdvanceSubcategory",'-') = '-' 
	AND T0."DocEntry" = :list_of_cols_val_tab_del ;
	
IF (:WMSCNTADVTYPE> 0) 
	THEN
		error := 376;
		error_message := N'PLease Choose Advance Sub Category';
	END IF;
END IF;
---------------------Incoming Payment Advance Type validation ------------------------------------------------------------------

IF (:object_type = '24' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	SELECT COUNT(T0."DocEntry") INTO WMSCNTADVTYPE 
	FROM ORCT T0 
	WHERE IFNULL(T0."U_DueType",'NA')= 'AT'  AND ifnull(T0."U_AdvanceSubcategory",'-') = '-' 
	AND T0."DocEntry" = :list_of_cols_val_tab_del ;
	
IF (:WMSCNTADVTYPE> 0) 
	THEN
		error := 377;
		error_message := N'PLease Choose Advance Sub Category';
	END IF;
END IF;

---------------------Purchase Invoice Advance Type validation ------------------------------------------------------------------

IF (:object_type = '18' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	SELECT COUNT(T0."DocEntry") INTO WMSCNTADVTYPE 
	FROM OPCH T0 
	WHERE IFNULL(T0."U_PDueType",'NA')= 'AF'  AND ifnull(T0."U_AdvanceSubcategory",'-') = '-' 
	AND T0."DocEntry" = :list_of_cols_val_tab_del ;
	
IF (:WMSCNTADVTYPE> 0) 
	THEN
		error := 378;
		error_message := N'PLease Choose Advance Sub Category';
	END IF;
END IF;
---------------------Purchase Credit Memo Advance Type validation ------------------------------------------------------------------

IF (:object_type = '19' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	SELECT COUNT(T0."DocEntry") INTO WMSCNTADVTYPE 
	FROM ORPC T0 
	WHERE IFNULL(T0."U_PDueType",'NA')= 'AF'  AND ifnull(T0."U_AdvanceSubcategory",'-') = '-' 
	AND T0."DocEntry" = :list_of_cols_val_tab_del ;
	
IF (:WMSCNTADVTYPE> 0) 
	THEN
		error := 379;
		error_message := N'PLease Choose Advance Sub Category';
	END IF;
END IF;
---------------------OutGoing Payment Advance Type validation ------------------------------------------------------------------

IF (:object_type = '46' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	SELECT COUNT(T0."DocEntry") INTO WMSCNTADVTYPE 
	FROM OVPM T0 
	WHERE IFNULL(T0."U_DueType",'NA')= 'AF'  AND ifnull(T0."U_AdvanceSubcategory",'-') = '-' 
	AND T0."DocEntry" = :list_of_cols_val_tab_del ;
	
IF (:WMSCNTADVTYPE> 0) 
	THEN
		error := 380;
		error_message := N'PLease Choose Advance Sub Category';
	END IF;
END IF;

---------------------JE Advance Type validation ------------------------
IF (:object_type = '30' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	Select 	count(*) into WMSCNTADVTYPE 
	from 	JDT1 T0, OJDT T1
	where 	T1."TransId"=T0."TransId"
	and		T1."TransId" = :list_of_cols_val_tab_del 
	and 	T1."TransType" = '30'
	and 	ifnull(T1."U_AdvanceSubcategory",'-') = '-'
	and 	ifnull(T0."Account",'') in ('2200801000','1500901000');					
IF (:WMSCNTADVTYPE> 0) 	THEN
		error := 381;
		error_message := N'PLease Choose Advance Sub Category';
	END IF;
END IF;
-----------------BLOCK ZERO VALUE GRPO POSTING------------------------------------
If   :object_type = '20' AND (:transaction_type='A' or :transaction_type='U') 
Then
SELECT  COUNT(*) into counter 
FROM OPDN T0
INNER JOIN PDN1 T1 ON T1."DocEntry"=T0."DocEntry"
where IFNULL(T1."Price",0)= 0 and T0."DocEntry"  = :list_of_cols_val_tab_del ;
                   
 If (counter >0 ) then
    error := 382;
    error_message := 'Zero value GRPO Will not be posted.';
END IF;
END IF;
----------Negative quantity should not allow to save the GRPO-------------------------------------
If   :object_type = '20' AND (:transaction_type='A' or :transaction_type='U') 
Then
SELECT  COUNT(*) into counter 
FROM PDN1 T1
INNER JOIN OPDN T0 ON T1."DocEntry"=T0."DocEntry"
where T1."Quantity" < 0 and T0."DocEntry"  = :list_of_cols_val_tab_del ;
                   
 If (counter >0 ) then
    error := 383;
    error_message := 'Negative quantity should not allow to save the GRPO';
    
END IF;
END IF;

-------------------------PDC notification for blocking the Deposit if Incomming not created---------------------------

IF (:object_type = 'NS_IOCP' and :transaction_type='A') THEN
GroupName := '';
DocTotal := 0;

Select IFNULL("U_BPCode",'') , IFNULL("U_PayDueLC",0) into GroupName , DocTotal From "@NS_IOCP" Where "DocEntry" = :list_of_cols_val_tab_del;
IF (:GroupName = '') THEN 
error := -0001;
error_message := 'BP Code is missing';
ELSEIF (:DocTotal = 0) THEN 
error := -0001;
error_message := 'Payment (LC) is Zero';
END IF ;
END IF ;


IF (:object_type = 'NS_IOSP' and :transaction_type='A') THEN
GroupName := '';
DocTotal := 0;

Select IFNULL("U_BPCode",'') , IFNULL("U_PayDueLC",0) into GroupName , DocTotal From "@NS_IOSP" Where "DocEntry" = :list_of_cols_val_tab_del;
IF (:GroupName = '') THEN 
error := -0001;
error_message := 'BP Code is missing';
ELSEIF (:DocTotal = 0) THEN 
error := -0001;
error_message := 'Payment (LC) is Zero';
END IF ;
END IF ;

----------------------- Discount is not allowed in GRPO row level-------------------------------------
If   :object_type = '20' AND (:transaction_type='A' or :transaction_type='U') 
Then
SELECT  COUNT(*) into counter 
FROM PDN1 T1
INNER JOIN OPDN T0 ON T1."DocEntry"=T0."DocEntry"
where T1."DiscPrcnt" <> 0 and T0."DocEntry"  = :list_of_cols_val_tab_del ;
                   
 If (counter >0 ) then
    error := 384;
    error_message := 'Discount is not allowed in GRPO row level';
    
END IF;
END IF;
--------------------------------------------------------------------------------------------------------------

/*IF (:object_type = 'NS_PDCM ' and (:transaction_type='A' OR :transaction_type='U' )) THEN
counter := 0;
counter1 := 0;
Select COUNT(1) INTO counter 
From "@NS_PDCM" T0 
INNER JOIN "@NS_PDCM1" T1 ON T1."DocEntry" = T0."DocEntry"
INNER JOIN "@NS_IOCP" T3 ON T1."U_DocEntry"=T3."DocEntry" 
INNER JOIN "@NS_IOCP1" T2 ON T2."DocEntry" = T3."DocEntry"
Where T0."DocEntry" = :list_of_cols_val_tab_del
and (IfNull(T3."U_PayDoc",'')='' or IfNull(T3."U_DPInv",'')= '');


if(IFNULL(:counter,0)>0) 

THEN 
error := -14990;
error_message := 'Payment Not Posted, Please concern with Admin' ;
END IF;
END IF; */

-------------------------- PDC Received (incoming) :Period Indicator should be (19-20) -------------------------------------

/* Vino
If   :object_type = 'NS_IOCP' AND (:transaction_type='A' ) 
Then
SELECT  COUNT(*) into counter 
FROM "@NS_IOCP" T1
INNER JOIN NNM1 T0 on  T0."Series"= T1."Series" 
where T0."Indicator" <>'19-20' and T1."DocEntry"  = :list_of_cols_val_tab_del ;
                                     
 If (counter >0 ) then
    error := 016;
    error_message := 'Period Indicator should be (19-20).';
    
END IF;
END IF;

----------------------- PDC Payment (Outgoing) :Period Indicator should be (19-20) -------------------------------------
If   :object_type = 'NS_IOSP' AND (:transaction_type='A' ) 
Then
SELECT  COUNT(*) into counter 
FROM "@NS_IOSP" T1
INNER JOIN NNM1 T0 on  T0."Series"= T1."Series" 
where T0."Indicator" <>'19-20' and T1."DocEntry"  = :list_of_cols_val_tab_del ;
                   
 If (counter >0 ) then
    error := 017;
    error_message := 'Period Indicator should be (19-20).';
    
END IF;
END IF;

----------------------- PDC Deposit (Incoming) :Period Indicator should be (19-20) -------------------------------------
If   :object_type = 'NS_PDCM' AND (:transaction_type='A' ) 
Then
SELECT  COUNT(*) into counter 
FROM "@NS_PDCM" T1
INNER JOIN NNM1 T0 on  T0."Series"= T1."Series" 
where T0."Indicator" <>'19-20' and T1."DocEntry"  = :list_of_cols_val_tab_del ;
                   
 If (counter >0 ) then
    error := 018;
    error_message := 'Period Indicator should be (19-20).';
    
END IF;
END IF;

----------------------- PDC Payment Deposit:Period Indicator should be (19-20) -------------------------------------
If   :object_type = 'NS_PDSM' AND (:transaction_type='A' ) 
Then
SELECT  COUNT(*) into counter 
FROM "@NS_PDSM" T1
INNER JOIN NNM1 T0 ON  T0."Series"= T1."Series" --T0."ObjectCode"= T1."Object"
where T0."Indicator" <>'19-20' and T1."DocEntry"  = :list_of_cols_val_tab_del ;
                   
 If (counter >0 ) then
    error := 019;
    error_message := 'Period Indicator should be (19-20).';
    
END IF;
END IF;

*/
-------------------------------------------------------------------

----------------- ASTM ITEMS DESCRIPTION CHANGE IN SALES QUOTATION--- 

IF (:object_type = '23' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into VDescSalesOr FROM OQUT T0 
	INNER JOIN QUT1 T1 ON T0."DocEntry" =T1."DocEntry" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	INNER JOIN OITM T2 ON T1."ItemCode"=T2."ItemCode"
	WHERE T1."Dscription"<>T2."ItemName"
	AND T0."DocEntry" = :list_of_cols_val_tab_del AND   T2."ItmsGrpCod"<>'392'
	AND T1."ItemCode" IN (SELECT  V."ItemCode" FROM "VITEMPROPERTIES" V WHERE V."ParentGroup" IN ('Ms Pipe (Black)','Ms Pipe (Painted)','Galvanized Pipe'))	;
	IF (:VDescSalesOr> 0) 
			THEN
				error := 385;
				error_message := N'You cannot change description for these items';
		END IF;

	END IF;
----------------- ASTM ITEMS DESCRIPTION CHANGE IN SALES ORDER---
 
IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into VDescSalesOr FROM ORDR T0 
	INNER JOIN RDR1 T1 ON T0."DocEntry" =T1."DocEntry" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	INNER JOIN OITM T2 ON T1."ItemCode"=T2."ItemCode"
	WHERE T1."Dscription"<>T2."ItemName"
	AND T0."DocEntry" = :list_of_cols_val_tab_del AND  T2."ItmsGrpCod"<>'392'
	AND T1."ItemCode" IN (SELECT  V."ItemCode" FROM "VITEMPROPERTIES" V WHERE V."ParentGroup" IN ('Ms Pipe (Black)','Ms Pipe (Painted)','Galvanized Pipe'));
	IF (:VDescSalesOr> 0) 
			THEN
				error := 386;
				error_message := N'You cannot change description for these items';
		END IF;
	END IF;
----------------- ASTM ITEMS DESCRIPTION CHANGES IN DELIVERY--- 

IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into VDescSalesOr FROM ODLN T0 
	INNER JOIN DLN1 T1 ON T0."DocEntry" =T1."DocEntry" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	INNER JOIN OITM T2 ON T1."ItemCode"=T2."ItemCode"
	WHERE T1."Dscription"<>T2."ItemName"
	AND T0."DocEntry" = :list_of_cols_val_tab_del AND  T2."ItmsGrpCod"<>'392'
	AND T1."ItemCode" IN (SELECT  V."ItemCode" FROM "VITEMPROPERTIES" V WHERE V."ParentGroup" IN ('Ms Pipe (Black)','Ms Pipe (Painted)','Galvanized Pipe'));
	IF (:VDescSalesOr> 0) 
			THEN
				error := 387;
				error_message := N'You cannot change description for these items';
		END IF;

	END IF;
----------------- ASTM ITEMS DESCRIPTION CHANGES IN INVOICE----------------

IF (:object_type = '13' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
	SELECT count(*) into VDescSalesOr FROM OINV T0 
	INNER JOIN INV1 T1 ON T0."DocEntry" =T1."DocEntry" 
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	INNER JOIN OITM T2 ON T1."ItemCode"=T2."ItemCode"
	WHERE T1."Dscription"<>T2."ItemName"
	AND T0."DocEntry" = :list_of_cols_val_tab_del AND  T2."ItmsGrpCod"<>'392'
	AND T1."ItemCode" IN (SELECT  V."ItemCode" FROM "VITEMPROPERTIES" V WHERE V."ParentGroup" IN ('Ms Pipe (Black)','Ms Pipe (Painted)','Galvanized Pipe'));
	IF (:VDescSalesOr> 0) 
			THEN
				error := 388;
				error_message := N'You cannot change description for these items';
		END IF;

	END IF;
-------------------------------------------------  Cannot P Invoice w DEL -----------------------------------------------------

IF (:object_type = '13' AND (:transaction_type='A' ))
 THEN

SELECT count(T1."BaseType") INTO Vinocounter 
 FROM OINV T0 INNER JOIN INV1 T1 ON T0."DocEntry" = T1."DocEntry"
 WHERE T1."BaseType" ='-1' 
 ---AND T0."CardCode"<>'UNI-00000001' VINO
  AND T0."DocType" = 'I' 
  ---AND T0."IsICT"='N' 
  AND 	  T0."DocEntry" = :list_of_cols_val_tab_del;
 
IF (:Vinocounter> 0) 
		THEN
			error := 389;
			error_message := N'You cannot post Invoice without Sales Order, Please post Sales order first to continue';
	END IF;

END IF;
---------------------------------------------------------------------------------------------------------------
-------Sales Quotation Blocking without Price----
/*

IF (:object_type = '23' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
SELECT count(*) into VCounterPrice1 FROM OQUT T0 
INNER JOIN QUT1 T1 ON T0."DocEntry" =T1."DocEntry"
--INNER JOIN (SELECT DISTINCT K."ItemCode" FROM "VITEMPROPERTIESASTM" K) T2 ON T1."ItemCode" =T2."ItemCode"  vino
INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 
INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del 
AND T1."ItemCode" NOT IN (SELECT R."ItemCode" FROM ASTM_MAX_V_MT R );

IF (:VCounterPrice1> 0) 
			THEN
				error := 390;
				error_message := N'First enter the Price List for ASTM';
		END IF;
	END IF; 	

---------------------------------------------------------------------------------------------------------------
---Sales Order Blocking without Price----

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
SELECT count(*) into VCounterPrice2 FROM ORDR T0 
INNER JOIN RDR1 T1 ON T0."DocEntry" =T1."DocEntry"
--INNER JOIN (SELECT DISTINCT K."ItemCode" FROM "VITEMPROPERTIESASTM" K) T2 ON T1."ItemCode" =T2."ItemCode" vino
INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 

INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del 
AND T1."ItemCode" NOT IN (SELECT R."ItemCode" FROM VAstmMax  R );

IF (:VCounterPrice2> 0) 
			THEN
				error := 391;
				error_message := N'First enter the Price List for ASTM';
		END IF;
	END IF; 	

   ---------------------------------------------------------------------------------------------------------------
---Sales Order Blocking without Sales Base Price----

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U'))

THEN
	SELECT count(*) into counterVMT FROM ORDR T0 
	INNER JOIN RDR1 T1 ON T0."DocEntry" =T1."DocEntry"
	INNER JOIN ITM1 T2 ON T1."ItemCode" =T2."ItemCode"  AND T2."PriceList"='10'
	INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND  
    IFNULL(T2."Price",0)=0 ;	

	IF (:counterVMT> 0) 
			THEN
				error := 262;
				error_message := N'First enter the Price for Sales Base Price';
		END IF;

	END IF;

-----vinoth RAJ
---------------------------------------------------------------------------------------------------------------

---Sales delivery Blocking without Price----

IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
SELECT count(*) into VCounterPrice3 FROM ODLN T0 
INNER JOIN DLN1 T1 ON T0."DocEntry" =T1."DocEntry"
--INNER JOIN (SELECT DISTINCT K."ItemCode" FROM "VITEMPROPERTIESASTM" K) T2 ON T1."ItemCode" =T2."ItemCode" 
INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 

INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del 
AND T1."ItemCode" NOT IN (SELECT R."ItemCode" FROM VAstmMax  R )
AND T3."GroupCode"<>'104' 
;

IF (:VCounterPrice3> 0) 
			THEN
				error := 392;
				error_message := N'First enter the Price List for ASTM';
		END IF;
	END IF; 	
---------------------------------------------------------------------------------------------------------------

---Sales Invoice  Blocking without Price----

IF (:object_type = '13' AND (:transaction_type='A' OR :transaction_type='U'))
THEN
SELECT count(*) into VCounterPrice4 FROM OINV T0 
INNER JOIN INV1 T1 ON T0."DocEntry" =T1."DocEntry"
--INNER JOIN (SELECT DISTINCT K."ItemCode" FROM "VITEMPROPERTIESASTM" K) T2 ON T1."ItemCode" =T2."ItemCode" 
INNER JOIN (SELECT DISTINCT "ItemCode" FROM ASTM_VITEMS) T2 ON T1."ItemCode" =T2."ItemCode" 
INNER JOIN OCRD T3 ON T0."CardCode"=T3."CardCode"
WHERE T0."DocEntry" = :list_of_cols_val_tab_del 
AND T1."ItemCode" NOT IN (SELECT R."ItemCode" FROM VAstmMax  R )
AND T3."GroupCode"<>'104' 
;

IF (:VCounterPrice4> 0) 
			THEN
				error := 393;
				error_message := N'First enter the Price List for ASTM';
		END IF;
	END IF; 
*/	
-----------------------Item Master Data---------------------------------------------------------------------------------------

IF :object_type='4' AND (:transaction_type ='A'  OR :transaction_type ='U') Then

Select Count(*) into VCounterPricngGroup  from OITM T0 Where

T0."ItemType"='I' AND 
T0."FirmCode" = '-1'
and T0."ItemCode"=:list_of_cols_val_tab_del;

IF (:VCounterPricngGroup> 0) 
			THEN
				error := 394;
				error_message := N'Choose the Pricing Group';
		END IF;
	END IF; 	

-----------------------Item Master Data---------------------------------------------------------------------------------------

IF :object_type='4' AND (:transaction_type ='A'  OR :transaction_type ='U') Then

Select Count(*) into VBatchProd  from OITM T0 Where

T0."ItemType"='I' AND 
T0."ManBtchNum"='N'
and T0."ItemCode"=:list_of_cols_val_tab_del;

IF (:VBatchProd> 0) 
			THEN
				error := 394;
				error_message := N'Kindly Enable the Batch for Product';
		END IF;
	END IF; 	

-------------------------------------------------------------------------------------------------------------

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U'))

THEN
	SELECT count(*) into salesCreditLimit FROM ORDR T0 
	INNER JOIN OCRD T1 ON T0."CardCode"=T1."CardCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del 
	AND T1."CreditLine" < ( T1."Balance" + T1."DNotesBal")
	--AND T1."U_internalapproval" < (  T1."Balance" + T1."DNotesBal") 
	--AND T1."U_limitfrominsurance" < (  T1."Balance" + T1."DNotesBal") 
	;
	IF (:salesCreditLimit> 0) 
			THEN
				error := 395;
				error_message := N'You are trying to exceed the Credit Limit. You cannot post Sales Order';
		END IF;

	END IF;


-------------------------------------------------------------------------------------------------------------

IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U'))

THEN
	SELECT count(*) into DeliveryCredit FROM ODLN T0 
	INNER JOIN OCRD T1 ON T0."CardCode"=T1."CardCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del 
	AND T1."CreditLine" < ( T1."Balance" + T1."DNotesBal")
	--AND T1."U_internalapproval" < (  T1."Balance" + T1."DNotesBal") 
	--AND T1."U_limitfrominsurance" < (  T1."Balance" + T1."DNotesBal") 
	;

	IF (:DeliveryCredit> 0) 
			THEN
				error := 396;
				error_message := N'You are trying to exceed the Credit Limit. You cannot post Delivery';
		END IF;
	END IF;
	
	--------------------------------  Vendor Invoice No and Recpt Date in A P Invoice---------------------------------------------

IF (:object_type ='18' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(*) into JtaxD 
	FROM OPCH T0  
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del
	AND 
	IFNULL(T0."U_DocumentReceiptDate",'')='' ;	

	if (:JtaxD > 0) 
		then 
		error := 399;
		error_message := N'Choose the Document Receipt Date';
	end if;
END IF;	


---------------------------------------------------------------------------------------------------------------

IF (:object_type ='18' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(*) into JtaxD 
	FROM OPCH T0  
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del	
	AND
	IFNULL(T0."U_VendorInvoiceDate",'')='';
	
	if (:JtaxD > 0) 
		then 
		error := 399;
		error_message := N'Choose the Vendor Invoice Date';
	end if;
END IF;	

---------------------------------------------------------------------------------------------------------------

IF (:object_type ='18' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(*) into JtaxD 
	FROM OPCH T0  
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del	
	AND	
	IFNULL(T0."U_VendorInvoiceNo",'')='';

	if (:JtaxD > 0) 
		then 
		error := 399;
		error_message := N'Choose the Vendor Invoice No';
	end if;
END IF;	

--------------------------Return Reason for Credit note-----------------------------------------------------------------

IF (:object_type ='14' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	
SELECT count(*) into JtaxD 
	FROM ORIN T0
	INNER JOIN RIN1 T1 ON T0."DocEntry"=T1."DocEntry"  
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del	
	AND	
	IFNULL(T1."U_Reason",'')='';

	if (:JtaxD > 0) 
		then 
		error := 399;
		error_message := N'Choose Return Reason in the Line Level';
	end if;
END IF;	

------------------------------------------Division blcoking in JE-----------------------------------------
/*
IF (:object_type = '30' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	
	SELECT COUNT(*) INTO VJEDIV FROM OJDT T0 
	INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId" 
	WHERE T1."TransType" = '30' AND IFNULL(T1."ProfitCode",'')='' 
	AND T0."TransId"=:list_of_cols_val_tab_del;
	
	IF (:VJEDIV> 0) THEN
		error := 1;
		error_message := N'Please Choose the Division';
	END IF;
END IF;




------------------------------------------------------------------------------------------------



IF (:object_type = '30' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	
	SELECT COUNT(*) INTO VJEDIV FROM OJDT T0 
	INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId" 
	WHERE T1."TransType" = '30' AND IFNULL(T1."ProfitCode",'')='' 
	AND T0."TransId"=:list_of_cols_val_tab_del;
	
	IF (:VJEDIV> 0) THEN
		error := 1;
		error_message := N'Please Choose the Division';
	END IF;
END IF;
*/

--INCOMING PAYMENTS

IF (:object_type = '24' AND (:transaction_type='C')) 

THEN
	
	SELECT COUNT(*) INTO VDPCHK FROM OCHH A 
	INNER JOIN DPS1 B ON A."CheckKey"=B."CheckKey"
	INNER JOIN ODPS C ON B."DepositId"=C."DeposId"
	WHERE IFNULL(C."CnclDps",0)=-1 AND B."DepCancel"='N' AND A."RcptNum"=:list_of_cols_val_tab_del;
	
	IF (:VDPCHK> 0) THEN
		error := 1;
		error_message := N'Deposit is already created';
	END IF;
END IF;

--SALES QUOTATION
/*
IF (:object_type = '23' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

	SELECT COUNT(*) INTO VDPCHK FROM OQUT A INNER JOIN QUT1 B ON A."DocEntry"=B."DocEntry" 
	INNER JOIN OCRD C ON A."CardCode"=C."CardCode"
	WHERE C."GroupCode" NOT IN ('109','110') AND IFNULL(B."U_BSDENT",0)='0' AND A."DocEntry"=:list_of_cols_val_tab_del;
			
	IF (:VDPCHK> 0) THEN
		error := 2;
		error_message := N'You cannot create direct Sales Quotation to this Customer';
	END IF;
END IF;
*/

IF (:object_type = '23' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

	SELECT COUNT(*) INTO VDPCHK FROM OQUT WHERE "SlpCode"=-1 AND "DocEntry"=:list_of_cols_val_tab_del;
			
	IF (:VDPCHK> 0) THEN
		error := 3;
		error_message := N'Sales Employee is missing';
	END IF;
END IF;

IF (:object_type = '23' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

	SELECT COUNT(*) INTO VDPCHK FROM OQUT WHERE IFNULL("U_OrderType1",'')='' AND "DocEntry"=:list_of_cols_val_tab_del;
			
	IF (:VDPCHK> 0) THEN
		error := 4;
		error_message := N'Order Type is missing';
	END IF;
END IF;

--SALES ORDER

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

	SELECT COUNT(*) INTO VDPCHK FROM ORDR WHERE "SlpCode"=-1 AND "DocEntry"=:list_of_cols_val_tab_del;
			
	IF (:VDPCHK> 0) THEN
		error := 3;
		error_message := N'Sales Employee is missing';
	END IF;
END IF;

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

	SELECT COUNT(*) INTO VDPCHK FROM ORDR WHERE IFNULL("U_OrderType1",'')='' AND "DocEntry"=:list_of_cols_val_tab_del;
			
	IF (:VDPCHK> 0) THEN
		error := 4;
		error_message := N'Order Type is missing';
	END IF;
END IF;

--DELIVERY

IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

	SELECT COUNT(*) INTO VDPCHK FROM ODLN WHERE "SlpCode"=-1 AND "DocEntry"=:list_of_cols_val_tab_del;
			
	IF (:VDPCHK> 0) THEN
		error := 3;
		error_message := N'Sales Employee is missing';
	END IF;
END IF;

--AR INVOICE

IF (:object_type = '13' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

	SELECT COUNT(*) INTO VDPCHK FROM OINV WHERE "SlpCode"=-1 AND "DocEntry"=:list_of_cols_val_tab_del;
			
	IF (:VDPCHK> 0) THEN
		error := 3;
		error_message := N'Sales Employee is missing';
	END IF;
END IF;

---------------------------------------------------------------------------------------------------------------

--------------------------Credit Limit Check at Sales Order -----
/*

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN
	SELECT COUNT(T0."DocEntry") INTO DeliveryVME 
	FROM ORDR T0 
	INNER JOIN OCRD T1  ON T0."CardCode"=T1."CardCode"
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del
---	AND T1."U_LockforSales"='Y'
	AND T1."CardCode" IN (SELECT DISTINCT V."CardCode" FROM OINV V WHERE (V."DocTotal" -V."PaidToDate") <> 0 AND DAYS_BETWEEN (V."DocDate",CURRENT_DATE) >=180) ;
	
IF (:DeliveryVME> 0) 
	THEN
		error := 879;
		error_message := N'Invoices are Over due, Kindly collect the Payment before taking  New Sales Order.';
	END IF;
END IF;

*/
------------------------------------Back Dated Entry is not allowed----------------------------------------

--SO & SQ

IF (:object_type IN ('23','17') AND (:transaction_type='A')) 
THEN	
	IF (:object_type='23') THEN
		SELECT COUNT(*) INTO VDPCHK FROM OQUT 
		WHERE TO_VARCHAR("DocDate",'YYYYMMDD')<TO_VARCHAR(CURRENT_DATE,'YYYYMMDD')
		AND "DocEntry"=:list_of_cols_val_tab_del;
	ELSEIF (:object_type='17') THEN
		SELECT COUNT(*) INTO VDPCHK FROM ORDR 
		WHERE TO_VARCHAR("DocDate",'YYYYMMDD')<TO_VARCHAR(CURRENT_DATE,'YYYYMMDD')
		AND "DocEntry"=:list_of_cols_val_tab_del;
	END IF;

	IF (:VDPCHK> 0) THEN
		error := 1001;
		error_message := N'Back Dated Entry is not allowed';
	END IF;
END IF;



------UTP and TTP PO----------


IF (:object_type = '22' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM OPOR A 
INNER JOIN POR1 B ON A."DocEntry"=B."DocEntry"
INNER JOIN "DSSITEMLINK" C ON C."ItemCode"=B."ItemCode"
WHERE B."WhsCode" NOT IN (
--'01-105','01-106','02-043','03-044','04-044','01-107','01-108','02-044','03-045','04-045','IC_DS(G)'
'01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
AND A."CardCode" IN ('S_10401','S_10500')
AND C."ITEMTYPE" IN ('MS Tube (Black)','MS Tube (Painted)','Galvanized Tube')
AND A."DocEntry"=:list_of_cols_val_tab_del)Z;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Select this warehouses only 01-080,01-081,02-041,03-041,04-041,01-078,01-079,02-040,03-040,04-040';
	END IF;
END IF;

-----KHK PO----------


IF (:object_type = '22' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM OPOR A 
INNER JOIN POR1 B ON A."DocEntry"=B."DocEntry"
INNER JOIN "DSSITEMLINK" C ON C."ItemCode"=B."ItemCode"
WHERE B."WhsCode" NOT IN (
--'01-111','01-112','02-045','03-046','04-046'
'01-082','01-083','02-042','03-042','04-042')
AND A."CardCode" IN ('S_10200')
AND C."ITEMTYPE" IN ('MS Tube (Black)','MS Tube (Painted)','Galvanized Tube')
AND A."DocEntry"=:list_of_cols_val_tab_del)Z;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Select this warehouses only 01-082,01-083,02-042,03-042,04-042';
	END IF;
END IF;



/*


IF (:object_type = '22' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM OPOR A INNER JOIN POR1 B ON A."DocEntry"=B."DocEntry"
WHERE B."WhsCode" NOT IN ('01-105','01-106','02-043','03-044','04-044','01-107','01-108','02-044','03-045','04-045')
AND A."CardCode" IN ('S_10401','S_10500')
AND A."DocEntry"=:list_of_cols_val_tab_del)Z;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Select this warehouses only 01-105,01-106,02-043,03-044,04-044,01-107,01-108,02-044,03-045,04-045';
	END IF;
END IF;
*/

--UTP and TTP GRPO--
/*

IF (:object_type = '20' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM OPDN A INNER JOIN PDN1 B ON A."DocEntry"=B."DocEntry"
WHERE B."WhsCode" NOT IN ('01-105','01-106','02-043','03-044','04-044','01-107','01-108','02-044','03-045','04-045')
AND A."CardCode" IN ('S_10401','S_10500')
AND A."DocEntry"=:list_of_cols_val_tab_del)Z;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Select this warehouses only 01-105,01-106,02-043,03-044,04-044,01-107,01-108,02-044,03-045,04-045';
	END IF;
END IF;
*/

--GRPO KHK--

IF (:object_type = '20' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM OPDN A 
INNER JOIN PDN1 B ON A."DocEntry"=B."DocEntry"
INNER JOIN "DSSITEMLINK" C ON C."ItemCode"=B."ItemCode"
WHERE B."WhsCode" NOT IN (
--'01-111','01-112','02-045','03-046','04-046'
'01-082','01-083','02-042','03-042','04-042')
AND A."CardCode" IN ('S_10200')
AND C."ITEMTYPE" IN ('MS Tube (Black)','MS Tube (Painted)','Galvanized Tube')
AND A."DocEntry"=:list_of_cols_val_tab_del)Z;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Select this warehouses only 01-082,01-083,02-042,03-042,04-042';
	END IF;
END IF;

--GRPO UTP and TTP--

IF (:object_type = '20' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM OPDN A 
INNER JOIN PDN1 B ON A."DocEntry"=B."DocEntry"
INNER JOIN "DSSITEMLINK" C ON C."ItemCode"=B."ItemCode"
WHERE B."WhsCode" NOT IN (
--'01-105','01-106','02-043','03-044','04-044','01-107','01-108','02-044','03-045','04-045','IC_DS(G)'
'01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
AND A."CardCode" IN ('S_10401','S_10500')
AND C."ITEMTYPE" IN ('MS Tube (Black)','MS Tube (Painted)','Galvanized Tube')
AND A."DocEntry"=:list_of_cols_val_tab_del)Z;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Select this warehouses only 01-080,01-081,02-041,03-041,04-041,01-078,01-079,02-040,03-040,04-040';
	END IF;
END IF;


----SO new---
/*
IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('01-105','01-106','02-043','03-044','04-044','01-107','01-108','02-044','03-045','04-045')
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ORDR A INNER JOIN RDR1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 01-080,01-081,02-041,03-041,04-041,01-078,01-079,02-040,03-040,04-040';
	END IF;
END IF;

*/

--DELIVERY--
/*

IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('01-105','01-106','02-043','03-044','04-044','01-107','01-108','02-044','03-045','04-045')
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ODLN A INNER JOIN DLN1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 01-080,01-081,02-041,03-041,04-041,01-078,01-079,02-040,03-040,04-040';
	END IF;
END IF;
*/

----SO new---

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('01-080','01-078')                         
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('01-105','01-107')                  
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('01-105','01-107'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ORDR A INNER JOIN RDR1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 01-105, 01-107';
	END IF;
END IF;

----SO new---

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('01-081','01-079')                         /*new*/
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('01-106','01-108')                   /*old*/
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('01-106','01-108'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ORDR A INNER JOIN RDR1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 01-106,01-108';
	END IF;
END IF;


----SO new---

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('02-041','02-040')                         /*new*/
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('02-043','02-044')                   /*old-- if stock is here new will not update*/
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('02-043','02-044'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ORDR A INNER JOIN RDR1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 02-043,02-044';
	END IF;
END IF;

----SO new---

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('03-040','03-041')                         /*new*/
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('03-044','03-045')                   /*old-- if stock is here new will not update*/
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('03-044','03-045'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ORDR A INNER JOIN RDR1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 03-040,03-041';
	END IF;
END IF;

----SO new---

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('04-040','04-041')                         /*new*/
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('04-044','04-045')                   /*old-- if stock is here new will not update*/
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('04-044','04-045'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ORDR A INNER JOIN RDR1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 04-044,04-045';
	END IF;
END IF;

----SO new---

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('01-082')                         /*new*/
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('01-111')                   /*old-- if stock is here new will not update*/
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('01-111'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ORDR A INNER JOIN RDR1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouse of 01-111';
	END IF;
END IF;

----SO new---

IF (:object_type = '17' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('01-083')                         /*new*/
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('01-112')                   /*old-- if stock is here new will not update*/
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('01-112'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ORDR A INNER JOIN RDR1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouse of 01-112';
	END IF;
END IF;

--DELIVERY--
/*

IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('01-105','01-107')
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('01-080','01-078')
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('01-080','01-078'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ODLN A INNER JOIN DLN1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 01-080, 01-078';
	END IF;
END IF;

--DELIVERY--


IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('01-106','01-108')
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('01-081','01-079')
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('01-081','01-079'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ODLN A INNER JOIN DLN1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 01-081,01-079';
	END IF;
END IF;

--DELIVERY--


IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('02-043','02-044')
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('02-041','02-040')
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('02-041','02-040'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ODLN A INNER JOIN DLN1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 02-041,02-040';
	END IF;
END IF;

--DELIVERY--


IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('03-044','03-045')
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('03-040','03-041')
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('03-040','03-041'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ODLN A INNER JOIN DLN1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 03-040,03-041';
	END IF;
END IF;

--DELIVERY--


IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('04-044','04-045')
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('04-040','04-041')
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('04-040','04-041'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ODLN A INNER JOIN DLN1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouses of 04-040,04-041';
	END IF;
END IF;

--DELIVERY--


IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('01-111')
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('01-082')
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('01-082'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ODLN A INNER JOIN DLN1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouse of 01-082';
	END IF;
END IF;

--DELIVERY--


IF (:object_type = '15' AND (:transaction_type='A' OR :transaction_type='U')) 

THEN	

SELECT COUNT(*) INTO VDPCHK  FROM (SELECT * FROM (
SELECT *,
CASE WHEN (SELECT COUNT(*) FROM OWHS WHERE 
"WhsCode" NOT IN ('01-112')
AND "WhsCode"=Z."WhsCode")>0 THEN 'False' ELSE 
CASE WHEN Z."WhsCode" NOT IN ('01-083')
THEN CASE WHEN Z."Stock">0 THEN 'True' ELSE 'False' END
ELSE 'False' END END "Status"
FROM (
SELECT B."ItemCode",B."Quantity",B."WhsCode",
(SELECT SUM("OnHand") FROM OITW WHERE "ItemCode"=B."ItemCode" 
AND "WhsCode" IN ('01-083'))
---(SELECT SUM("Quantity") FROM DLN1 WHERE "ItemCode"=B."ItemCode" 
--AND "WhsCode" IN ('01-080','01-081','02-041','03-041','04-041','01-078','01-079','02-040','03-040','04-040')
--AND "DocEntry"=A."DocEntry") 
"Stock"
FROM ODLN A INNER JOIN DLN1 B ON A."DocEntry"=B."DocEntry"
WHERE A."CANCELED"='N' AND A."DocEntry"=:list_of_cols_val_tab_del
)Z)Z1 WHERE Z1."Status"='True')Y;

	IF (:VDPCHK> 0) THEN
		error := 501;
		error_message := N'Stocks are there in this warehouse of 01-083';
	END IF;
END IF;

*/
-----------------Restriction for Warehouses in warehouse tranfer ---------------------------------- 


IF (:object_type = '67' AND (:transaction_type='A' OR :transaction_type='U')) THEN 
  SELECT COUNT (*) INTO VDPCHK
  FROM OWTR T3
  INNER JOIN WTR1 T4 ON T3."DocEntry" = T4."DocEntry" 
  WHERE T3."DocEntry"=:list_of_cols_val_tab_del AND  
  T4."WhsCode" IN ('01-080','01-081',
'02-041',
'03-041',
'04-041',
'01-078',
'01-079',
'02-040',
'03-040',
'04-040')
  AND T4."FromWhsCod" IN ('01-105',
'01-106',
'02-043',
'03-044',
'04-044',
'01-107',
'01-108',
'02-044',
'03-045',
'04-045');

  IF (:VDPCHK > 0) THEN
            error := 501;
            error_message := N'Not Allowed to transfer the New stock to Old warehouse';
  
  END IF;
END IF;


 -----------------Restriction for Warehouses in warehouse tranfer ---------------------------------- 

IF (:object_type = '67' AND (:transaction_type='A' OR :transaction_type='U')) THEN 

  SELECT COUNT (*) INTO VDPCHK
  FROM OWTR T3
  INNER JOIN WTR1 T4 ON T3."DocEntry" = T4."DocEntry" 
  WHERE T3."DocEntry"=:list_of_cols_val_tab_del AND  
  T4."FromWhsCod" IN ('01-080','01-081',
'02-041',
'03-041',
'04-041',
'01-078',
'01-079',
'02-040',
'03-040',
'04-040')
  AND T4."WhsCode" IN ('01-105',
'01-106',
'02-043',
'03-044',
'04-044',
'01-107',
'01-108',
'02-044',
'03-045',
'04-045');

  IF (:VDPCHK > 0) THEN
            error := 501;
            error_message := N'Not Allowed to transfer the Old stock to New warehouse';
  
  END IF;
END IF;


-------------------------------A/P Invoice Feight -------------------------------

IF (:object_type ='18' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into VPurFrght
	FROM OPCH T0 
	INNER JOIN PCH3 T1 ON T0."DocEntry"=T1."DocEntry" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del  
	AND (IFNULL(T1."OcrCode",'') ='') AND T1."LineTotal" <> 0 ;

	if (:VPurFrght > 0) 
		then 
		error := 783;
		error_message := N'Kindly Choose the Division in Freight';
	end if;
END IF;

-------------------------------A/R Invoice Feight -------------------------------

IF (:object_type ='13' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into VPurFrght
	FROM OINV T0 
	INNER JOIN INV3 T1 ON T0."DocEntry"=T1."DocEntry" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del  
	AND (IFNULL(T1."OcrCode",'') ='') AND T1."LineTotal" <> 0 ;

	if (:VPurFrght > 0) 
		then 
		error := 783;
		error_message := N'Kindly Choose the Division in Freight';
	end if;
END IF;


------------------------------Fixed asset seection in the A/P iNVOICE -----------------------------------------------------

IF (:object_type ='18' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
	Select count(T0."DocEntry") into VDivOVPMAset 
	FROM OPCH T0 
	INNER JOIN PCH1 T1 ON T0."DocEntry"=T1."DocEntry" 
	WHERE T0."DocEntry" = :list_of_cols_val_tab_del AND (IFNULL(T1."OcrCode4",'') ='') 
	AND T1."AcctCode" IN ('5300608000','6300109000','6100505000','6200105000','6200104000','6200101000','6100302000','6200102000','6100301000');

if (:VDivOVPMAset > 0) 
		then 
		error := 290;
		error_message := N'Chose the Asset';
	end if;
END IF;

/*
******************** Total GP based Restriction on Sales Quotation --VR
*/

IF (:object_type ='23' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
Select Count(Z2."DocEntry") into VBasePriceDiff
from
(Select Z1."DocEntry",SUM(Z1."PL LineTotal") "PL LineTotal",SUM(Z1."Actual LineTotal") "Actual LineTotal",
SUM(Z1."Actual LineTotal"-Z1."PL LineTotal")"Diff"
From
(Select Z."DocEntry",(Z."PL Price"*Z."Quantity") "PL LineTotal",(Z."Actual Price") "Actual LineTotal"
From
(Select A."ItemCode",B."DocEntry",
IfNULL((Select MAX("Price") From VBASEPL  where "ItemCode"=A."ItemCode" and "UomCode"=A."UomCode"),0) "PL Price",
A."Quantity",A."LineTotal" "Actual Price"
from QUT1 A
 inner join OQUT B on B."DocEntry"=A."DocEntry" 
WHERE B."DocEntry"=:list_of_cols_val_tab_del
AND  A."WhsCode" NOT IN ('03-036','02-036','01-066','01-087','04-036')
AND B."CardCode"NOT IN ('UNI-00000001','C-MCT-01308510','C_20100','C_10702','C-RKT-07125821','C-SLL-01315809')
)Z)Z1
Group By Z1."DocEntry")Z2
WHERE Z2."Diff"<=0; --and Z2."DocEntry"='48224'

if (:VBasePriceDiff > 0) 
		then 
		error := 292;
		error_message := N'Gross Profit Less than 1 AED based on the our Internal Selling Price';
	end if;
END IF;
----------------------------
/*
******************** Total GP based Restriction on Sales Order --VR
*/

IF (:object_type ='17' AND (:transaction_type='A' OR :transaction_type='U') )
THEN 
Select Count(Z2."DocEntry") into VBasePriceDiff
from
(Select Z1."DocEntry",SUM(Z1."PL LineTotal") "PL LineTotal",SUM(Z1."Actual LineTotal") "Actual LineTotal",
SUM(Z1."Actual LineTotal"-Z1."PL LineTotal")"Diff"
From
(Select Z."DocEntry",(Z."PL Price"*Z."Quantity") "PL LineTotal",(Z."Actual Price") "Actual LineTotal"
From
(Select A."ItemCode",B."DocEntry",
IfNULL((Select MAX("Price") From VBASEPL  where "ItemCode"=A."ItemCode" and "UomCode"=A."UomCode"),0) "PL Price",
A."Quantity",A."LineTotal" "Actual Price"
from RDR1 A
 inner join ORDR B on B."DocEntry"=A."DocEntry" 
WHERE B."DocEntry"=:list_of_cols_val_tab_del
AND  A."WhsCode" NOT IN ('03-036','02-036','01-066','01-087','04-036')
 
AND B."CardCode"NOT IN ('UNI-00000001','C-MCT-01308510','C_20100','C_10702','C-RKT-07125821','C-SLL-01315809')

)Z)Z1
Group By Z1."DocEntry")Z2
WHERE Z2."Diff"<=0; --and Z2."DocEntry"='48224'

if (:VBasePriceDiff > 0) 
		then 
		error := 292;
		error_message := N'Gross Profit Less than 1 AED based on the our Internal Selling Price';
	end if;
END IF;

-----------------------------------------------------Invoice without Delivery & directly from sales ----------------------------------------------------------------

IF (:object_type = '13' AND (:transaction_type='A' ))
 THEN

SELECT count(T1."BaseType") INTO VinocounterCRMEMO
 FROM OINV T0 INNER JOIN INV1 T1 ON T0."DocEntry" = T1."DocEntry"
 WHERE T1."BaseType" IN ('-1','17') AND T0."DocType" = 'I' 
 AND 	T0."DocEntry" = :list_of_cols_val_tab_del;
 
IF (:VinocounterCRMEMO> 0) 
		THEN
			error := -989;
			error_message := N'Can Not Post Sales Invoice Without Sales Delivery';
	END IF;

END IF;	

---------------------------------------------------------------
--------------------- UDF- LockForsales---------------

	IF (:object_type = '2' AND (:transaction_type='A' OR :transaction_type='U'))
 THEN

SELECT COUNT(*) INTO LockForsales
FROM OCRD A INNER JOIN OUSR B ON B."USERID"=A."UserSign" 
WHERE A."CardCode"=:list_of_cols_val_tab_del AND 
B."USER_CODE" IN('VRK02753','SP00179','Purchase','MAR00221')--,'')
AND A."U_LockforSales"='N';

IF (:LockForsales> 0) 
		THEN
			error := 1;
			error_message := N'You are not authorized to Update';
	END IF;
	END IF;	

	
---------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------

select :error, :error_message FROM dummy;
end;