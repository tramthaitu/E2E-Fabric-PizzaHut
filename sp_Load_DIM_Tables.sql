CREATE OR ALTER       PROCEDURE [Dim].[sp_Load_DIM_Table]
AS
BEGIN
    SET NOCOUNT ON;

    ----------------------------------------
    -- 1️⃣ DIM_CUSTOMER
    ----------------------------------------
    DROP TABLE IF EXISTS FabricDWH.Dim.Customer;

    SELECT
        a.CustomerID AS CustomerID,
        a.CustomerGender AS Gender,
        CAST(DATEADD(HOUR, 7, GETDATE()) AS DATETIME2(6)) AS LoadedDatetime
    INTO FabricDWH.Dim.Customer
    FROM FabricStaging.dbo.dim_customer a;


    ----------------------------------------
    -- 2️⃣ DIM_STORE
    ----------------------------------------
    DROP TABLE IF EXISTS FabricDWH.Dim.Store;

    SELECT
        a.Store_ID AS StoreID,
        a.Region AS Region,
        CAST(DATEADD(HOUR, 7, GETDATE()) AS DATETIME2(6)) AS LoadedDatetime
    INTO FabricDWH.Dim.Store
    FROM FabricStaging.dbo.dim_store a;


    ----------------------------------------
    -- 3️⃣ DIM_DATE
    ----------------------------------------
     DROP TABLE IF EXISTS FabricDWH.Dim.Date;

    SELECT
        a.Date,
        a.Year,
        a.Quarter,
        a.YearQuarter,
        a.YearQuarterNumber,
        a.RankYearQuarter,
        
        a.Month,
        a.MonthNumber,
        a.MonthShort,
        a.YearMonth,
        a.YearMonthNumber,
        a.YearMonthShort,
        a.RankYearMonth,

        a.DayofWeek,
        a.DayofWeekNumber,
        a.DayofWeekShort,
        CAST(DATEADD(HOUR, 7, GETDATE()) AS DATETIME2(6)) AS LoadedDatetime
    INTO FabricDWH.Dim.Date
    FROM FabricStaging.dbo.dim_date a;

END;
