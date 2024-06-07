using InGreed.Domain.Helpers;
using InGreed.Domain.Models;
using InGreed.Domain.Queries;

namespace InGreed.Logic.Interfaces;

public interface IProductService
{
    PaginatedList<Product> GetAllProducts(PaginationParameters paginationParameters);
    Product GetProductById(int productId);
    int CreateProduct(Product product);
    void ModifyProduct(int productIdToModify, Product product);
}
