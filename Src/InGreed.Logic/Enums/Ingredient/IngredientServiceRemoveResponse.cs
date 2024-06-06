namespace InGreed.Logic.Enums.Ingredient;

[Flags]
public enum IngredientServiceRemoveResponse 
{ 
    Success = 0, 
    IngredientNotFromProduct = 1, 
    NonexistentProduct = 2, 
    Unknown = 4
}
