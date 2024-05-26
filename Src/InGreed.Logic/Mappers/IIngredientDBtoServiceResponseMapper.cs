using InGreed.DataAccess.Enums;
using InGreed.Logic.Enums;

namespace InGreed.Logic.Mappers;

public interface IIngredientDBtoServiceResponseMapper
{
    IngredientServiceAddResponse AddResponseMapper(IngredientDAAddResponse DAresponse);
    IngredientServiceRemoveResponse RemoveResponseMapper(IngredientDARemoveResponse DAresponse);
}
