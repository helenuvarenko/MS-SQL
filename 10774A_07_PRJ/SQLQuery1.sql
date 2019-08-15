SET NOCOUNT ON;

IF OBJECT_ID('Sales.Somedates') IS NOT NULL 
	DROP TABLE Sales.Somedates;

CREATE TABLE Sales.Somedates (
	isitdate varchar(9)
);

INSERT INTO Sales.Somedates (isitdate) VALUES 
	('20110101'),
	('20110102'),
	('20110103X'),
	('20110104'),
	('20110105'),
	('20110106'),
	('20110107Y'),
	('20110108');

SET NOCOUNT OFF;

select isitdate, 
    case when isdate(isitdate) = 1 then convert(date, isitdate)
    else null end as converteddate
from Sales.Somedates;