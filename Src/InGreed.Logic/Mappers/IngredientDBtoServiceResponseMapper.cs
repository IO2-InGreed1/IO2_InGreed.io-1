using InGreed.DataAccess.Enums;
using InGreed.Logic.Enums;
using Riok.Mapperly.Abstractions;

namespace InGreed.Logic.Mappers;

[Mapper(EnumMappingStrategy = EnumMappingStrategy.ByName, EnumMappingIgnoreCase = true)]
public partial class IngredientDBtoServiceResponseMapper : IIngredientDBtoServiceResponseMapper
{
    public partial IngredientServiceAddResponse AddResponseMapper(IngredientDAAddResponse DAresponse);
    public partial IngredientServiceRemoveResponse RemoveResponseMapper(IngredientDARemoveResponse DAresponse);
}
