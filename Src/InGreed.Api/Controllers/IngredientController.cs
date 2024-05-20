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
    public IActionResult GetById(int id)
    {
        Ingredient? result = _ingredientService.GetById(id);
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

    [HttpPost("/api/Product/{productId}/add-ingredient")]
    public IActionResult AddToProduct(AdditionRequest request, int productId)
    {
        IngredientServiceAddResponse result = _ingredientService.AddToProduct(request.ingredient, productId);
        switch (result)
        {
            case IngredientServiceAddResponse.NonexistentProduct:
                return NotFound($"There is no product with an id {productId}.");
            case IngredientServiceAddResponse.Success:
                return Ok();
            default:
                return BadRequest("Unexpected error.");
        }
    }

    [HttpDelete("/api/Product/{productId}/remove-ingredient/{ingredientId}")]
    public IActionResult RemoveFromProduct(int ingredientId, int productId)
    {
        IngredientServiceRemoveResponse result = _ingredientService.RemoveFromProduct(ingredientId, productId);
        switch (result) 
        {
            case IngredientServiceRemoveResponse.Success:
                return Ok();
            case IngredientServiceRemoveResponse.IngredientNotFromProduct:
                return NotFound($"Product {productId} does not contain an Ingredient with an id {ingredientId}.");
            case IngredientServiceRemoveResponse.NonexistentProduct:
                return NotFound($"There is no product with an id {productId}.");
            default:
                return BadRequest("Unexpected error.");
        }
    }
}
