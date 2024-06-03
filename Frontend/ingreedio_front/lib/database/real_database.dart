import 'dart:convert';
import 'dart:io';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
const String requestAdress="http://127.0.0.1:5000/api/";
Future<String> getResponse(String request,String token,{Map<String, dynamic>? jsonData}) async 
{
  HttpClient client=HttpClient();
  try {
    var uri = Uri.parse(
      requestAdress+request
    );
    
    var req = await client.getUrl(uri);
    req.headers.set('Authorization', 'Bearer $token');
    if(jsonData!=null)
    {
      req.headers.set('Content-Type', 'application/json');
      String jsonString = json.encode(jsonData);
      req.headers.set('Content-Length', jsonString.length.toString());
      req.write(jsonString);
    }
    var res=await req.close();
    String responseBody = await res.transform(utf8.decoder).join();
    client.close();
    return responseBody;
  } 
  catch(e)
  {
    client.close();
    throw(Exception("connection failed, message: \n $e"));
  }
  finally 
  {
    client.close();
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
    // TODO: implement addPreference
    throw UnimplementedError();
  }

  @override
  Future<bool> editPreference(Preference oldPreference, Preference editedPreference) async {
    // TODO: implement editPreference
    throw UnimplementedError();
  }

  @override
  Future<List<Preference>> getUserPreferences(Client client) async {
    // TODO: implement getUserPreferences
    throw UnimplementedError();
  }

  @override
  Future<bool> removeClient(Client client) async {
    // TODO: implement removeClient
    throw UnimplementedError();
  }

  @override
  Future<bool> removePreference(Preference preference)  async{
    // TODO: implement removePreference
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
  static List<Ingredient> parseIngredientList(String response)
  {
    Map<String,dynamic> map=json.decode(response);
    List<dynamic> pom=map["ingredients"];
    List<Ingredient> odp=List.empty(growable: true);
    for (var element in pom) {odp.add(IngredientMapper.fromMap(element as Map<String,dynamic>));}
    return odp;
  }
  @override
  Future<List<Ingredient>> getAllIngredients() async {
    String request="ingredient";
    String odp=await getResponse(request,cubit.state.userToken);
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
    // TODO: implement addProduct
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
    var response=await getResponse("Account/login", cubit.state.userToken,jsonData: 
    {
      "email": email,
      "password": password
    });
    try
    {
      Map<String,dynamic> map=json.decode(response);
      return map["authorizationToken"];
    }
    catch(e)
    {
      return null;
    }
  }

  @override
  Future<String?> register(String username, String email, String password, UserRole userRole) async {
    var response=await getResponse("Account/register", cubit.state.userToken,jsonData: 
    {
      "email": email,
      "username": username,
      "password": password
    });
    try
    {
      Map<String,dynamic> map=json.decode(response);
      return map["authorizationToken"];
    }
    catch(e)
    {
      return null;
    }
  }

}