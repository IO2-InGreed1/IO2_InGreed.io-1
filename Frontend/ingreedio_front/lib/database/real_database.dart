import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
const String requestAdress="http://127.0.0.1:5000/api/";
enum RequestType
{
  get,put,post,patch,delete
}
Future<Map<String,dynamic>> getResponse(String request,String token,RequestType type,{String? jsonData}) async 
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
    if(response.data is Map<String,dynamic>) 
    {
      response.data["responseHeaders"]=response.headers;
      return response.data;
    }
    return {
      "success":true,
      "value":response.data,
      "responseHeaders":response.headers
    };
  } 
  catch(e)
  {
    dio.close(force: true);
    return {"success":false,};
    //throw(Exception("connection failed, message: \n $e"));
  }
  finally 
  {
    dio.close();
  }
}
List<Ingredient> parseIngredientList(Map<String,dynamic> response,{String listName="ingredients"}){
  List<dynamic> pom=response[listName];
  List<Ingredient> odp=List.empty(growable: true);
  for (var element in pom) {odp.add(IngredientMapper.fromMap(element as Map<String,dynamic>));}
  return odp;
}
Opinion parseOpinion(Map<String,dynamic> response,Product product)
{
  Map<String, dynamic> map=response["opinion"];
  return Opinion.fromAllData(author: Client.empty()..username=response["owner"]..iconURL=response["iconURL"]..id=map["authorId"], 
  id: map["id"], 
  product: product, 
  score: (map["score"] as num).toDouble(), 
  text: map["content"],);
}
Product parseProduct(Map<String,dynamic> response)
{
  Map<String, dynamic> map=response["product"];
  return Product.fromAllData(category: Category.fromNumber((map["category"]==0 || map["category"]==null)?4:map["category"])!, 
  description: map["description"]==null?" ": map["description"], 
  id: map["id"]==null?0:map["id"], 
  ingredients: parseIngredientList(map), 
  name: map["name"], 
  iconURL: map["iconURL"],
  producer: Producer.fromAllData(companyName: response["owner"], nip: "", 
  representativeName: "", representativeSurname: "", telephoneNumber: "", id: map["producentId"], 
  isBlocked: false, mail: "", password: "", username: response["owner"]), 
  promotionUntil: map["promotedUntil"]==null?DateTime(1900):DateTime.tryParse(map["promotedUntil"])!);
}
List<String> codeIngredientList(List<Ingredient> ingredients){
  return ingredients.map((e)=>e.toJson()).toList();
  // List<Map<String,dynamic>> odp=[];
  // for(var i in ingredients)
  // {
  //   odp.add(
  //     {
  //       "id":i.id,
  //       "iconURL":i.iconURL,
  //       "name":i.name
  //     }
  //   );
  // }
  // return odp;
}
List<Product> parseProductList(Map<String,dynamic> response,{String listName="products"}){
  List<dynamic> pom=response[listName];
  List<Product> odp=List.empty(growable: true);
  for (var element in pom) {odp.add(parseProduct(element));}
  return odp;
}
class RealUserDatabase extends UserDatabse
{
  RealUserDatabase(this.cubit);
  @override
  SessionCubit cubit;
  @override
  Future<bool> addPreference(Preference preference) async {
    var response=await getResponse("Preference", cubit.state.userToken,RequestType.post,
    jsonData: _preferenceToString(preference),
    );
    preference.id=response["value"];
    return response["success"];
  }
  @override
  Future<bool> editPreference(Preference oldPreference, Preference editedPreference) async {
    var response=await getResponse("Preference?preferenceToModify=${oldPreference.id}", cubit.state.userToken,RequestType.put,
    jsonData: _preferenceToString(editedPreference)
    );
    return response["success"];
  }
  Preference _preferenceFromMap(Map<String,dynamic> json,Client client)
  {
    return Preference.fromAllData(
      category: Category.fromNumber(json["category"]), 
      allergens: parseIngredientList(json,listName: "forbidden"), 
      id: json["id"],
      name: json["name"], 
      prefered: parseIngredientList(json,listName: "preferred"), 
      client: client);
  }
  String _preferenceToString(Preference preference)
  {
    return {
    "\"preference\"": 
    {
      "\"id\"": preference.id,
      "\"ownerId\"": preference.client.id,
      "\"name\"": "\"${preference.name}\"",
      "\"forbidden\"": codeIngredientList(preference.allergens),
      "\"preferred\"": codeIngredientList(preference.prefered),
      "\"category\"": preference.category==null?0:preference.category!.backendNumber,
      "\"active\"": false,
    }
    }.toString();
  }
  @override
  Future<List<Preference>> getUserPreferences(Client client) async {
    var response=await getResponse("Preference", cubit.state.userToken,RequestType.get);
    return (response["preferences"] as List<dynamic>).map((e)=>_preferenceFromMap(e, client)).toList();
  }

