using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using InGreed.Api.Contracts.Product;

namespace InGreed.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class ProductController : ControllerBase
{
    private readonly IProductService service;

    public ProductController(IProductService service)
    {
        this.service = service;
    }

    [HttpPost]
    public IActionResult Create(CreateRequest request)
    {
        if (request.product is null) return BadRequest();
        service.CreateProduct(request.product);
        return Ok(request.product);
    }
    [HttpPut]
    public IActionResult Modify(ModifyRequest request, int productToModifyId)
    {
        if (request.product is null) return BadRequest();
        service.ModifyProduct(productToModifyId, request.product);
        return Ok(request.product);
    }
    [HttpGet]
    public IActionResult GetAllProducts()
    {
        List<Product> products = new List<Product>();
        try { products = service.GetAllProducts().ToList(); }
        catch (ArgumentException e) { return NotFound(e.Message); }
        return Ok(products);
    }

    [HttpGet("{id}")]
    public IActionResult GetById(int id)
    {
        Product product;
        try { product = service.GetProductById(id); }
        catch (ArgumentException e) { return NotFound(e.Message); }
        return Ok(product);
    }
}
