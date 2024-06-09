using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using InGreed.Api.Contracts.Product;
using Microsoft.AspNetCore.Authorization;
using InGreed.Domain.Queries;
using Newtonsoft.Json;
using InGreed.Domain.Helpers;
using System.Security.Claims;

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
    [Authorize(Roles = "Producent")]
    public IActionResult Create(CreateRequest request)
    {
        if (request.product is null) return BadRequest();
        var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (userId is null) return Unauthorized();
        request.product.ProducentId = int.Parse(userId);
        service.CreateProduct(request.product);
        return Ok(request.product);
    }

    [HttpPut]
    [Authorize(Roles = "Producent")]
    public IActionResult Modify(ModifyRequest request, int productToModifyId)
    {
        if (request.product is null) return BadRequest();
        var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (userId is null) return Unauthorized();
        request.product.ProducentId = int.Parse(userId);
        service.ModifyProduct(productToModifyId, request.product);
        return Ok(request.product);
    }

    [HttpGet]
    public IActionResult GetAllProducts([FromQuery]ProductParameters parameters)
    {
        PaginatedList<ProductWithOwner> result;
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
        ProductWithOwner product = service.GetProductById(id);
        if (product.Product is null) return NotFound();
        return Ok(new GetByIdResponse(product.Product, product.Owner));
    }

    [HttpDelete("{productId}/reports")]
    [Authorize(Roles = "Moderator,Administrator")]
    public IActionResult RemoveReports(int productId)
    {
        if (service.RemoveReports(productId)) return Ok();
        else return NotFound($"Cannot reset report count for product with the id {productId} as such product does not exist.");
    }

    [HttpPost("{productId}/report")]
    public IActionResult AddReport(int productId)
    {
        if (service.Report(productId)) return Ok();
        else return NotFound($"Cannot report product with the id {productId} as such product does not exist.");
    }

    [HttpGet("reported")]
    [Authorize(Roles = "Moderator,Administrator")]
    public IActionResult GetReported([FromQuery] ProductParameters parameters)
    {
        PaginatedList<ProductWithOwner> result;
        try { result = service.GetReported(parameters); }
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
}
