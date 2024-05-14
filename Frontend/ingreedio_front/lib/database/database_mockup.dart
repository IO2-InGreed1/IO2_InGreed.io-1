import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';

class MockupUserDatabase extends UserDatabse
{
  MockupUserDatabase.filled(IngredientDatabase ingredientDatabase,MockupProductDatabase productDatabse):clients=List.empty(growable: true),preferences=List.empty(growable: true),moderators=List.empty(growable: true)
  {
    List<Ingredient> ingredients=MockupIngredientDatabase.filled().ingredients;
    List<Product> products=productDatabse.products;
    clients.add(
      Client.fromAllData(id: 0, isBlocked: false, mail: 
      "mail", password: "p1", username: "u1", favoriteProducts: [])
    );
    clients.add(
      Client.fromAllData(id: 1, isBlocked: false, mail: 
      "mail2", password: "p2", username: "u2"
      , favoriteProducts: [products[1]])
    );
    clients.add(
      Client.fromAllData(id: 2, isBlocked: true, mail: 
      "mail3", password: "p3", username: "u3", favoriteProducts: [products[2],products[3]])
    );
    preferences.add(
      Preference.fromAllData(allergens: [ingredients[0]], id: 0, isActive: false,
       name: "pref1", prefered: [ingredients[1]], client: clients[1])
    );
    preferences.add(
      Preference.fromAllData(allergens: [ingredients[0],ingredients[2]], id: 1, isActive: false,
       name: "pref2", prefered: [ingredients[1]], client: clients[0])
    );
    preferences.add(
      Preference.fromAllData(allergens: [ingredients[3],ingredients[4],ingredients[1]], id: 2, isActive: false,
       name: "pref3", prefered: [ingredients[0]], client: clients[2])
    );
    preferences.add(
      Preference.fromAllData(allergens: [ingredients[1],ingredients[2]], id: 3, isActive: false,
       name: "pref1", prefered: [ingredients[3]], client: clients[0])
    );
  }
  List<Client> clients;
  List<Preference> preferences;
  List<Moderator> moderators;
  @override
  Future<bool> addClient(Client client) async {
    clients.add(client);
    return true;
  }

  @override
  Future<List<Client>> getAllClients() async {
    return clients;
  }

  @override
  Future<bool> removeClient(Client client) async {
    return clients.remove(client);
  }
  
  @override
  Future<bool> addPreference(Preference preference) async {
    preferences.add(preference);
    return true;
  }
  
  @override
  Future<List<Preference>> getUserPreferences(Client client) async {
    return preferences.where((element) => element.client==client).toList();
  }
  
  @override
  Future<bool> removePreference(Preference preference) async {
    return preferences.remove(preference);
  }
  
  @override
  Future<bool> setFavouriteProduct(Client client, Product product, bool state) async {
    int index=clients.indexOf(client);
    if(index<0) return false;
    if(state)
    {
      if(!clients[index].favoriteProducts.contains(product)) clients[index].favoriteProducts.add(product);
    }
    else
    {
      if(clients[index].favoriteProducts.contains(product)) clients[index].favoriteProducts.remove(product);
    }
    return true;
  }
  
  @override
  Future<bool> editPreference(Preference oldPreference, Preference editedPreference) async {
    if(preferences.contains(oldPreference)) preferences.remove(oldPreference);
    if(!preferences.contains(editedPreference)) preferences.add(editedPreference);
    return true;
  }
}
class MockupProductDatabase extends ProductDatabse
{
  List<Product> products;
  List<Producer> producers;
  MockupProductDatabase.filled(MockupIngredientDatabase ingredientDatabase):producers=List.empty(growable: true),
  products=List.empty(growable: true)
  {
    List<Ingredient> ingredients=ingredientDatabase.ingredients;
    producers.add(
      Producer.fromAllData(companyName: 
      "C1", nip: "123", representativeName: "name1", representativeSurname: "surname1", telephoneNumber: "49")
    );
    producers.add(
      Producer.fromAllData(companyName: 
      "C2", nip: "321", representativeName: "name2", representativeSurname: "surname2", telephoneNumber: "49-1")
    );
    producers.add(
      Producer.fromAllData(companyName: 
      "C3", nip: "2137", representativeName: "name3", representativeSurname: "surname1", telephoneNumber: "49-2")
    );
    products.add(
      Product.fromAllData(description: "lorem ipsum1",category: Category.cosmetics, id: 1, ingredients: [ingredients[0],ingredients[1]], 
      name: "p1", producer: producers[0], promotionUntil: DateTime(0))
    );
    products.add(
      Product.fromAllData(description: "lorem ipsum12",category: Category.cosmetics, id: 2, ingredients: [ingredients[2],ingredients[1]], 
      name: "p2", producer: producers[1], promotionUntil: DateTime(0))
      );
    products.add(
      Product.fromAllData(description: "lorem ipsum2",category: Category.drink, id: 3, ingredients: [ingredients[3],ingredients[4]], 
      name: "p3", producer: producers[2], promotionUntil: DateTime(0))
    );
    products.add(
      Product.fromAllData(description: "lorem ipsum3",category: Category.food, id: 4, ingredients: [ingredients[3],ingredients[2]], 
      name: "p4", producer: producers[2], promotionUntil: DateTime(0))
    );
    products.add(
      Product.fromAllData(description: "lorem ipsum4",category: Category.food, id: 5, ingredients: [ingredients[2],ingredients[0]], 
      name: "p5", producer: producers[2], promotionUntil: DateTime(20000))
    );
    products.add(
      Product.fromAllData(description: "lorem ipsum5",category: Category.cosmetics, id: 6, ingredients: [ingredients[1],ingredients[4]], 
      name: "p6", producer: producers[0], promotionUntil: DateTime(0))
    );
  }
  
