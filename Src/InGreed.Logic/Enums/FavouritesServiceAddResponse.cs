namespace InGreed.Logic.Enums;

[Flags]
public enum FavouritesServiceAddResponse 
{
    Success = 0,
    InvalidProductId = 1,
    InvalidUserId = 2,
    AlreadyInFavourites = 4,
    Unknown = 8
}
