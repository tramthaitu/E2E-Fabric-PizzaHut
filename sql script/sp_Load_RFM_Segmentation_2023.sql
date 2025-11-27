CREATE OR ALTER   PROCEDURE [Dim].[sp_Load_RFM_Segmentation_2023]
AS
BEGIN
    SET NOCOUNT ON;

    DROP TABLE IF EXISTS FabricDWH.Dim.RFM_Segmentation_2023;
    SELECT
        CustomerID,
        CAST(TransactionDate AS DATE) AS TransactionDate,  
        CAST(SalesAmount AS DECIMAL) AS SalesAmount,
        CAST(LastOrder AS DATE) AS LastOrder,
        CAST(ReportDate AS DATE) AS ReportDate,
        Recency,
        Frequency,
        Monetary,
        Cluster,
        CAST(DATEADD(HOUR, 7, GETDATE()) AS DATETIME2(6)) AS LoadedDatetime
    INTO FabricDWH.Dim.RFM_Segmentation_2023
    FROM FabricStaging.dbo.rfm_segmentation_2023;
END;
