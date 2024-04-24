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
        if (product is null) return BadRequest("Null entered as input");
        service.CreateProduct(product);

        // should return location of the created resource as first argument
        return Created(String.Empty, product);
    }

    [HttpGet]
    public ActionResult<List<Product>> GetAllProducts()
    {
        List<Product> products = service.GetAllProducts().ToList();
        if(products is null) { return NotFound("List of products not found"); }
        return Ok(products);
    }

    [HttpGet("{id}")]
    public ActionResult<Product> GetById(int id)
    {
        Product? product = service.GetProductById(id);
        if (product is null) { return NotFound("Product with given Id not found"); }
        return Ok(product);
    }
}
