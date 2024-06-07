using InGreed.Domain.Helpers;
using InGreed.Domain.Models;
using InGreed.Domain.Queries;

namespace InGreed.DataAccess.Interfaces;

public interface IProductDA
{
    Product GetProductById(int productId);
    int CreateProduct(Product product);
    void ModifyProduct(int productIdToModify, Product product);
    PaginatedList<Product> GetAll(ProductParameters parameters);
    bool Report(int productId);
    bool RemoveReports(int productId);
}