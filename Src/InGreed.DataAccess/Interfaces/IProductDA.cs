﻿using InGreed.Domain.Helpers;
using InGreed.Domain.Models;
using InGreed.Domain.Queries;

namespace InGreed.DataAccess.Interfaces;

public interface IProductDA
{
    ProductWithOwner GetProductById(int productId);
    int CreateProduct(Product product);
    void ModifyProduct(int productIdToModify, Product product);
    PaginatedList<ProductWithOwner> GetAll(ProductParameters parameters);
    PaginatedList<ProductWithOwner> GetReported(ProductParameters parameters);
    bool Report(int productId);
    bool RemoveReports(int productId);
    bool Delete(int id);
}