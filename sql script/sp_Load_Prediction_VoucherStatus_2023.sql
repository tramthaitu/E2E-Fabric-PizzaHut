CREATE OR ALTER   PROCEDURE [Fact].[sp_Load_Prediction_VoucherStatus_2023]
AS
BEGIN
    SET NOCOUNT ON;
    DROP TABLE IF EXISTS FabricDWH.Fact.Prediction_VoucherStatus_2023;
    SELECT 
        BillID,
        Channel,
        OrderFrom,
        CAST(TransactionDate AS DATE) AS TransactionDate,  
        CAST(SalesAmount AS DECIMAL) AS SalesAmount,
        CustomerID,
        Store_ID,
        CustomerGender,
        Region,
        Year,
        Month,
        Quarter,
        DayOfWeek,
        Voucher_Predict_Label,
        CAST(DATEADD(HOUR, 7, GETDATE()) AS DATETIME2(6)) AS LoadedDatetime
    INTO FabricDWH.Fact.Prediction_VoucherStatus_2023
    FROM FabricStaging.dbo.prediction_voucherstatus_2023;
END;
