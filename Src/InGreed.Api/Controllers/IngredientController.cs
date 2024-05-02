using InGreed.Api.Contracts.Ingredient;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using InGreed.Logic.Enums;

namespace InGreed.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class IngredientController : ControllerBase
{
    IIngredientService _ingredientService;

    public IngredientController(IIngredientService ingredientService)
    {
        _ingredientService = ingredientService;
    }

    [HttpGet("{id}")]
    public IActionResult GetById(GetByIdRequest request)
    {
        Ingredient? result = _ingredientService.GetById(request.id);
        if (result is null) return BadRequest();
        GetByIdResponse response = new(result);
        return Ok(response);
    }

    [HttpGet]
    public IActionResult GetAll()
    {
        List<Ingredient> result = _ingredientService.GetAll().ToList();
        if (result is null) return BadRequest();
        GetAllResponse response = new(result);
        return Ok(response);
    }

    [HttpPost]
    public IActionResult AddToProduct(AdditionRequest request)
    {
        IngredientServiceAddResponse result = _ingredientService.AddToProduct(request.ingredient, request.productId);
        switch (result)
        {
            case IngredientServiceAddResponse.NonexistentProduct:
                return NotFound($"There is no product with an id {request.productId}.");
            case IngredientServiceAddResponse.Success:
                return Ok();
            default:
                return BadRequest("Unexpected error.");
        }
    }

    [HttpPut("{ingredientId}/remove-from-product")]
    public IActionResult RemoveFromProduct(RemovalRequest request)
    {
        IngredientServiceRemoveResponse result = _ingredientService.RemoveFromProuct(request.ingredientId, request.productId);
        switch (result) 
        {
            case IngredientServiceRemoveResponse.Success:
                return Ok();
            case IngredientServiceRemoveResponse.IngredientNotFromProduct:
                return NotFound($"Product {request.productId} does not contain an Ingredient with an id {request.ingredientId}.");
            case IngredientServiceRemoveResponse.NonexistentProduct:
                return NotFound($"There is no product with an id {request.productId}.");
            default:
                return BadRequest("Unexpected error.");
        }
    }
}