  @override
  Future<bool> removePreference(Preference preference)  async{
    var response=await getResponse("Preference?id=${preference.id}", cubit.state.userToken,RequestType.delete);
    return response["success"];
  }

  @override
  Future<bool> setFavouriteProduct(Client client, Product product, bool state) async {
    if(state==true)
    {
      var response=await getResponse("User/favourites/add/${product.id}", cubit.state.userToken, RequestType.put);
      return response["success"];
    }
    else
    {
      var response=await getResponse("User/favourites/remove/${product.id}", cubit.state.userToken, RequestType.delete);
      return response["success"];
    }
  }
  
  @override
  Future<User?> loadUser(String token) async {
    var response=await getResponse("Account/currentUser", token,RequestType.get);
    int role=response["role"];
    switch(role)
    {
      case 1||0: //client
      return Client.fromAllData(
        id: response["id"],
        isBlocked: response["banned"], 
        iconURL: response["iconURL"],
        mail: response["email"], 
        password: response["password"], 
        username: response["username"], 
        favoriteProducts: parseProductList(response,listName: "favourites")
        );
      case 2: //producent
      return Producer.fromAllData(
        id: response["id"],
        isBlocked: response["banned"], 
        iconURL: response["iconURL"],
        mail: response["email"], 
        password: response["password"], 
        username: response["username"], 
        companyName: response["username"], //TODO: do zmianyy jeśli będzie company name
        nip: '', 
        representativeName: '', 
        representativeSurname: '', 
        telephoneNumber: '', 
        );
      case 4://moderator
      return Moderator.fromAllData(
        id: response["id"],
        isBlocked: response["banned"], 
        iconURL: response["iconURL"],
        mail: response["email"], 
        password: response["password"], 
        username: response["username"], 
        moderatorNumber: 0, 
        editedOpinionList: [], 
        );
      case 8://admin
      return Admin.fromAllData(
        id: response["id"],
        isBlocked: response["banned"], 
        iconURL: response["iconURL"],
        mail: response["email"], 
        password: response["password"], 
        username: response["username"], 
        controlPanel: ControlPanel(), 
        );
    }
    return null;
  }
  

}
class RealIngredientDatabase extends IngredientDatabase
{
  RealIngredientDatabase(this.cubit);
  @override
  SessionCubit cubit;
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
    jsonData: {
  "\"product\"": {
    "\"id\"": product.id,
    "\"name\"": "\"${product.name}\"",
    "\"promotedUntil\"": "\"${product.promotionUntil.toIso8601String()}\"",
    "\"ingredients\"": product.ingredients.map((e)=>e.toJson()).toList(),
    "\"category\"": product.category.backendNumber,
    "\"iconURL\"": "\"${product.iconURL}\"",
    "\"producentId\"": product.producer.id,
    "\"reportCount\"": 0,
    "\"description\"": "\"${product.description}\""
  }
}.toString());
    if(response["success"]==false) return false;
    product.id=response["id"];
    return true;
  }

  @override
  Future<bool> editProduct(Product product, Product editedProduct) async {
   var response=await getResponse("Product?productToModifyId=${product.id}", cubit.state.userToken,RequestType.put,
    jsonData: {
  "\"product\"": {
    "\"id\"": editedProduct.id,
    "\"name\"": "\"${editedProduct.name}\"",
    "\"promotedUntil\"": "\"${editedProduct.promotionUntil.toIso8601String()}\"",
    "\"ingredients\"": editedProduct.ingredients.map((e)=>e.toJson()).toList(),
    "\"category\"": editedProduct.category.backendNumber,
    "\"iconURL\"": "\"${editedProduct.iconURL}\"",
    "\"producentId\"": editedProduct.producer.id,
    "\"reportCount\"": 0,
    "\"description\"": "\"${editedProduct.description}\""
  }
}.toString());
    if(response["success"]==false) return false;
    //product.id=response["value"];
    return true;
  }

  @override
  Future<ListData<Product>> filterProducts(int from, int to, ProductFilter filter) async {
    int pageSize=to-from;
    int pageNumber=1+(from~/(to-from));
    String requestUrl="Product?";
    if(filter.nameFilter.isNotEmpty)
    {
      requestUrl+="Name=${filter.nameFilter.replaceAll(RegExp(" "), "%20")}&";
    }
    if(filter.category!=null)
    {
      requestUrl+="Category=${filter.category!.backendNumber}&";
    }
    for(Ingredient i in filter.preference)
    {
      requestUrl+="usedIngredientsId=${i.id}&";
    }
    for(Ingredient i in filter.allergens)
    {
      requestUrl+="bannedIngredientsId=${i.id}&";
    }
    requestUrl+="PageNumber=$pageNumber&";
    requestUrl+="PageSize=$pageSize";
    var response =await getResponse(requestUrl, cubit.state.userToken, RequestType.get);
    List<dynamic> pom=response["value"];
    List<Product> odp=[];
    for(var map in pom)
    {
      odp.add(parseProduct(map));
    }
    var headers=response["responseHeaders"] as Headers;
    Map<String,dynamic> paginationMap=jsonDecode(headers.map["x-pagination"]![0]);
    int maxItems=paginationMap["TotalPages"]*pageSize;
    bool hasNextPage=paginationMap["HasNextPage"];
    return ListData(odp, hasNextPage?maxItems:to);
  }

  @override
  Future<bool> removeProducer(Producer producer) async {
    // TODO: implement removeProducer
    throw UnimplementedError();
  }

  @override
  Future<bool> removeProduct(Product product) async{
    //TODO: sprawidzić czy na backendzie endpoint nazywa się tak samo
    var response =await getResponse("Product/${product.id}", cubit.state.userToken, RequestType.delete);
    return response["success"];
  }
  
  @override
  Future<bool> setProductReportState(Product product, {bool state = false}) async {
    if(state)
    {
      var response=await getResponse("Product/${product.id}/report", cubit.state.userToken, RequestType.post);
      return response["success"];
    }
    else 
    {
      var response=await getResponse("Product/${product.id}/reports", cubit.state.userToken, RequestType.delete);
      return response["success"];
    }
  }
  
  @override
  Future<ListData<Product>> filterReportedProducts(int from, int to, Filter<Product> filter) async {
    int pageSize=to-from;
    int pageNumber=1+(from~/(to-from));
    var response =await getResponse("Product/reported?PageNumber=$pageNumber&PageSize=$pageSize", cubit.state.userToken, RequestType.get);
    List<dynamic> pom=response["value"];
    List<Product> odp=[];
    for(var map in pom)
    {
      odp.add(parseProduct(map));
    }
    var headers=response["responseHeaders"] as Headers;
    Map<String,dynamic> paginationMap=jsonDecode(headers.map["x-pagination"]![0]);
    int maxItems=paginationMap["TotalPages"]*pageSize;
        bool hasNextPage=paginationMap["HasNextPage"];
    return ListData(odp, hasNextPage?maxItems:to);
  }
 

}
class RealOpinionDatabase extends OpinionDatabase
{
  RealOpinionDatabase(this.cubit);
  @override
  SessionCubit cubit;
  @override
  Future<bool> addOpinion(Opinion opinion) async {
    var response =await getResponse("Product/add-opinion", cubit.state.userToken, RequestType.post,
    jsonData: {
      "\"opinion\"": {
      "\"id\"": opinion.id,
      "\"productId\"": opinion.product.id,
      "\"authorId\"": opinion.author.id,
      "\"content\"":"\"${opinion.text}\"",
      "\"score\"": "\"${opinion.score}\"",
      "\"reportCount\"": 0
    }
    }.toString()
    );
    if(response["success"]==true)
    {
      opinion.id=response["value"];
      return true;
    }
    return false;
  }