  @override
  Future<bool> addProducer(Producer producer) async {
    producers.add(producer);
    return true;
  }
  
  @override
  Future<bool> addProduct(Product product) async {
    products.add(product);
    return true;
  }
  
  @override
  Future<List<Producer>> getAllProducers() async {
    return producers;
  }
  
  @override
  Future<List<Product>> getAllProducts() async {
    return products;
  }
  
  @override
  Future<bool> removeProducer(Producer producer) async {
    return producers.remove(producer);
  }
  
  @override
  Future<bool> removeProduct(Product product) async {
    return products.remove(product);
  }

  @override
  Future<ListData<Product>> filterProducts(int from,int to,ProductFilter filter) async {
    var pom= products.where((element) 
    {
      for(int i=0;i<element.ingredients.length;i++)
      {
        if(filter.allergens.contains(element.ingredients[i])) return false;
      }
      return true;
    }
    ).where((element) {
      if(filter.preference.isEmpty) return true;
      for(int i=0;i<filter.preference.length;i++)
      {
        if(!element.ingredients.contains(filter.preference[i])) return false;
      }
      return true;
    }).where((element) {
      return element.name.contains(filter.nameFilter);
    }).where((element) {
      if(filter.producer==null) return true;
      return filter.producer==element.producer;
      }).toList();
  List<Product> odp=List.empty(growable: true);
  for(int i=from;i<to;i++)
  {
    if(pom.length<=i) break;
    odp.add(pom[i]);
  }
  return ListData(odp,pom.length);
  }
  
  @override
  Future<bool> editProduct(Product product, Product editedProduct) async {
    if(!(await removeProduct(product))) return false;
    if(!(await addProduct(editedProduct)))
    {
      addProduct(product);
      return false;
    }
    return true;
  }
}
class MockupIngredientDatabase extends IngredientDatabase
{
  List<Ingredient> ingredients;
  MockupIngredientDatabase.filled():ingredients=List.empty(growable: true)
  {
    ingredients.add(Ingredient.fromAllData(iconURL: "https://media.istockphoto.com/id/184276818/photo/red-apple.jpg?s=612x612&w=0&k=20&c=NvO-bLsG0DJ_7Ii8SSVoKLurzjmV0Qi4eGfn6nW3l5w=", id: 0, name: "ing_1"));
    ingredients.add(Ingredient.fromAllData(iconURL: "b", id: 1, name: "ing_2"));
    ingredients.add(Ingredient.fromAllData(iconURL: "c", id: 2, name: "ing_3"));
    ingredients.add(Ingredient.fromAllData(iconURL: "d", id: 3, name: "ing_4"));
    ingredients.add(Ingredient.fromAllData(iconURL: "e", id: 4, name: "ing_5"));
    
  }
  @override
  Future<List<Ingredient>> getAllIngredients()async {
    return ingredients;
  }

}
class MockupOpinionDatabase extends OpinionDatabase
{
  MockupOpinionDatabase.filled(MockupProductDatabase productDatabse,MockupUserDatabase userDatabse):opinions=List.empty(growable: true)
  {
    opinions.add(Opinion.fromAllData(author: userDatabse.clients[1], id: 0, product: productDatabse.products[0], score: 1, text: "opinia"));
  }
  List<Opinion> opinions;
  @override
  Future<bool> addOpinion(Opinion opinion) async {
    opinions.add(opinion);
    return true;
  }

  @override
  Future<List<Opinion>> getAllOpinions() async {
    return opinions;
  }

  @override
  Future<List<Opinion>> getClientOpinions(Client client) async {
    return opinions.where((element) => element.author==client).toList();
  }

  @override
  Future<List<Opinion>> getProductOpinions(Product product) async {
    return opinions.where((element) => element.product==product).toList();
  }

