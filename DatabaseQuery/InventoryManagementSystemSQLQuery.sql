CREATE DATABASE [Stock]
GO
USE [Stock]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 12/09/2009 16:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[ItemCode] [varchar](8) NOT NULL,
	[ItemDescription] [varchar](1000) NOT NULL,
	[ItemRate] [numeric](10, 2) NOT NULL,
 CONSTRAINT [PK__Items__3ECC0FEB03317E3D] PRIMARY KEY CLUSTERED 
(
	[ItemCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemLocation]    Script Date: 12/09/2009 16:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemLocation](
	[LocationName] [varchar](50) NOT NULL,
	[LocationAddress] [varchar](1000) NOT NULL,
 CONSTRAINT [PK__ItemLoca__F946BB857F60ED59] PRIMARY KEY CLUSTERED 
(
	[LocationName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PurchaseOrder]    Script Date: 12/09/2009 16:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PurchaseOrder](
	[PONumber] [varchar](6) NOT NULL,
	[Supplier] [varchar](50) NOT NULL,
	[OrderDate] [date] NOT NULL,
	[OrderStatus] [varchar](20) NOT NULL,
	[TotalAmount] [float] NOT NULL,
 CONSTRAINT [PK_PurchaseOrder] PRIMARY KEY CLUSTERED 
(
	[PONumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 12/09/2009 16:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SuppName] [varchar](100) NOT NULL,
	[ContactPerson] [varchar](100) NOT NULL,
	[SuppAddress] [varchar](1000) NOT NULL,
	[SuppPhone] [bigint] NOT NULL,
	[SuppEmail] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SuppName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockTransactions]    Script Date: 12/09/2009 16:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StockTransactions](
	[TransactionDate] [date] NOT NULL,
	[ItemCode] [varchar](8) NOT NULL,
	[ItemDescription] [varchar](1000) NOT NULL,
	[LocationName] [varchar](50) NOT NULL,
	[Quantity] [bigint] NOT NULL,
	[Transactions] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockInHand]    Script Date: 12/09/2009 16:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StockInHand](
	[ItemCode] [varchar](8) NULL,
	[ItemDescription] [varchar](1000) NULL,
	[LocationName] [varchar](50) NULL,
	[ItemRate] [decimal](6, 2) NULL,
	[Quantity] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PODetails]    Script Date: 12/09/2009 16:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PODetails](
	[PONumber] [varchar](6) NOT NULL,
	[Location] [varchar](50) NOT NULL,
	[ItemCode] [varchar](8) NOT NULL,
	[ItemDescription] [varchar](1000) NOT NULL,
	[Quantity] [bigint] NOT NULL,
	[Rate] [float] NOT NULL,
	[Amount] [float] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Purchase_Order_Details_Procedure]    Script Date: 12/09/2009 16:17:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Purchase_Order_Details_Procedure] AS

Select 
POD.PONumber,
PO.Supplier, 
PO.OrderDate, 
PO.OrderStatus,
PO.TotalAmount,

POD.ItemCode,
POD.ItemDescription,
POD.Quantity,
POD.Rate,
POD.Amount

From PurchaseOrder PO
Inner Join 
PODetails POD on 
PO.PONumber = POD.PONumber
GO
/****** Object:  ForeignKey [FK_PODetails_Items]    Script Date: 12/09/2009 16:17:05 ******/
ALTER TABLE [dbo].[PODetails]  WITH CHECK ADD  CONSTRAINT [FK_PODetails_Items] FOREIGN KEY([ItemCode])
REFERENCES [dbo].[Items] ([ItemCode])
GO
ALTER TABLE [dbo].[PODetails] CHECK CONSTRAINT [FK_PODetails_Items]
GO
/****** Object:  ForeignKey [FK_PurchaseOrder]    Script Date: 12/09/2009 16:17:05 ******/
ALTER TABLE [dbo].[PODetails]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrder] FOREIGN KEY([PONumber])
REFERENCES [dbo].[PurchaseOrder] ([PONumber])
GO
ALTER TABLE [dbo].[PODetails] CHECK CONSTRAINT [FK_PurchaseOrder]
GO
/****** Object:  ForeignKey [FK__StockInHa__ItemC__5629CD9C]    Script Date: 12/09/2009 16:17:05 ******/
ALTER TABLE [dbo].[StockInHand]  WITH CHECK ADD  CONSTRAINT [FK__StockInHa__ItemC__5629CD9C] FOREIGN KEY([ItemCode])
REFERENCES [dbo].[Items] ([ItemCode])
GO
ALTER TABLE [dbo].[StockInHand] CHECK CONSTRAINT [FK__StockInHa__ItemC__5629CD9C]
GO
/****** Object:  ForeignKey [FK__StockInHa__Locat__571DF1D5]    Script Date: 12/09/2009 16:17:05 ******/
ALTER TABLE [dbo].[StockInHand]  WITH CHECK ADD  CONSTRAINT [FK__StockInHa__Locat__571DF1D5] FOREIGN KEY([LocationName])
REFERENCES [dbo].[ItemLocation] ([LocationName])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[StockInHand] CHECK CONSTRAINT [FK__StockInHa__Locat__571DF1D5]
GO
