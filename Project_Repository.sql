create schema project;

# Store master table
create table if not exists project.storemaster(
	StoreID int not null,
    Region varchar(10),
    CreatedOn datetime default current_timestamp,
	ChangedOn datetime default current_timestamp,
   primary key(StoreID)
   );
   
   
# Customer table
create table if not exists project.customer(
	CustomerID int not null auto_increment,
    CustomerPhone varchar(16),
    CustomerCreditCard bigint,
    CreatedOn datetime default current_timestamp,
	ChangedOn datetime default current_timestamp,
   primary key(CustomerID)
   );
   
# Major Product Category table
create table if not exists project.majorproductcategory(
	MajorProductCategoryID int not null,
    MajorProductCategoryDesc varchar(45), 
    CreatedOn datetime default current_timestamp,
	ChangedOn datetime default current_timestamp,
   primary key(MajorProductCategoryID)
   );
  
# Product category table
create table if not exists project.productcategory(
	ProductCategoryID int not null,
    ProductCategoryDesc varchar(53), 
    MajorProductCategoryID int not null,
    CreatedOn datetime default current_timestamp,
	ChangedOn datetime default current_timestamp,
   primary key(ProductCategoryID),
	foreign key(MajorProductCategoryID) references project.majorproductcategory(MajorProductCategoryID)
   );
   
# product sub category table   
create table if not exists project.productsubcategory(
	ProductSubCategoryID int not null,
    ProductSubCategoryDesc varchar(52), 
    ProductCategoryID int not null,
    CreatedOn datetime default current_timestamp,
	ChangedOn datetime default current_timestamp,
   primary key(ProductSubCategoryID),
	foreign key(ProductCategoryID) references project.productcategory(ProductCategoryID)
   );
   

# product group table
create table if not exists project.productgroup(
	ProductGrpID bigint not null,
    ProductGrpDesc varchar(70), 
    ProductSubCategoryID int not null,
    CreatedOn datetime default current_timestamp,
	ChangedOn datetime default current_timestamp,
   primary key(ProductGrpID),
	foreign key(ProductSubCategoryID) references project.productsubcategory(ProductSubCategoryID)
   );
   
   
# product table
create table if not exists project.product(
	ProductID bigint not null,
    ProductDesc varchar(70), 
    ProductGrpID bigint not null,
    CreatedOn datetime default current_timestamp,
	ChangedOn datetime default current_timestamp,
   primary key(ProductID),
	foreign key(ProductGrpID) references project.productgroup(ProductGrpID)
   );
   
# create sales order header table
create table if not exists project.salesorderheader(
	SalesOrderID int not null,
    SaleDate date,
    StoreID int not null,
    CustomerID int not null,
   primary key(SalesOrderID),
	foreign key(StoreID) references project.storemaster(StoreID),
    foreign key(CustomerID) references project.customer(CustomerID)
   );
   
   
# create sales order item table
 create table if not exists project.salesorderitem(
	SalesOrderID int not null,
    ItemNo int not null,
    Qty int,
    TotalSale decimal(13,4),
    CreatedOn datetime default current_timestamp,
	ChangedOn datetime default current_timestamp,
    ProductID bigint not null,
   primary key(SalesOrderID, ItemNo),
    foreign key(ProductID) references project.product(ProductID)
   );  
   
INSERT INTO `project`.`product`
(`ProductID`,
`ProductDesc`,
`UnitPrice`,
`ProductGrpID`)
VALUES
(30045048211,
'TYLENOL PM EXTRA STRENGTH CAPLET 100CT',
12.41,
10001100116);
