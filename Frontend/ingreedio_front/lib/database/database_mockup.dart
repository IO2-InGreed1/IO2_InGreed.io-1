import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';

class MockupUserDatabase extends UserDatabse
{
  MockupUserDatabase.filled(IngredientDatabase ingredientDatabase,ProductDatabse productDatabse):clients=List.empty(growable: true),preferences=List.empty(growable: true),moderators=List.empty(growable: true)
  {
    List<Ingredient> ingredients=ingredientDatabase.getAllIngredients();
    List<Product> products=productDatabse.getAllProducts();
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
  bool addClient(Client client) {
    clients.add(client);
    return true;
  }

  @override
  List<Client> getAllClients() {
    return clients;
  }

  @override
  bool removeClient(Client client) {
    return clients.remove(client);
  }
  
  @override
  bool addPreference(Preference preference) {
    preferences.add(preference);
    return true;
  }
  
  @override
  List<Preference> getUserPreferences(Client client) {
    return preferences.where((element) => element.client==client).toList();
  }
  
  @override
  bool removePreference(Preference preference) {
    return preferences.remove(preference);
  }
}
class MockupProductDatabase extends ProductDatabse
{
  List<Product> products;
  List<Producer> producers;
  MockupProductDatabase.filled(IngredientDatabase ingredientDatabase):producers=List.empty(growable: true),
  products=List.empty(growable: true)
  {
    List<Ingredient> ingredients=ingredientDatabase.getAllIngredients();
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
  bool addProducer(Producer producer) {
    producers.add(producer);
    return true;
  }
  
  @override
  bool addProduct(Product product) {
    products.add(product);
    return true;
  }
  
  @override
  List<Producer> getAllProducers() {
    return producers;
  }
  
  @override
  List<Product> getAllProducts() {
    return products;
  }
  
  @override
  bool removeProducer(Producer producer) {
    return producers.remove(producer);
  }
  
  @override
  bool removeProduct(Product product) {
    return products.remove(product);
  }

  @override
  List<Product> filterProducts(int from,int to,ProductFilter filter) {
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
  return odp;
  }
  
  @override
  bool editProduct(Product product, Product editedProduct) {
    if(!removeProduct(product)) return false;
    if(!addProduct(editedProduct))
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
    ingredients.add(Ingredient.fromAllData(iconUrl: "https://media.istockphoto.com/id/184276818/photo/red-apple.jpg?s=612x612&w=0&k=20&c=NvO-bLsG0DJ_7Ii8SSVoKLurzjmV0Qi4eGfn6nW3l5w=", id: 0, name: "ing_1"));
    ingredients.add(Ingredient.fromAllData(iconUrl: "b", id: 1, name: "ing_2"));
    ingredients.add(Ingredient.fromAllData(iconUrl: "c", id: 2, name: "ing_3"));
    ingredients.add(Ingredient.fromAllData(iconUrl: "d", id: 3, name: "ing_4"));
    ingredients.add(Ingredient.fromAllData(iconUrl: "e", id: 4, name: "ing_5"));
    
  }
  @override
  List<Ingredient> getAllIngredients() {
    return ingredients;
  }

}
class MockupOpinionDatabase extends OpinionDatabase
{
  MockupOpinionDatabase.filled(ProductDatabse productDatabse,UserDatabse userDatabse):opinions=List.empty(growable: true)
  {
    opinions.add(Opinion.fromAllData(author: userDatabse.getAllClients()[1], id: 0, product: productDatabse.getAllProducts()[0], score: 1, text: "opinia"));
  }
  List<Opinion> opinions;
  @override
  bool addOpinion(Opinion opinion) {
    opinions.add(opinion);
    return true;
  }

  @override
  List<Opinion> getAllOpinions() {
    return opinions;
  }

  @override
  List<Opinion> getClientOpinions(Client client) {
    return opinions.where((element) => element.author==client).toList();
  }

  @override
  List<Opinion> getProductOpinions(Product product) {
    return opinions.where((element) => element.product==product).toList();
  }

  @override
  bool removeOpinion(Opinion opinion) {
    return opinions.remove(opinion);
  }
  
  @override
  List<Opinion> getReportedOpinions() {
    return opinions.where((element) => element.isReported==true).toList();
  }
  
  @override
  List<Opinion> getReportedProductOpinions(Product product) {
    
    return opinions.where((element) => (element.isReported==true)&&element.product==product).toList();
  }
  
  @override
  List<Opinion> getOpinionsFiltered(int from,int to,Product product, OpinionFilter filter) {
    var pom= getProductOpinions(product);
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
    return odp;
  }
  
}
class MockupDatabase extends Database
{
  late UserDatabse _userDatabse;
  late ProductDatabse _productDatabse;
  late OpinionDatabase _opinionDatabase;
  late IngredientDatabase _ingredientDatabase;
  MockupDatabase.filled()
  {
    _ingredientDatabase=MockupIngredientDatabase.filled();
    _productDatabse=MockupProductDatabase.filled(ingredientDatabase);
    _userDatabse=MockupUserDatabase.filled(ingredientDatabase, productDatabse);
    _opinionDatabase=MockupOpinionDatabase.filled(productDatabse, userDatabse);
  }
  @override
  void clearEditedOpinionList(int moderatorNumber) {
    //todo
  }

  @override
  IngredientDatabase get ingredientDatabase => _ingredientDatabase;

  @override
  OpinionDatabase get opinionDatabase => _opinionDatabase;

  @override
  ProductDatabse get productDatabse => _productDatabse;

  @override
  List<Opinion> searchInvalidOpinions() {
    return opinionDatabase.getAllOpinions();
  }

  @override
  UserDatabse get userDatabse =>_userDatabse;
  
}