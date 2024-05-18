import 'dart:math';

import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';

class MockupUserDatabase extends UserDatabse
{
  static Client mockClient=Client.fromAllData(id: 10, isBlocked: false, mail: 'XD@foo.com', password: null, username: 'Daniel', favoriteProducts: [],);
  static Producer mockProucer=Producer.fromAllData(companyName: 'C1', nip: '123', representativeName: 'Paweł', representativeSurname: 'Dzik', telephoneNumber: '2137');
  static Moderator mockModerator=Moderator.fromAllData(moderatorNumber: 1,editedOpinionList: []);
  static Admin mockAdmin=Admin.fromAllData(controlPanel: ControlPanel());
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
  MockupUserDatabase.filled(IngredientDatabase ingredientDatabase,MockupProductDatabase productDatabse):clients=List.empty(growable: true),preferences=List.empty(growable: true),moderators=List.empty(growable: true)
  {
    List<Ingredient> ingredients=MockupIngredientDatabase.filled().ingredients;
    List<Product> products=productDatabse.products;
    clients.add(
      Client.fromAllData(id: 0, isBlocked: false, mail: 
      "mail", password: "p1", username: "u1", favoriteProducts: [])
    );
    clients.add(mockClient);
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
      Preference.fromAllData(allergens: [ingredients[0]], id: 0,
      category: Category.food,
       name: "my food preference", prefered: [ingredients[1]], client: clients[1])
    );
    preferences.add(
      Preference.fromAllData(allergens: [ingredients[0]], id: 0,
      category: Category.drink,
       name: "my drink preference", prefered: [ingredients[1]], client: clients[1])
    );
    preferences.add(
      Preference.fromAllData(allergens: [ingredients[0]], id: 0,
      category: Category.cosmetics,
       name: "my cosmetics preference", prefered: [ingredients[1]], client: clients[1])
    );
    preferences.add(
      Preference.fromAllData(allergens: [ingredients[0]], id: 0,
      category: null,
       name: "my general preference", prefered: [ingredients[1]], client: clients[1])
    );
    preferences.add(
      Preference.fromAllData(allergens: [ingredients[0],ingredients[2]], id: 1,
      category: null,
       name: "pref2", prefered: [ingredients[1]], client: clients[0])
    );
    preferences.add(
      Preference.fromAllData(allergens: [ingredients[3],ingredients[4],ingredients[1]], id: 2,
      category: null,
       name: "pref3", prefered: [ingredients[0]], client: clients[2])
    );
    preferences.add(
      Preference.fromAllData(allergens: [ingredients[1],ingredients[2]], id: 3,
      category: Category.cosmetics,
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
    producers.add(MockupUserDatabase.mockProucer);
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
    final productNames = [
  'Herbal Shampoo',
  'Organic Juice',
  'Nourishing Cream',
  'Protein Bar',
  'Mineral Water',
  'Anti-Aging Serum',
  'Energy Drink',
  'Moisturizing Lotion',
  'Whole Grain Cereal',
  'Detox Tea',
  'Hair Conditioner',
  'Sparkling Water',
  'Lip Balm',
  'Fruit Smoothie',
  'Hand Sanitizer',
  'Granola Bar',
  'Body Wash',
  'Green Tea',
  'Face Mask',
  'Vegetable Soup',
  'Aftershave Lotion',
  'Protein Shake',
  'Shaving Cream',
  'Almond Milk',
  'Hydrating Gel',
  'Coconut Water',
  'Sunscreen',
  'Tomato Juice',
  'Foot Cream',
  'Energy Bar',
];
    final productDescriptions = [
  'A refreshing herbal shampoo for daily use.',
  'Pure organic juice with no added sugars.',
  'A nourishing cream to revitalize your skin.',
  'A protein bar packed with nutrients.',
  'Natural mineral water sourced from the mountains.',
  'An anti-aging serum with advanced formula.',
  'Energy drink to keep you going all day.',
  'Moisturizing lotion for smooth and soft skin.',
  'Whole grain cereal for a healthy breakfast.',
  'Detox tea to cleanse your body naturally.',
  'Conditioner to keep your hair silky and smooth.',
  'Sparkling water with a hint of natural flavors.',
  'Lip balm to keep your lips hydrated.',
  'Delicious fruit smoothie for a healthy snack.',
  'Hand sanitizer to keep your hands germ-free.',
  'Granola bar for a quick and healthy snack.',
  'Body wash with natural ingredients.',
  'Green tea with a soothing aroma.',
  'Face mask to rejuvenate your skin.',
  'Hearty vegetable soup for a nutritious meal.',
  'Aftershave lotion to soothe your skin.',
  'Protein shake for muscle recovery.',
  'Rich shaving cream for a smooth shave.',
  'Almond milk with a rich, creamy taste.',
  'Hydrating gel for all-day moisture.',
  'Refreshing coconut water to hydrate naturally.',
  'Sunscreen to protect your skin from UV rays.',
  'Tomato juice rich in vitamins and minerals.',
  'Foot cream to keep your feet soft and smooth.',
  'Energy bar to fuel your active lifestyle.',
];
    for (int i = 0; i < 30; i++) {
    products.add(
      Product.fromAllData(
        id: i + 1,
        name: productNames[i],
        description: productDescriptions[i],
        category: Category.values[i % Category.values.length],
        ingredients: List.generate(5, (index) => ingredients[(i + index) % ingredients.length]),
        producer: producers[i % producers.length],
        promotionUntil: DateTime.now().add(Duration(days: (i + 1) * 10)),
      ),
    );
  }
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
      }).where((element) 
      {
        if(filter.category==null) return true;
        return element.category==filter.category!;
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
    ingredients = [
    Ingredient.fromAllData(id: 1, name: 'Water',iconURL: ""),
    Ingredient.fromAllData(id: 2, name: 'Sugar',iconURL: ""),
    Ingredient.fromAllData(id: 3, name: 'Salt',iconURL: ""),
    Ingredient.fromAllData(id: 4, name: 'Flavoring',iconURL: ""),
    Ingredient.fromAllData(id: 5, name: 'Preservatives',iconURL: ""),
    Ingredient.fromAllData(id: 6, name: 'Citric Acid',iconURL: ""),
    Ingredient.fromAllData(id: 7, name: 'Sodium Benzoate',iconURL: ""),
    Ingredient.fromAllData(id: 8, name: 'Vitamin C',iconURL: ""),
    Ingredient.fromAllData(id: 9, name: 'Calcium',iconURL: ""),
    Ingredient.fromAllData(id: 10, name: 'Iron',iconURL: ""),
    ];
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
    var products=productDatabse.products;
    var clients=userDatabse.clients;
    final opinionData = [
  {'text': 'Terrible product. Would not recommend.', 'score': 1.0},
  {'text': 'Not great, but it gets the job done.', 'score': 2.0},
  {'text': 'It\'s okay. Nothing special.', 'score': 3.0},
  {'text': 'Pretty good. I\'m satisfied.', 'score': 4.0},
  {'text': 'Excellent product! Highly recommended!', 'score': 5.0},
  {'text': 'Awful experience, very disappointed.', 'score': 1.0},
  {'text': 'Below average, expected more.', 'score': 2.0},
  {'text': 'Mediocre, could be better.', 'score': 3.0},
  {'text': 'Quite nice, would buy again.', 'score': 4.0},
  {'text': 'Outstanding quality!', 'score': 5.0},
  {'text': 'Horrible, waste of money.', 'score': 1.0},
  {'text': 'Not worth it.', 'score': 2.0},
  {'text': 'Average, nothing to write home about.', 'score': 3.0},
  {'text': 'Good quality, reasonable price.', 'score': 4.0},
  {'text': 'Fantastic product!', 'score': 5.0},
  {'text': 'Very poor quality.', 'score': 1.0},
  {'text': 'Doesn\'t live up to the hype.', 'score': 2.0},
  {'text': 'Just fine, nothing special.', 'score': 3.0},
  {'text': 'Really happy with this purchase.', 'score': 4.0},
  {'text': 'Exceeded my expectations!', 'score': 5.0},
  {'text': 'One of the worst purchases I\'ve made.', 'score': 1.0},
  {'text': 'Meh, it\'s okay.', 'score': 2.0},
  {'text': 'Decent, but has room for improvement.', 'score': 3.0},
  {'text': 'Love it, will definitely buy again.', 'score': 4.0},
  {'text': 'Top-notch, highly recommend!', 'score': 5.0},
  {'text': 'Regret buying this.', 'score': 1.0},
  {'text': 'Could be better.', 'score': 2.0},
  {'text': 'Not bad, but not great either.', 'score': 3.0},
  {'text': 'Really good value for money.', 'score': 4.0},
  {'text': 'Superb, absolutely love it!', 'score': 5.0},
  {'text': 'Terrible, do not buy.', 'score': 1.0},
  {'text': 'Just about okay.', 'score': 2.0},
  {'text': 'Satisfactory, but not impressive.', 'score': 3.0},
  {'text': 'Very pleased with this product.', 'score': 4.0},
  {'text': 'Perfect, exactly what I wanted!', 'score': 5.0},
  ];
  Random random=Random(42);
   int opinionId = 1;
  for (var product in products) {
    int numberOfOpinions = random.nextInt(4); // Generate between 1 and 5 opinions per product
    for (int i = 0; i < numberOfOpinions; i++) {
      final opinion = opinionData[opinionId % opinionData.length];
      opinions.add(
        Opinion.fromAllData(
          id: opinionId++,
          author: clients[random.nextInt(clients.length)],
          text: opinion['text']! as String,
          score: opinion['score']! as double,
          product: product,
        ),
      );
    }
  }
  }
  List<Opinion> opinions;
  @override
  Future<bool> addOpinion(Opinion opinion) async {
    opinions.add(opinion);
    return true;
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
  UserDatabse get userDatabse =>_userDatabse;
  
}