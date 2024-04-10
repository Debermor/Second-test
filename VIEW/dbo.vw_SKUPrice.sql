create or alter view dbo.vw_SKUPrice as 
	select ID, Code, Name, dbo.udf_GetSKUPrice(ID) as Price
	from  dbo.SKU 
;