using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

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
    public ActionResult<Product> Create([FromBody] Product product)
    {
        if (product is null) return BadRequest();
        service.CreateProduct(product);
        return Ok(product);
    }
    [HttpGet]
    public ActionResult<List<Product>> GetAllProducts()
    {
        List<Product> products = new List<Product>();
        try { products = service.GetAllProducts().ToList(); }
        catch (ArgumentException e) { return NotFound(e.Message); }
        return Ok(products);
    }

    [HttpGet("{id}")]
    public ActionResult<Product> GetById(int id)
    {
        Product product;
        try { product = service.GetProductById(id); }
        catch (ArgumentException e) { return NotFound(e.Message); }
        return Ok(product);
    }
}
