namespace InGreed.Logic.Enums.Opinion;

[Flags]
public enum OpinionServiceRemoveResponse
{
    Success = 0,
    IngredientNotFromProduct = 1,
    NonexistentProduct = 2,
    Unknown = 4
}
