import 'package:ingreedio_front/products.dart';
import 'package:ingreedio_front/users.dart';
abstract class Database
{
  void addClient(Client client);
  void removeClient(Client client);
  void removeOpinion(Opinion opinion);
  List<Client> getAllClients();
  List<Producer> getAllProducers();
  List<Ingredient> getAllIngredients();
  List<Opinion> getAllOpinions();
  List<Product> getAllProducts();
}
class MockupDatabase extends Database
{
  MockupDatabase():opinions=[],clients=[],producers=[],products=[],ingredients=[];
  List<Client> clients;
  List<Product> products;
  List<Producer> producers;
  List<Opinion> opinions;
  List<Ingredient> ingredients;
  MockupDatabase.filled():opinions=List.empty(growable: true),clients=List.empty(growable: true),
  producers=List.empty(growable: true),products=List.empty(growable: true),
  ingredients=List.empty(growable: true)
  {
    ingredients.add(Ingredient.fromAllData(iconUrl: "https://media.istockphoto.com/id/184276818/photo/red-apple.jpg?s=612x612&w=0&k=20&c=NvO-bLsG0DJ_7Ii8SSVoKLurzjmV0Qi4eGfn6nW3l5w=", id: 0, name: "ing_1"));
    ingredients.add(Ingredient.fromAllData(iconUrl: "b", id: 1, name: "ing_2"));
    ingredients.add(Ingredient.fromAllData(iconUrl: "c", id: 2, name: "ing_3"));
    ingredients.add(Ingredient.fromAllData(iconUrl: "d", id: 3, name: "ing_4"));
    ingredients.add(Ingredient.fromAllData(iconUrl: "e", id: 4, name: "ing_5"));
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
      Product.fromAllData(category: Category.cosmetics, id: 1, ingredients: [ingredients[0],ingredients[1]], 
      name: "p1", producer: producers[0], promotionUntil: DateTime(0))
    );
    products.add(
      Product.fromAllData(category: Category.cosmetics, id: 2, ingredients: [ingredients[2],ingredients[1]], 
      name: "p2", producer: producers[1], promotionUntil: DateTime(0))
      );
    products.add(
      Product.fromAllData(category: Category.drink, id: 3, ingredients: [ingredients[3],ingredients[4]], 
      name: "p3", producer: producers[2], promotionUntil: DateTime(0))
    );
    products.add(
      Product.fromAllData(category: Category.food, id: 4, ingredients: [ingredients[3],ingredients[2]], 
      name: "p4", producer: producers[2], promotionUntil: DateTime(0))
    );
    products.add(
      Product.fromAllData(category: Category.food, id: 5, ingredients: [ingredients[2],ingredients[0]], 
      name: "p5", producer: producers[2], promotionUntil: DateTime(20000))
    );
    products.add(
      Product.fromAllData(category: Category.cosmetics, id: 6, ingredients: [ingredients[1],ingredients[4]], 
      name: "p6", producer: producers[0], promotionUntil: DateTime(0))
    );
    clients.add(
      Client.fromAllData(id: 0, isBlocked: false, mail: 
      "mail", password: "p1", username: "u1", preferences: [
        Preference.fromAllData(allergens: [ingredients[0]], id: 0, isActive: false, name: "pref1", prefered: [ingredients[1]])
      ], favoriteProducts: [])
    );
    clients.add(
      Client.fromAllData(id: 1, isBlocked: false, mail: 
      "mail2", password: "p2", username: "u2", preferences: [
        Preference.fromAllData(allergens: [ingredients[1],ingredients[2]], id: 1, isActive: false, name: "pref2", prefered: [ingredients[3],ingredients[0]]),
        Preference.fromAllData(allergens: [ingredients[0]], id: 2, isActive: false, name: "pref3", prefered: [ingredients[3]])
      ], favoriteProducts: [products[1]])
    );
    clients.add(
      Client.fromAllData(id: 2, isBlocked: true, mail: 
      "mail3", password: "p3", username: "u3", preferences:[], favoriteProducts: [products[2],products[3]])
    );
    opinions.add(
      Opinion.fromAllData(author: clients[0], id: 0, product: products[0], score: 0, text: "XD")
    );
    opinions.add(
      Opinion.fromAllData(author: clients[0], id: 1, product: products[0], score: 2, text: "XD2")
    );
    opinions.add(
      Opinion.fromAllData(author: clients[1], id: 2, product: products[0], score: 3, text: "XD3")
    );
    opinions.add(
      Opinion.fromAllData(author: clients[2], id: 3, product: products[1], score: 0, text: "XD")
    );
    opinions.add(
      Opinion.fromAllData(author: clients[0], id: 4, product: products[1], score: 2, text: "XD2")
    );
    opinions.add(
      Opinion.fromAllData(author: clients[1], id: 5, product: products[1], score: 3, text: "XD3")
    );
  }
  
  @override
  void addClient(Client client) {
    clients.add(client);
  }
  @override
  void removeClient(Client client) {
    clients.remove(client);
  }
  
  @override
  void removeOpinion(Opinion opinion) {
    opinions.remove(opinion);
  }
  
  @override
  List<Client> getAllClients() {
    return clients;
  }
  
  @override
  List<Ingredient> getAllIngredients() {
    return ingredients;
  }
  
  @override
  List<Opinion> getAllOpinions() {
    return opinions;
  }
  
  @override
  List<Producer> getAllProducers() {
    return producers;
  }
  
  @override
  List<Product> getAllProducts() {
    return products;
  }

}