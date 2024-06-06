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
        throw new NotImplementedException();
    }

    public FavouritesServiceDeleteResponse Delete(int productId, int userId)
    {
        throw new NotImplementedException();
    }
}
