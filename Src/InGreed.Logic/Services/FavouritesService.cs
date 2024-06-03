using InGreed.Logic.Enums;
using InGreed.Logic.Interfaces;
using InGreed.DataAccess.Interfaces;

namespace InGreed.Logic.Services;

public class FavouritesService : IFavouritesService
{
    private IUserDA _userDA;
    private IProductDA _productDA;

    public FavouritesService(IUserDA userDA, IProductDA productDA)
    {
        _userDA = userDA;
        _productDA = productDA;
    }

    public FavouritesServiceAddResponse Add(int productId, int userId)
    {
        if (_productDA.GetProductById(productId) is null) return FavouritesServiceAddResponse.InvalidProductId;
        if (_userDA.GetUserById(productId) is null) return FavouritesServiceAddResponse.InvalidUserId;
        if (_userDA.AddToFavourites(productId, userId)) return FavouritesServiceAddResponse.Success;
        return FavouritesServiceAddResponse.AlreadyInFavourites;
    }

    public FavouritesServiceDeleteResponse Delete(int productId, int userId)
    {
        if (_productDA.GetProductById(productId) is null) return FavouritesServiceDeleteResponse.InvalidProductId;
        if (_userDA.GetUserById(productId) is null) return FavouritesServiceDeleteResponse.InvalidUserId;
        if (_userDA.AddToFavourites(productId, userId)) return FavouritesServiceDeleteResponse.Success;
        return FavouritesServiceDeleteResponse.NotFavourited;
    }
}
