namespace InGreed.DataAccess.Enums.Opinion;

[Flags]
public enum OpinionDARemoveResponse
{
    Success = 0,
    IngredientNotFromProduct = 1,
    NonexistentProduct = 2
}
