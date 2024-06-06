import 'package:dio/dio.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
const String requestAdress="http://127.0.0.1:5000/api/";
enum RequestType
{
  get,put,post,patch,delete
}
Future<Map<String,dynamic>> getResponse(String request,String token,RequestType type,{Map<String, dynamic>? jsonData}) async 
{
  final dio = Dio();
  try {
    Response response;
    Map<String,dynamic> headers=
          {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          };
    var options=Options(headers: headers);
    switch(type)
    {
      case RequestType.get:
        response=await dio.get(requestAdress+request,data: jsonData,options: options);
        break;
      case RequestType.put:
        response=await dio.put(requestAdress+request,data: jsonData,options: options);
        break;
      case RequestType.post:
        response=await dio.post(requestAdress+request,data: jsonData,options: options);
        break;
      case RequestType.patch:
        response=await dio.patch(requestAdress+request,data: jsonData,options: options);
        break;
      case RequestType.delete:
        response=await dio.delete(requestAdress+request,data: jsonData,options: options);
        break;
    }
    return response.data;
  } 
  catch(e)
  {
    dio.close(force: true);
    //return {};
    throw(Exception("connection failed, message: \n $e"));
  }
  finally 
  {
    dio.close();
  }
}
class RealUserDatabase extends UserDatabse
{
  RealUserDatabase(this.cubit);
  @override
  SessionCubit cubit;
  @override
  Future<bool> addClient(Client client) async {
    // TODO: implement addClient
    throw UnimplementedError();
  }

  @override
  Future<bool> addPreference(Preference preference) async {
    var response=await getResponse("Preference", cubit.state.userToken,RequestType.post);
    throw UnimplementedError();
  }

  @override
  Future<bool> editPreference(Preference oldPreference, Preference editedPreference) async {
    var response=await getResponse("Preference", cubit.state.userToken,RequestType.put,
    jsonData: null
    );
    throw UnimplementedError();
  }

  @override
  Future<List<Preference>> getUserPreferences(Client client) async {
    var response=await getResponse("Preference", cubit.state.userToken,RequestType.get);
    throw UnimplementedError();
  }

  @override
  Future<bool> removeClient(Client client) async {
    // TODO: implement removeClient
    throw UnimplementedError();
  }

  @override
  Future<bool> removePreference(Preference preference)  async{
    var response=await getResponse("Preference?id=${preference.id}", cubit.state.userToken,RequestType.delete);
    throw UnimplementedError();
  }

  @override
  Future<bool> setFavouriteProduct(Client client, Product product, bool state) async {
    // TODO: implement setFavoutiteProduct
    throw UnimplementedError();
  }
  
  @override
  Future<User?> loadUser(String token) async {
    // TODO: implement loadUser
    throw UnimplementedError();
  }
  

}
class RealIngredientDatabase extends IngredientDatabase
{
  RealIngredientDatabase(this.cubit);
  @override
  SessionCubit cubit;
  static List<Ingredient> parseIngredientList(Map<String,dynamic> response)
  {
    List<dynamic> pom=response["ingredients"];
    List<Ingredient> odp=List.empty(growable: true);
    for (var element in pom) {odp.add(IngredientMapper.fromMap(element as Map<String,dynamic>));}
    return odp;
  }
  @override
  Future<List<Ingredient>> getAllIngredients() async {
    String request="ingredient";
    var odp=await getResponse(request,cubit.state.userToken,RequestType.get);
    return parseIngredientList(odp);
  }

}
class RealProductDatabase extends ProductDatabse
{
  RealProductDatabase(this.cubit);
  @override
  SessionCubit cubit;
  @override
  Future<bool> addProducer(Producer producer) async {
    // TODO: implement addProducer
    throw UnimplementedError();
  }

  @override
  Future<bool> addProduct(Product product) async {
    var response=await getResponse("Product", cubit.state.userToken,RequestType.post,
    jsonData: 
    {
    "id": product.id,
    "name": product.name,
    "promotedUntil": product.promotionUntil.toString(),
    "ingredients": product.ingredients.map((e)=>e.toJson()).toList(),
    "category": product.category.backendNumber,
    "iconURL": product.iconURL
    });
    throw UnimplementedError();
  }

  @override
  Future<bool> editProduct(Product product, Product editedProduct) async {
    // TODO: implement editProduct
    throw UnimplementedError();
  }

  @override
  Future<ListData<Product>> filterProducts(int from, int to, ProductFilter filter) async {
    // TODO: implement filterProducts
    throw UnimplementedError();
  }

  @override
  Future<bool> removeProducer(Producer producer) async {
    // TODO: implement removeProducer
    throw UnimplementedError();
  }

  @override
  Future<bool> removeProduct(Product product) async{
    // TODO: implement removeProduct
    throw UnimplementedError();
  }
  
  @override
  Future<bool> setProductReportState(Product product, {bool state = false}) async {
    // TODO: implement setProductReportState
    throw UnimplementedError();
  }
  
  @override
  Future<ListData<Product>> filterReportedProducts(int from, int to, Filter<Product> filter) async {
    // TODO: implement filterReportedProducts
    throw UnimplementedError();
  }
 

}
class RealOpinionDatabase extends OpinionDatabase
{
  RealOpinionDatabase(this.cubit);
  @override
  SessionCubit cubit;
  @override
  Future<bool> addOpinion(Opinion opinion) async {
    // TODO: implement addOpinion
    throw UnimplementedError();
  }

  @override
  Future<List<Opinion>> getClientOpinions(Client client) async {
    // TODO: implement getClientOpinions
    throw UnimplementedError();
  }

  @override
  Future<ListData<Opinion>> getOpinionsFiltered(int from, int to, Product product, OpinionFilter filter) async {
    // TODO: implement getOpinionsFiltered
    throw UnimplementedError();
  }

  @override
  Future<List<Opinion>> getProductOpinions(Product product) async {
    // TODO: implement getProductOpinions
    throw UnimplementedError();
  }

  @override
  Future<ListData<Opinion>> getReportedFilteredOpinions(int from,int to,Filter<Opinion> filter) async {
    // TODO: implement getReportedOpinions
    throw UnimplementedError();
  }

  @override
  Future<bool> removeOpinion(Opinion opinion) async {
    // TODO: implement removeOpinion
    throw UnimplementedError();
  }
  
  @override
  Future<void> setOpinionReport(Opinion opinion,{bool reportState=true}) async {
    // TODO: implement reportOpinion
    throw UnimplementedError();
  }
  
  
}
class RealLoginDatabase extends LoginDatabase
{
  
  RealLoginDatabase(this.cubit);
  @override
  SessionCubit cubit;

  @override
  Future<String?> login(String email, String password) async {
    var response=await getResponse("Account/login", cubit.state.userToken,RequestType.post,jsonData: 
    {
      "email": email,
      "password": password
    });
    try
    {
      return response["authorizationToken"];
    }
    catch(e)
    {
      return null;
    }
  }

  @override
  Future<String?> register(String username, String email, String password, UserRole userRole) async {
    var response=await getResponse("Account/register", cubit.state.userToken,RequestType.post,jsonData: 
    {
      "email": email,
      "username": username,
      "password": password
    });
    try
    {
      return response["authorizationToken"];
    }
    catch(e)
    {
      return null;
    }
  }

}