namespace InGreed.DataAccess.Enums;

[Flags]
public enum IngredientDARemoveResponse
{
    Success = 0,
    IngredientNotFromProduct = 1,
    NonexistentProduct = 2
}
