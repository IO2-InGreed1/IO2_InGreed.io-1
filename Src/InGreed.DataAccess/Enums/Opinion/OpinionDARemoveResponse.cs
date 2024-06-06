namespace InGreed.DataAccess.Enums.Opinion;

[Flags]
public enum OpinionDARemoveResponse
{
    Success = 0,
    OpinionNotFromProduct = 1,
    NonexistentProduct = 2
}