  @override
  Future<ListData<Opinion>> getOpinionsFiltered(int from, int to, Product product, OpinionFilter filter) async {
    int pageSize=to-from;
    int pageNumber=1+(from~/(to-from));
    var response =await getResponse("Product/${product.id}/opinions?ReportCountGreaterThan=-1&PageNumber=$pageNumber&PageSize=$pageSize", cubit.state.userToken, RequestType.get);
    List<dynamic> pom=response["value"];
    List<Opinion> odp=[];
    for(var map in pom)
    {
      odp.add(parseOpinion(map, product));
    }
    var headers=response["responseHeaders"] as Headers;
    Map<String,dynamic> paginationMap=jsonDecode(headers.map["x-pagination"]![0]);
    int maxItems=paginationMap["TotalPages"]*pageSize;
        bool hasNextPage=paginationMap["HasNextPage"];
    return ListData(odp, hasNextPage?maxItems:to);
  }
  @override
  Future<ListData<Opinion>> getReportedFilteredOpinions(int from,int to,Filter<Opinion> filter) async {
    int pageSize=to-from;
    int pageNumber=1+(from~/(to-from));
    var response =await getResponse("Opinion/reported?ReportCountGreaterThan=0&PageNumber=$pageNumber&PageSize=$pageSize", cubit.state.userToken, RequestType.get);
    List<dynamic> pom=response["opinions"];
    List<Opinion> odp=[];
    for(var map in pom)
    {
      odp.add(parseOpinion(map,Product.empty()..id=map["opinion"]["productId"]));
    }
    var headers=response["responseHeaders"] as Headers;
    Map<String,dynamic> paginationMap=jsonDecode(headers.map["x-pagination"]![0]);
    int maxItems=paginationMap["TotalPages"]*pageSize;
        bool hasNextPage=paginationMap["HasNextPage"];
    return ListData(odp, hasNextPage?maxItems:to);
  }

