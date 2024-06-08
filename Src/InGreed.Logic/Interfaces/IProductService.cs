using InGreed.Domain.Helpers;
using InGreed.Domain.Models;
using InGreed.Domain.Queries;

namespace InGreed.Logic.Interfaces;

public interface IProductService
{
    PaginatedList<(Product,string)> GetAllProducts(ProductParameters parameters);
    (Product, string) GetProductById(int productId);
    int CreateProduct(Product product);
    void ModifyProduct(int productIdToModify, Product product);
    bool Report(int productId);
    bool RemoveReports(int productId);
}
