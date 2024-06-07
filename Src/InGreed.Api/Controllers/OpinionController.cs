using InGreed.Api.Contracts.Opinion;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using InGreed.Logic.Enums.Opinion;
using InGreed.Domain.Queries;
using InGreed.Domain.Helpers;
using Newtonsoft.Json;


namespace InGreed.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class OpinionController : ControllerBase
{
    IOpinionService _opinionService;

    public OpinionController(IOpinionService opinionService)
    {
        _opinionService = opinionService;
    }

    [HttpGet("{id}")]
    public IActionResult GetById(int id)
    {
        Opinion? result = _opinionService.GetById(id);
        if (result is null) return NotFound();
        GetByIdResponse response = new(result);
        return Ok(response);
    }

    [HttpPost("/api/Product/add-opinion")]
    public IActionResult AddToProduct(AdditionRequest request)
    {
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
    public IActionResult RemoveFromProduct(int opinionId, int productId)
    {
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
    public IActionResult GetAllReported([FromQuery]PaginationParameters paginationParameters)
    {
        PaginatedList<Opinion> result = _opinionService.GetAllReported(paginationParameters);
        if (result is null) return BadRequest();
        GetAllReportedResponse response = new(result);

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

        return Ok(response);
    }

    [HttpPost("{opinionId}/report")]
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