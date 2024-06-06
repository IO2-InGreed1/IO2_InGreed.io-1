namespace InGreed.Logic.Enums;

[Flags]
public enum FavouritesServiceDeleteResponse 
{ 
    Success = 0,
    InvalidProductId = 1,
    InvalidUserId = 2,
    NotFavourited = 4,
    Unknown = 8
}
