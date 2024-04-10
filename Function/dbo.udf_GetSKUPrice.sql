create or alter function dbo.udf_GetSKUPrice (
	@ID_SKU int
)
returns decimal(18,2)
as
begin
	declare @getprice decimal(18,2)
	set @getprice = (select SUM(Value) / SUM(Quantity)
					 from dbo.Basket 
					 where ID_SKU = @ID_SKU
					 )
	return @getprice
end
;
