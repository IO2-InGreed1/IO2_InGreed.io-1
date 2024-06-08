using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using InGreed.Api.Contracts.Product;
using Microsoft.AspNetCore.Authorization;
using InGreed.Domain.Queries;
using Newtonsoft.Json;
using InGreed.Domain.Helpers;

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

    [Authorize(Roles = "Producent")]
    [HttpPost]
    public IActionResult Create(CreateRequest request)
    {
        if (request.product is null) return BadRequest();
        service.CreateProduct(request.product);
        return Ok(request.product);
    }

    [Authorize(Roles = "Producent")]
    [HttpPut]
    public IActionResult Modify(ModifyRequest request, int productToModifyId)
    {
        if (request.product is null) return BadRequest();
        service.ModifyProduct(productToModifyId, request.product);
        return Ok(request.product);
    }

    [HttpGet]
    public IActionResult GetAllProducts([FromQuery]ProductParameters parameters)
    {
        PaginatedList<(Product, string)> result;
        try { result = service.GetAllProducts(parameters); }
        catch (ArgumentException e) { return NotFound(e.Message); }

        var metadata = new
        {
            result.PageSize,
            result.PageIndex,
            result.TotalPages,
            result.HasPreviousPage,
            result.HasNextPage
        };

        if (Response != null)
            Response.Headers.Add("X-Pagination", JsonConvert.SerializeObject(metadata));

        return Ok(result);
    }

    [HttpGet("{id}")]
    public IActionResult GetById(int id)
    {
        (Product, string) product = service.GetProductById(id);
        if (product.Item1 is null) return NotFound();
        return Ok(new GetByIdResponse(product.Item1, product.Item2));
    }

    [Authorize(Roles = "Moderator,Administrator")]
    [HttpDelete("{productId}/reports")]
    public IActionResult RemoveReports(int productId)
    {
        if (service.RemoveReports(productId)) return Ok();
        else return NotFound($"Cannot reset report count for product with the id {productId} as such product does not exist.");
    }

    [Authorize]
    [HttpPost("{productId}/report")]
    public IActionResult AddReport(int productId)
    {
        if (service.Report(productId)) return Ok();
        else return NotFound($"Cannot report product with the id {productId} as such product does not exist.");
    }
}
