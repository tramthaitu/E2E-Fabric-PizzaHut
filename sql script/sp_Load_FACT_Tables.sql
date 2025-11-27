CREATE OR ALTER   PROCEDURE [Fact].[sp_Load_FACT_Table]
AS
BEGIN
    SET NOCOUNT ON;

    ----------------------------------------
    -- 1️⃣ FACT_SALES
    ----------------------------------------
    DROP TABLE IF EXISTS FabricDWH.Fact.Sales;

    SELECT
        a.BillID AS BillID,                             
        a.Channel AS Channel,                           
        a.OrderFrom AS OrderFrom,                       
        CAST(a.TransactionDate AS DATE) AS TransactionDate,  
        CAST(a.SalesAmount AS DECIMAL) AS SalesAmount,       
        a.CustomerID AS CustomerID,                     
        a.VoucherStatus AS VoucherStatus,             
        a.Store_ID AS Store_ID,                         
        CAST(DATEADD(HOUR, 7, GETDATE()) AS DATETIME2(6)) AS LoadedDatetime
    INTO FabricDWH.Fact.Sales
    FROM FabricStaging.dbo.fact_sales a;  

END;
