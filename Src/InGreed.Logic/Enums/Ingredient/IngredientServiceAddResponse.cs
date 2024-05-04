namespace InGreed.Logic.Enums.Ingredient;

[Flags]
public enum IngredientServiceAddResponse 
{ 
    Success = 0, 
    NonexistentProduct = 1, 
    Unknown = 2 
}
