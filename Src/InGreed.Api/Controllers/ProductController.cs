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
        service.Create(product);
        return Ok(product);
    }

    [HttpPost("{id}/opinions")]
    public ActionResult<Product> AddOpinion(int id, [FromBody]Opinion opinion)
    {
        if (opinion is null) return BadRequest();
        Product product;
        try { product = service.GetProductById(id); }
        catch(ArgumentException e) { return NotFound(e.Message); }
        service.AddOpinion(product, opinion);
        return Ok(opinion);
    }

    [HttpDelete("{id}")]
    public ActionResult<Product> Delete(int id)
    {
        Product product;
        try { product = service.GetProductById(id); service.Delete(id); }
        catch(ArgumentException e) { return NotFound(e.Message); }
        return Ok(product);
    }

    [HttpGet]
    public ActionResult<List<Product>> Get()
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

    [HttpGet("{id}/opinions")]
    public ActionResult<List<Opinion>> GetOpinions(int id)
    {
        Product product;
        try { product = service.GetProductById(id); }
        catch (ArgumentException e) { return NotFound(e.Message); }

        List<Opinion> opinions = new List<Opinion>();
        try { opinions = service.GetOpinions(product).ToList(); }
        catch (ArgumentException e) { return NotFound(e.Message); }

        return Ok(opinions);
    }

    [HttpGet("{id}/ingredients")]
    public ActionResult<List<Ingredient>> GetIngredients(int id)
    {
        Product product;
        try { product = service.GetProductById(id); }
        catch (ArgumentException e) { return NotFound(e.Message); }

        List<Ingredient> ingredients = new List<Ingredient>();
        try { ingredients = service.GetIngredients(product).ToList(); }
        catch (ArgumentException e) { return NotFound(e.Message); }

        return Ok(ingredients);
    }

}
