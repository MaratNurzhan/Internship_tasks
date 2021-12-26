create table [Bicycle]
(
   [Id] int IDENTITY(1,1) not null,
   [Brand] varchar(50)  not null,
   [RentPrice] int not null,
   primary key(Id)
)
create table [Client]
(
   [Id] int IDENTITY(1,1) not null,
   [Name] varchar(10) not null,
   [Passport] varchar(50) not null,
   [Country] varchar(50) not null,
   primary key(Id)
)

create table [Staff]
(
   [Id] int IDENTITY(1,1) not null,
   [Name] varchar(10) not null,
   [Passport] varchar(50) not null,
   [Date] date not null,
   primary key(Id)
)

create table [Detail]
(
   [Id] int IDENTITY(1,1) not null,
   [Brand] varchar(50)  not null,
   [Type] varchar(50) not null,
   [Name] varchar(50) not null,
   [Price] int not null,
   primary key(Id)

)

create table [DetailForBicycle]
(
   [BicycleId] int not null,
   [DetailId] int not null,
   FOREIGN KEY ([BicycleId]) REFERENCES [Bicycle] ([Id]),
   FOREIGN KEY ([DetailId]) REFERENCES [Detail] ([Id])
)

create table [ServiceBook]
(
   [BicycleId] int not null,
   [DetailId] int not null,
   [Date] date not null,
   [Price] int not null,
   [StaffId] int not null,
   FOREIGN KEY ([BicycleId]) REFERENCES [Bicycle] ([Id]),
   FOREIGN KEY ([StaffId]) REFERENCES [Staff] ([Id]),
   FOREIGN KEY ([DetailId]) REFERENCES [Detail] ([Id])
)

create table [RentBook]
(
   [Id] int IDENTITY(1,1) not null,
   [Date] date not null,
   [Time] int not null,
   [Paid] bit not null,
   [BicycleId] int not null,
   [ClientId] int not null,
   [StaffId] int not null,
   FOREIGN KEY ([BicycleId]) REFERENCES [Bicycle] ([Id]),
   FOREIGN KEY ([StaffId]) REFERENCES [Staff] ([Id]),
   FOREIGN KEY ([ClientId]) REFERENCES [Client] ([Id])
)

--заадние №1
--1.Написать update запросы для предотвращения возможных ограничений и оптимизации изначальных таблиц.
-- В комментариях укажите почему такие изменения нужны

-- По умолчанию при создании таблиц задается restrict constraint, который не позволяет обновлять данные ссылаемых таблиц.
-- Задал cascade при update и delete, так что запрос удаления и изменения в таблице с primary key не вызовет ошибки.

-- Ввожу данные в таблицы Bicycle, Detail, DetailForBicycle ля проверки
INSERT INTO Bicycle(Brand, RentPrice) VALUES ('Kama', '70');
INSERT INTO Detail(Brand, Type, Name, Price) VALUES ('Kama', 'ABSW', '10N', 20000);
INSERT INTO DetailForBicycle(BicycleId, DetailId) VALUES (1,1);

--удаляю строку где id велосипеда равнятеся 1, но выховид ошибку так как по умолчанию стоит restrict constraint
DELETE FROM Bicycle WHERE Id = 1;

--изменение с restrict на cascade
ALTER TABLE [DetailForBicycle] ADD CONSTRAINT [FK_BicycleID] FOREIGN KEY ([BicycleId])
    REFERENCES [Bicycle] ([Id])
    ON DELETE CASCADE
    ON UPDATE CASCADE;
--на этот раз успешное удаление строки с велосипедом, у которого id 1
DELETE FROM Bicycle WHERE Id = 1;

--проверка
SELECT * from Bicycle

--№2 задание
--Brand, Name, Type это, по моему мнеиию, меры. А RentPrice, Price это измерения потому что это числа.

--№3-4 задание
--В интернете мало инфомации про MDX и OlAP куб, поэтому не смог выполнить эти задания.

