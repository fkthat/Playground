select 
  o.OrderID [id],
  o.OrderDate [date],
  c.CustomerId [customer.id],
  c.CompanyName [customer.name],
  c.Address [customer.address.line],
  c.City [customer.address.city],
  c.Region [customer.address.region],
  c.Country [customer.address.country],
  c.PostalCode [customer.address.postalCode],
  c.Phone [customer.phone],
  c.Fax [customer.fax],
  c.ContactName [customer.contact.name],
  c.ContactTitle [customer.contact.title],
  (select 
    p.ProductID [product.id],
    p.ProductName [product.name],
    cat.CategoryID [product.category.id],
    cat.CategoryName [product.category.name],
    od.UnitPrice [unitPrice],
    od.Quantity [quantity]
    from dbo.[Order Details] od
      join dbo.Products p
        on od.ProductID = p.ProductID
      join dbo.Categories cat
        on p.CategoryID = cat.CategoryID
    where od.OrderID = o.OrderID
    for json path
  ) [items]
  from dbo.Orders o
    join dbo.Customers c
      on o.CustomerID = c.CustomerID
  for json path
