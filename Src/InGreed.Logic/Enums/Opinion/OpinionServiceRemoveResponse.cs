namespace InGreed.Logic.Enums.Opinion;

[Flags]
public enum OpinionServiceRemoveResponse
{
    Success = 0,
    OpinionNotFromProduct = 1,
    NonexistentProduct = 2,
    Unknown = 4
}
