using InGreed.Application.Interfaces;
using InGreed.Domain.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

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
        if (product == null) return BadRequest();
        service.Add(product);
        return Ok(product);
    }

    [HttpPost("{id}/opinions")]
    public ActionResult<Product> AddOpinion(int id, [FromBody]Opinion opinion)
    {
        throw new NotImplementedException();
    }

    [HttpDelete]
    public ActionResult<Product> Delete([FromBody] Product product)
    {
        throw new NotImplementedException();
    }

    [HttpGet]
    public ActionResult<List<Product>> Get()
    {
        throw new NotImplementedException();
    }

    [HttpGet("{id}")]
    public ActionResult<Product> GetById(int id)
    {
        throw new NotImplementedException();
    }

    [HttpGet("{id}/opinions")]
    public ActionResult<List<Opinion>> GetOpinions(int id)
    {
        throw new NotImplementedException();
    }

    [HttpGet("{id}/ingredients")]
    public ActionResult<List<Ingredient>> GetIngredients(int id)
    {
        throw new NotImplementedException();
    }

}