  @override
  Future<bool> removeOpinion(Opinion opinion) async {
    return opinions.remove(opinion);
  }
  
  @override
  Future<ListData<Opinion>> getReportedFilteredOpinions(int from,int to,Filter<Opinion> filter) async {
    var pom= opinions.where((element) => element.isReported==true).toList();
    List<Opinion> odp=List.empty(growable: true);
    for(int i=from;i<to&&i<pom.length;i++) 
    {
      odp.add(pom[i]);
    }
    return ListData(odp, pom.length);
  }
  
  @override
  Future<List<Opinion>> getReportedProductOpinions(Product product) async {
    
    return opinions.where((element) => (element.isReported==true)&&element.product==product).toList();
  }
  
  @override
  Future<ListData<Opinion>> getOpinionsFiltered(int from,int to,Product product, OpinionFilter filter) async {
    var pom=await getProductOpinions(product);
    List<Opinion> odp=List.empty(growable: true);
    for(int i=from;i<to;i++)
    {
      if(pom.length>i) 
      {
        odp.add(pom[i]);
      } 
      else 
      {
        break;
      }
    }
    return ListData(odp,pom.length);
  }
  
  @override
  Future<void> setOpinionReport(Opinion opinion,{bool reportState=true}) async {
    int index=opinions.indexOf(opinion);
    if(index>=0)
    {
      opinions[index].isReported=reportState;
      opinion.isReported=reportState;
    }
  }
  
}
class MockupLoginDatabase extends LoginDatabase
{
  static Client mockClient=Client.fromAllData(id: 0, isBlocked: false, mail: 'XD@foo.com', password: null, username: 'Daniel', favoriteProducts: [],);
  static Producer mockProucer=Producer.fromAllData(companyName: 'C1', nip: '123', representativeName: 'Paweł', representativeSurname: 'Dzik', telephoneNumber: '2137');
  static Moderator mockModerator=Moderator.fromAllData(moderatorNumber: 1,editedOpinionList: []);
  static Admin mockAdmin=Admin.fromAllData(controlPanel: ControlPanel());
  MockupLoginDatabase.filled()
  {
    creds.add(("client","client","client",UserRole.client));
    creds.add(("producer","producer","producer",UserRole.producer));
    creds.add(("admin","admin","admin",UserRole.admin));
    creds.add(("moderator","moderator","moderator",UserRole.moderator));
  }
  List<(String,String,String,UserRole)> creds=List.empty(growable: true);
  @override
  Future<LoginData?> login(String email, String password) async {
    for(var e in creds)
    {
      if(e.$1==email&&e.$2==password) return LoginData(e.$4,"tokenXD");
    }
    return null;
  }

  @override
  Future<LoginData> register(String username, String email, String password,UserRole userRole) async {
    creds.add((email,password,username,userRole));
    return LoginData(userRole,"tokenXD");
  }
  
  @override
  Future<Admin?> loadAdmin(String token)async {
    return mockAdmin;
  }
  
  @override
  Future<Client?> loadClient(String token) async {
    return mockClient;
  }
  
  @override
  Future<Moderator?> loadModerator(String token) async {
    return mockModerator;
  }
  
  @override
  Future<Producer?> loadProducer(String token) async {
    return mockProucer;
  }
  
}
class MockupDatabase extends Database
{
  late UserDatabse _userDatabse;
  late ProductDatabse _productDatabse;
  late OpinionDatabase _opinionDatabase;
  late IngredientDatabase _ingredientDatabase;
  late LoginDatabase _loginDatabase;
  MockupDatabase.filled()
  {
    _ingredientDatabase=MockupIngredientDatabase.filled();
    _productDatabse=MockupProductDatabase.filled(ingredientDatabase as MockupIngredientDatabase);
    _userDatabse=MockupUserDatabase.filled(ingredientDatabase, productDatabse as MockupProductDatabase);
    _opinionDatabase=MockupOpinionDatabase.filled(productDatabse as MockupProductDatabase, userDatabse as MockupUserDatabase);
    _loginDatabase=MockupLoginDatabase.filled();
  }
  @override
  void clearEditedOpinionList(int moderatorNumber) {
    //todo
  }

  @override
  IngredientDatabase get ingredientDatabase => _ingredientDatabase;
  set ingredientDatabase(IngredientDatabase value) => _ingredientDatabase=value;

  @override
  OpinionDatabase get opinionDatabase => _opinionDatabase;

  @override
  ProductDatabse get productDatabse => _productDatabse;
  @override
  LoginDatabase get loginDatabase => _loginDatabase;
  @override
  Future<List<Opinion>> searchInvalidOpinions() {
    return opinionDatabase.getAllOpinions();
  }

  @override
  UserDatabse get userDatabse =>_userDatabse;
  
}