  @override
  Future<bool> removeOpinion(Opinion opinion) async {
    var response =await getResponse("Product/${opinion.product.id}/remove-opinion/${opinion.id}", cubit.state.userToken, RequestType.delete);
    return response["success"];
  }
  
  @override
  Future<void> setOpinionReport(Opinion opinion,{bool reportState=true}) async {
    if(reportState)
    {
      getResponse("Opinion/${opinion.id}/report", cubit.state.userToken, RequestType.post);
    }
    else 
    {
      getResponse("Opinion/${opinion.id}/reports", cubit.state.userToken, RequestType.delete);
    }
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
      "\"email\"": "\"$email\"",
      "\"password\"": "\"$password\""
    }.toString());
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
      "\"email\"": "\"$email\"",
      "\"username\"": "\"$username\"",
      "\"password\"": "\"$password\""
    }.toString());
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
class RealDatabase extends Database
{
  RealDatabase(SessionCubit cubit):ingredientDatabase=RealIngredientDatabase(cubit),
  loginDatabase=RealLoginDatabase(cubit),
  opinionDatabase=RealOpinionDatabase(cubit),
  productDatabase=RealProductDatabase(cubit),
  userDatabase=RealUserDatabase(cubit);
  @override
  void clearEditedOpinionList(int moderatorNumber) {
    //todo
  }
  
  @override
  RealIngredientDatabase ingredientDatabase;
  
  @override
  RealLoginDatabase loginDatabase;
  
  @override
  RealOpinionDatabase opinionDatabase;
  
  @override
  RealProductDatabase productDatabase;
  
  @override
  RealUserDatabase userDatabase;
  
}