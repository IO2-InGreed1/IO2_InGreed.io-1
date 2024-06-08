using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Interfaces;
using InGreed.Domain.Models;
using InGreed.Domain.Queries;
using InGreed.Domain.Helpers;

namespace InGreed.Logic.Services;

public class ProductService : IProductService
{
    IProductDA _productDA;
    IUserDA _userDA;
    public ProductService(IProductDA productDA, IUserDA userDA)
    {
        _productDA = productDA;
        _userDA = userDA;

    }

    public int CreateProduct(Product product)
    {
        try { return _productDA.CreateProduct(product); }
        catch (Exception ex) { throw new ArgumentException(ex.Message); }
    }

    public void ModifyProduct(int productIdToModify, Product product)
    {
        _productDA.ModifyProduct(productIdToModify, product);
    }

    public PaginatedList<ProductWithOwner> GetAllProducts(ProductParameters parameters)
    {
        return _productDA.GetAll(parameters);
    }

    public PaginatedList<ProductWithOwner> GetReported(ProductParameters parameters)
    {
        return _productDA.GetReported(parameters);
    }

    public ProductWithOwner GetProductById(int productId)
    {
        return _productDA.GetProductById(productId);
    }

    public bool Report(int productId)
    {
        return _productDA.Report(productId);
    }

    public bool RemoveReports(int productId)
    {
        return _productDA.RemoveReports(productId);
    }
}