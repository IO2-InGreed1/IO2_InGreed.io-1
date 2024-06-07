using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Interfaces;
using InGreed.Domain.Models;
using InGreed.Domain.Queries;
using InGreed.Domain.Helpers;

namespace InGreed.Logic.Services;

public class ProductService : IProductService
{
    IProductDA _productDA;
    public ProductService(IProductDA productDA)
    {
        _productDA = productDA;
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

    public PaginatedList<Product> GetAllProducts(ProductParameters parameters)
    {
        return _productDA.GetAll(parameters);
    }

    public Product GetProductById(int productId)
    {
        try { return _productDA.GetProductById(productId); }
        catch(Exception ex) { throw new ArgumentException(ex.Message); }
    }

    public bool Report(int productId)
    {
        throw new NotImplementedException();
    }

    public bool RemoveReports(int productId)
    {
        throw new NotImplementedException();
    }
}