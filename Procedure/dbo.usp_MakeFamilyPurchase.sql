create or alter procedure dbo.usp_MakeFamilyPurchase(
	@FamilySurName varchar(255)
)
as
begin	
	if not exists(select SurName from dbo.Family where SurName = @FamilySurName)
		begin
			raiserror('Не найдена семья',16,1);
		end

	update f
	set 
		BudgetValue = BudgetValue - (select sum(ISNULL(b.value,0)) 
									 from dbo.Basket as b 
										right join  dbo.Family as f ON f.ID = b.ID_Family
									 where f.SurName = @FamilySurName
									 group by SurName)
	from dbo.Family as f
	where f.SurName = @FamilySurName
end;