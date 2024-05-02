﻿using InGreed.Domain.Models;
using InGreed.Logic.Enums;

namespace InGreed.Logic.Interfaces;

public interface IIngredientService
{
    IEnumerable<Ingredient> GetAll();
    Ingredient? GetById(int ingredientId);
    IngredientServiceAddResponse AddToProduct(Ingredient ingredient, int productId);
    IngredientServiceAddResponse RemoveFromProuct(int ingredientId, int productId);
}
