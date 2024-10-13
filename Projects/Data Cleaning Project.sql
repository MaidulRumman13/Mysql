-- Data Cleaning Project

SELECT *
FROM layoffs;


-- 1. Remove Duplicates
-- 2. Standarize the Data
-- 3. Null Values or Blank Values
-- 4. Remove Any Columns or Rows

-- create a new table as like as raw data set for safty
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffS_staging
SELECT * 
FROM layoffs;


-- 1. Remove Duplicates


SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;


SELECT *
FROM layoffs_staging
WHERE company = 'Casper'
;

-- trying to delete duplicate rows from CTE but actually it's not possibe.
WITH duplicate_cte AS
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE
FROM duplicate_cte
WHERE row_num > 1;



CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` double DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

-- create another table for deleting duplicate rows 
INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE 
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;



-- 2. Standarize the Data


-- how to trim unnecessary gaps from company name.
SELECT company, TRIM(company)
FROM layoffs_staging2
;

-- trim and update the company
UPDATE layoffs_staging2
SET company = TRIM(company);

-- checking industry 
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

-- chacking industry name as crypto
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- update name as crypto
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- checking location
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;


-- checking country
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

-- removing . from the end of the country name 
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- changing the date in date format.
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2
;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');


-- creating an alter table for changing the data type of date coulmn
ALTER TABLE layoffs_staging2
MODIFY COLUMN  `date` DATE;



-- 3. Null Values or Blank Values


SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- find & update blank row of the company 
-- find
SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- update blank row to null
UPDATE layoffs_staging2 
SET industry = NULL
WHERE industry = '';

-- update
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry =  t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- again check that there is any null value or blank
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

-- found one so confirm it 
SELECT *
FROM layoffs_staging2
WHERE company LIKE 'bally%';

SELECT *
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

-- delete null valuse from  total_laid_off & percentage_laid_off
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

SELECT *
FROM layoffs_staging2;


-- 4. Remove Any Columns or Rows


-- drop a column row_num
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;












