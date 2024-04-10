if object_id('dbo.SKU') is null
begin
	create table  dbo.SKU (
		ID int not null identity,	
		Code AS concat('s',ID) ,
		Name varchar(32) NOT NULL,
		constraint PK_SKU primary key clustered (ID)
	)
end
;

if object_id('dbo.Family') is null
begin
	create table dbo.Family (
		ID int identity, 
		SurName varchar(32) NOT NULL, 
		BudgetValue numeric(18,2)
		constraint PK_Family primary key clustered (ID)
	)
end
;

if object_id('dbo.Basket') is null
begin
	create table dbo.Basket (
		ID int identity, 
		ID_SKU int NOT NULL,
		ID_Family int NOT NULL,
		Quantity smallint NOT NULL, 
		Value numeric(18,2) NOT NULL,
		/* 
			Согласно https://ics-it.gram.ax/mdti/standards/WorkWithCode/20_NamingStandartObjects поля типа date используют маску Date{Название}, в тех задании PurchaseDate. 
			Думаю в реальной ситуации, я бы предпочел уточнить. 
		*/
		DatePurchase date, 
		DiscountValue numeric (18,2)
		constraint PK_Basket primary key clustered (ID)
	)
	alter table dbo.Basket add constraint FK_Basket_ID_SKU foreign key (ID_SKU) references dbo.SKU(ID)
	alter table dbo.Basket add constraint FK_Basket_ID_Family foreign key (ID_Family) references dbo.Family(ID) 
	alter table dbo.Basket add constraint CK_Basket_Quantity check(Basket.Quantity >= 0)
	alter table dbo.Basket add constraint CK_Basket_Value check(Basket.Value >= 0)
	alter table dbo.Basket add constraint DF_Basket_DatePurchase default getdate() for DatePurchase
end
;
