using InGreed.Api.Contracts.Opinion;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using InGreed.Logic.Enums.Opinion;
using InGreed.Domain.Queries;
using InGreed.Domain.Helpers;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

namespace InGreed.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class OpinionController : ControllerBase
{
    IOpinionService _opinionService;
    IAccountService _accountService;
    IProductService _productService;

    public OpinionController(IOpinionService opinionService, IAccountService accountService, IProductService productService)
    {
        _opinionService = opinionService;
        _accountService = accountService;
        _productService = productService;
    }

    [HttpGet("{id}")]
    public IActionResult GetById(int id)
    {
        Opinion? result = _opinionService.GetById(id);
        if (result is null) return NotFound();
        User author = _accountService.GetUserById(result.authorId);
        GetByIdResponse response = new(result, author.Username, author.IconURL);
        return Ok(response);
    }

    [HttpGet("/api/Product/{productId}/opinions")]
    public IActionResult GetByProduct([FromQuery] OpinionParameters parameters, int productId)
    {
        if (_productService.GetProductById(productId) is null) return NotFound($"There is no product with the id {productId}.");
        PaginatedList<OpinionWithAuthor> result = _opinionService.GetByProduct(parameters, productId);
        if (result is null) return BadRequest();
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

    
    [HttpPost("/api/Product/add-opinion")]
    [Authorize]
    public IActionResult AddToProduct(AdditionRequest request)
    {
        var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (userId is null) return Unauthorized();
        request.opinion.authorId = int.Parse(userId);
        (OpinionServiceAddResponse response, int resId) result = _opinionService.AddToProduct(request.opinion, request.opinion.productId);
        switch (result.response)
        {
            case OpinionServiceAddResponse.NonexistentProduct:
                return NotFound($"There is no product with an id {request.opinion.productId}.");
            case OpinionServiceAddResponse.Success:
                return Ok(result.resId);
            default:
                return BadRequest("Unexpected error.");
        }
    }

    [HttpDelete("/api/Product/{productId}/remove-opinion/{opinionId}")]
    [Authorize]
    public IActionResult RemoveFromProduct(int opinionId, int productId)
    {
        var userRole = User.FindFirstValue(ClaimTypes.Role);
        if (userRole is null) return Unauthorized();
        else if (userRole != "Moderator" && userRole != "Administrator")
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (userId is null) return Unauthorized();
            Opinion temp = _opinionService.GetById(opinionId)!;
            if (temp is not null && temp.authorId != int.Parse(userId)) return Unauthorized($"Opinion with the id {opinionId} does was not authored by the currently logged in user " +
                $"and thus cannot be modified by them.");
        }
        OpinionServiceRemoveResponse result = _opinionService.RemoveFromProduct(opinionId, productId);
        switch (result)
        {
            case OpinionServiceRemoveResponse.Success:
                return Ok();
            case OpinionServiceRemoveResponse.OpinionNotFromProduct:
                return NotFound($"Product {productId} does not contain an Opinion with an id {opinionId}.");
            case OpinionServiceRemoveResponse.NonexistentProduct:
                return NotFound($"There is no product with an id {productId}.");
            default:
                return BadRequest("Unexpected error.");
        }
    }

    [HttpGet("reported")]
    [Authorize(Roles = "Moderator,Administrator")]
    public IActionResult GetAllReported([FromQuery]OpinionParameters parameters)
    {
        PaginatedList<OpinionWithAuthor> result = _opinionService.GetAllReported(parameters);
        if (result is null) return BadRequest();
        var metadata = new
        {
            result.PageSize,
            result.PageIndex,
            result.TotalPages,
            result.HasPreviousPage,
            result.HasNextPage
        };

        if(Response != null)
            Response.Headers.Add("X-Pagination", JsonConvert.SerializeObject(metadata));

        return Ok(new GetAllReportedResponse(result));
    }

    [HttpPost("{opinionId}/report")]
    [Authorize]
    public IActionResult AddReport(int opinionId)
    {
        OpinionServiceAddReportResponse result = _opinionService.AddReport(opinionId);
        switch (result)
        {
            case OpinionServiceAddReportResponse.Success:
                return Ok();
            case OpinionServiceAddReportResponse.NonexistentOpinion:
                return NotFound($"There is no opinion with an id {opinionId}.");
            default:
                return BadRequest("Unexpected error.");
        }
    }

    [HttpDelete("{opinionId}/reports")]
    [Authorize(Roles = "Moderator,Administrator")]
    public IActionResult RemoveReports(int opinionId)
    {
        OpinionServiceRemoveReportsResponse result = _opinionService.RemoveReports(opinionId);
        switch (result)
        {
            case OpinionServiceRemoveReportsResponse.Success:
                return Ok();
            case OpinionServiceRemoveReportsResponse.NonexistentOpinion:
                return NotFound($"There is no opinion with an id {opinionId}.");
            default:
                return BadRequest("Unexpected error.");
        }
    }
}