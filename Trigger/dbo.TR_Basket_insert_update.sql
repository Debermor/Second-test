create or alter trigger  dbo.TR_Basket_insert_update on dbo.Basket
after insert
as
begin
	/* 
		Создал временный стол, так как он лучше справлялся с многократным вводом таких данных как, 
		(2,1,5,600,'2024-04-08'),
		(2,1,3,350,'2024-04-08'),
		(1,1,3,150,'2024-04-08'),
		(3,1,3,350,'2024-04-08'),
		(3,1,3,350,'2024-04-08')
		а ещё это просто.
	*/
	select ID_SKU, count(ID_SKU) as id_count
		--Правила не нашел, решил сделать отступ
		into #TempCount
	from inserted
	group by ID_SKU

	update b
	set DiscountValue = case 
							when id_count >= 2 and i.ID = b.ID
								then b.Value * 0.05
							else 0
						end
	from dbo.Basket as b
		inner join #TempCount as t ON t.ID_SKU = b.ID_SKU
		--Что бы обновлялись только те строки, которые только добавили. 
		inner join inserted as i ON i.ID = b.ID
	where i.ID = b.ID
end
;