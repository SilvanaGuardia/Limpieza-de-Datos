
----- Crear Tabla -----
CREATE DATABASE clean_data;

----- Importar el archivo csv -----
USE clean_data;

----- Muestra -----
SELECT * FROM hrdataset LIMIT 10;

----- store procedure (procesos almacenado) -----
DELIMITER //
CREATE PROCEDURE info()
	BEGIN
	    SELECT * FROM hrdataset;
	END //
DELIMITER ; 

CALL info;

	-- ----- Renombrar los nombres de las columnas -----
	ALTER TABLE hrdataset CHANGE COLUMN `ï»¿EmpID` ID varchar(20) null;
ALTER TABLE hrdataset CHANGE COLUMN `DOB` birth_date varchar(20) null;

----- Dividir apellido y nombre  -----
SELECT ID,
       SUBSTRING_INDEX(Employee_Name, ',', 1) AS First_Name,
       TRIM(SUBSTRING_INDEX(Employee_Name, ',', -1)) AS Last_Name,
       LOCATE(',',Employee_Name) AS Nombres
FROM hrdataset;

SELECT ID,
       SUBSTRING(Employee_Name, 1, LOCATE(',', Employee_Name) - 1) AS Last_Name,
       TRIM(SUBSTRING(Employee_Name, LOCATE(',', Employee_Name) + 1)) AS First_Name
FROM hrdataset;

-- Agrega columnas de apellido y nombre a la tabla empleados --
ALTER TABLE hrdataset
ADD COLUMN Last_Name VARCHAR(255),
ADD COLUMN First_Name VARCHAR(255);

-- Actualiza las nuevas columnas con los datos extraídos de la columna nombre_completo --
UPDATE hrdataset
SET Last_Name = SUBSTRING_INDEX(Employee_Name, ',', 1),
    First_Name = TRIM(SUBSTRING_INDEX(Employee_Name, ',', -1));

-- Mover columna de lugar --
ALTER TABLE hrdataset MODIFY COLUMN Last_Name VARCHAR(255) AFTER ID;
ALTER TABLE hrdataset MODIFY COLUMN First_Name VARCHAR(255) AFTER Last_Name;

-- Eliminar table Employee_Name -- 
ALTER TABLE hrdataset DROP COLUMN Employee_Name;

CALL info;

-- Validar si tenemos duplicados --
SELECT ID, COUNT(*) AS cantidad_duplicados
FROM hrdataset
GROUP BY ID  
HAVING COUNT(*) > 1;

-- Cambiar celda de Gender --
UPDATE hrdataset
SET GenderID = REPLACE(GenderID, 'M', 'Male');
UPDATE hrdataset
SET GenderID = REPLACE(GenderID, 'F', 'Female');

-- Valores de la Tabla --
DESCRIBE hrdataset;

-- Cambia formato de fecha en columna cumpleaños --
SELECT birth_date FROM hrdataset;

ALTER TABLE hrdataset MODIFY COLUMN birth_date date;

SELECT birth_date, CASE
    WHEN birth_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birth_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birth_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birth_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END AS new_birth_date
FROM hrdataset;

UPDATE hrdataset
SET birth_date = CASE
	WHEN birth_date LIKE '%/%' THEN date_format(str_to_date(birth_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN birth_date LIKE '%-%' THEN date_format(str_to_date(birth_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

-- Cambia formato de fecha en columna DateofHire --
SELECT DateofHire FROM hrdataset;

SELECT DateofHire, CASE
    WHEN DateofHire LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(DateofHire, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN DateofHire LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(DateofHire, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END AS new_DateofHire
FROM hrdataset;

UPDATE hrdataset
SET DateofHire = CASE
	WHEN DateofHire LIKE '%/%' THEN date_format(str_to_date(DateofHire, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN DateofHire LIKE '%-%' THEN date_format(str_to_date(DateofHire, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hrdataset MODIFY COLUMN DateofHire date;

-- Cambia formato de fecha en columna DateofTermination --
SELECT DateofTermination FROM hrdataset;

SELECT DateofTermination, CASE
    WHEN DateofTermination LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(DateofTermination, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN DateofTermination LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(DateofTermination, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END AS new_DateofTermination
FROM hrdataset;

UPDATE hrdataset
SET DateofTermination = CASE
	WHEN DateofTermination LIKE '%/%' THEN date_format(str_to_date(DateofTermination, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN DateofTermination LIKE '%-%' THEN date_format(str_to_date(DateofTermination, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hrdataset MODIFY COLUMN DateofTermination date;

-- Cambia formato de fecha en columna LastPerformanceReview_Date --
SELECT LastPerformanceReview_Date FROM hrdataset;

SELECT LastPerformanceReview_Date, CASE
    WHEN LastPerformanceReview_Date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(LastPerformanceReview_Date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN LastPerformanceReview_Date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(LastPerformanceReview_Date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END AS new_LastPerformanceReview_Date
FROM hrdataset;

UPDATE hrdataset
SET LastPerformanceReview_Date = CASE
	WHEN LastPerformanceReview_Date LIKE '%/%' THEN date_format(str_to_date(LastPerformanceReview_Date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN LastPerformanceReview_Date LIKE '%-%' THEN date_format(str_to_date(LastPerformanceReview_Date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hrdataset MODIFY COLUMN DateofTermination date;


-- Validar si hay espacion en la columna salario
SELECT Salary, TRIM(Salary) AS Salary
FROM hrdataset
WHERE LENGTH(Salary) - LENGTH(TRIM(Salary)) > 0;



CALL info;













