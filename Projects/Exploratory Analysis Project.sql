-- Exploratory Analysis

SELECT *
FROM layoffs_staging2;


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- find everything of 100% laid off company besd on fund raising 
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- find company wise sum of total_laid_off
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- find the date of minimum laid off and maximum laid off
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- find country wise total laid off
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;


SELECT * 
FROM layoffs_staging2;

-- find year wise maximum laid off with tatal laid off
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

-- find stage wise total laid off
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- find average percentage laid off a company 
SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- find month wise total laid off 
SELECT SUBSTRING(`date`, 1,7) AS `month`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC;

-- find monthly total laid off 
WITH rolling_total AS 
(
	SELECT SUBSTRING(`date`, 1,7) AS `month`, SUM(total_laid_off) AS total_off
	FROM layoffs_staging2
	WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
	GROUP BY `month`
	ORDER BY 1 ASC
)
SELECT `month`, total_off,
SUM(total_off) OVER(ORDER BY `month`) AS rolling_total
FROM rolling_total;

-- find company wise yearly laid off 
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- find year wise top 5 companies as max laid off using CTE
WITH company_year (company, years, total_laid_of)AS
(
	SELECT company, YEAR(`date`), SUM(total_laid_off)
	FROM layoffs_staging2
	GROUP BY company, YEAR(`date`)
), company_year_ranking AS
(
	SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_of DESC) AS ranking
	FROM company_year
	WHERE years IS NOT NULL
)
SELECT *
FROM company_year_ranking
WHERE ranking <=5
;


































