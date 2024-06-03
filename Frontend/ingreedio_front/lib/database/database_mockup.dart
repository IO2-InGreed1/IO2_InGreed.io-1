import 'dart:math';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
import '../cubit_logic/products_cubit.dart' as cb;

class MockupUserDatabase extends UserDatabse
{
  static Client mockClient=Client.fromAllData(id: 10, isBlocked: false, mail: 'XD@foo.com', password: null, username: 'Daniel', favoriteProducts: MockupProductDatabase.filled(MockupIngredientDatabase.filled()).products.getRange(7, 12).toList(),);
  static Producer mockProucer=Producer.fromAllData(
    companyName: 'C1', nip: '123', representativeName: 'Paweł', representativeSurname: 'Dzik', telephoneNumber: '2137',
    id: 0, isBlocked: false, mail: 'mail', password: '', username: 'producer'
    );
  static Moderator mockModerator=Moderator.fromAllData(id: 11, isBlocked: false, mail: 'XP@foo.com', password: null, username: 'Michał',moderatorNumber: 1,editedOpinionList: []);
  static Admin mockAdmin=Admin.fromAllData(id: 12, isBlocked: false, mail: 'XQ@foo.com', password: null, username: 'Jacek',controlPanel: ControlPanel());
  
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
    List<Ingredient> foodIngredients = ingredients.where((ingredient) => ingredient.id <= 20).toList();
  List<Ingredient> cosmeticIngredients = ingredients.where((ingredient) => ingredient.id > 20 && ingredient.id <= 40).toList();
  List<Ingredient> drinkIngredients = ingredients.where((ingredient) => ingredient.id > 40).toList();
    preferences.add(
      Preference.fromAllData(allergens: [foodIngredients[0]], id: 0,
      category: Category.food,
       name: "my food preference", prefered: [foodIngredients[5]], client: clients[1])
    );
    preferences.add(
      Preference.fromAllData(allergens: [drinkIngredients[0],drinkIngredients[6]], id: 0,
      category: Category.drink,
       name: "my drink preference", prefered: [drinkIngredients[3]], client: clients[1])
    );
    preferences.add(
      Preference.fromAllData(allergens: [cosmeticIngredients[0]], id: 0,
      category: Category.cosmetics,
       name: "my cosmetics preference", prefered: [cosmeticIngredients[3],cosmeticIngredients[5]], client: clients[1])
    );
    preferences.add(
      Preference.fromAllData(allergens: [cosmeticIngredients[0],foodIngredients[0],drinkIngredients[0],drinkIngredients[6]], id: 0,
      category: null,
       name: "my general preference", prefered: [], client: clients[1])
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
  
  @override
  Future<User?> loadUser(String token) async {
    switch(token)
    {
      case "client":
      return mockClient;
      case "admin":
      return mockAdmin;
      case "producer":
      return mockProucer;
      case "moderator":
      return mockModerator;
    }
    return null;
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
      "C1", nip: "123", representativeName: "name1", representativeSurname: "surname1", telephoneNumber: "49",
          id: 0, isBlocked: false, mail: 'mail', password: '', username: 'producer')
    );
    producers.add(
      Producer.fromAllData(companyName: 
      "C2", nip: "321", representativeName: "name2", representativeSurname: "surname2", telephoneNumber: "49-1",
          id: 0, isBlocked: false, mail: 'mail', password: '', username: 'producer')
    );
    producers.add(
      Producer.fromAllData(companyName: 
      "C3", nip: "2137", representativeName: "name3", representativeSurname: "surname1", telephoneNumber: "49-2",
          id: 0, isBlocked: false, mail: 'mail', password: '', username: 'producer')
    );
    final productData = [
  {
    'name': 'Herbal Shampoo',
    'description': 'A refreshing herbal shampoo for daily use.',
    'category': Category.cosmetics,
    'ingredients': [21, 22, 23, 29, 30],
  },
  {
    'name': 'Organic Juice',
    'description': 'Pure organic juice with no added sugars.',
    'category': Category.drink,
    'ingredients': [42, 44, 45, 53, 54],
  },
  {
    'name': 'Nourishing Cream',
    'description': 'A nourishing cream to revitalize your skin.',
    'category': Category.cosmetics,
    'ingredients': [22, 23, 25, 26, 28],
  },
  {
    'name': 'Protein Bar',
    'description': 'A protein bar packed with nutrients.',
    'category': Category.food,
    'ingredients': [3, 7, 9, 12, 13],
  },
  {
    'name': 'Mineral Water',
    'description': 'Natural mineral water sourced from the mountains.',
    'category': Category.drink,
    'ingredients': [41, 43, 44],
  },
  {
    'name': 'Anti-Aging Serum',
    'description': 'An anti-aging serum with advanced formula.',
    'category': Category.cosmetics,
    'ingredients': [21, 24, 25, 28],
  },
  {
    'name': 'Energy Drink',
    'description': 'Energy drink to keep you going all day.',
    'category': Category.drink,
    'ingredients': [41, 43, 44, 47],
  },
  {
    'name': 'Moisturizing Lotion',
    'description': 'Moisturizing lotion for smooth and soft skin.',
    'category': Category.cosmetics,
    'ingredients': [21, 22, 26, 27, 30],
  },
  {
    'name': 'Whole Grain Cereal',
    'description': 'Whole grain cereal for a healthy breakfast.',
    'category': Category.food,
    'ingredients': [3, 10, 12, 13],
  },
  {
    'name': 'Detox Tea',
    'description': 'Detox tea to cleanse your body naturally.',
    'category': Category.drink,
    'ingredients': [5, 29, 45, 54],
  },
  {
    'name': 'Hair Conditioner',
    'description': 'Conditioner to keep your hair silky and smooth.',
    'category': Category.cosmetics,
    'ingredients': [22, 23, 27, 30],
  },
  {
    'name': 'Sparkling Water',
    'description': 'Sparkling water with a hint of natural flavors.',
    'category': Category.drink,
    'ingredients': [41, 44, 53],
  },
  {
    'name': 'Lip Balm',
    'description': 'Lip balm to keep your lips hydrated.',
    'category': Category.cosmetics,
    'ingredients': [22, 26, 28],
  },
  {
    'name': 'Fruit Smoothie',
    'description': 'Delicious fruit smoothie for a healthy snack.',
    'category': Category.drink,
    'ingredients': [42, 48, 50, 53],
  },
  {
    'name': 'Hand Sanitizer',
    'description': 'Hand sanitizer to keep your hands germ-free.',
    'category': Category.cosmetics,
    'ingredients': [22, 26, 28, 29],
  },
  {
    'name': 'Granola Bar',
    'description': 'Granola bar for a quick and healthy snack.',
    'category': Category.food,
    'ingredients': [3, 10, 12, 17],
  },
  {
    'name': 'Body Wash',
    'description': 'Body wash with natural ingredients.',
    'category': Category.cosmetics,
    'ingredients': [21, 22, 26, 29],
  },
  {
    'name': 'Green Tea',
    'description': 'Green tea with a soothing aroma.',
    'category': Category.drink,
    'ingredients': [5, 29, 45, 54],
  },
  {
    'name': 'Face Mask',
    'description': 'Face mask to rejuvenate your skin.',
    'category': Category.cosmetics,
    'ingredients': [21, 22, 24, 28],
  },
  {
    'name': 'Vegetable Soup',
    'description': 'Hearty vegetable soup for a nutritious meal.',
    'category': Category.food,
    'ingredients': [6, 8, 9, 13],
  },
  {
    'name': 'Aftershave Lotion',
    'description': 'Aftershave lotion to soothe your skin.',
    'category': Category.cosmetics,
    'ingredients': [22, 26, 28],
  },
  {
    'name': 'Protein Shake',
    'description': 'Protein shake for muscle recovery.',
    'category': Category.drink,
    'ingredients': [7, 43, 48, 50],
  },
  {
    'name': 'Shaving Cream',
    'description': 'Rich shaving cream for a smooth shave.',
    'category': Category.cosmetics,
    'ingredients': [22, 24, 26, 28],
  },
  {
    'name': 'Almond Milk',
    'description': 'Almond milk with a rich, creamy taste.',
    'category': Category.drink,
    'ingredients': [42, 44, 50],
  },
  {
    'name': 'Hydrating Gel',
    'description': 'Hydrating gel for all-day moisture.',
    'category': Category.cosmetics,
    'ingredients': [22, 25, 27, 28],
  },
  {
    'name': 'Coconut Water',
    'description': 'Refreshing coconut water to hydrate naturally.',
    'category': Category.drink,
    'ingredients': [41, 44, 51],
  },
  {
    'name': 'Sunscreen',
    'description': 'Sunscreen to protect your skin from UV rays.',
    'category': Category.cosmetics,
    'ingredients': [22, 24, 26, 27],
  },
  {
    'name': 'Tomato Juice',
    'description': 'Tomato juice rich in vitamins and minerals.',
    'category': Category.drink,
    'ingredients': [4, 42, 44],
  },
  {
    'name': 'Foot Cream',
    'description': 'Foot cream to keep your feet soft and smooth.',
    'category': Category.cosmetics,
    'ingredients': [22, 26, 27, 28],
  },
  {
    'name': 'Energy Bar',
    'description': 'Energy bar to fuel your active lifestyle.',
    'category': Category.food,
    'ingredients': [3, 7, 9, 12],
  },
];
  for (int i = 0; i < productData.length; i++) {
    final data = productData[i];
    final productIngredients = data['ingredients'] as List<int>;
    products.add(
      Product.fromAllData(
        id: i + 1,
        name: data['name'] as String,
        description: data['description'] as String,
        category: data['category'] as Category,
        ingredients: productIngredients.map((id) => ingredients.firstWhere((ing) => ing.id == id)).toList(),
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
  
  @override
  Future<bool> setProductReportState(Product product, {bool state = false}) async {
    int index=products.indexOf(product);
    products[index].isReported=state;
    product.isReported=state;
    return true;
  }
  
  @override
  Future<ListData<Product>> filterReportedProducts(int from, int to, Filter<Product> filter) async {
    return cb.filterProducts(products.where((e)=>e.isReported).toList(),from, to, ProductFilter());
  }
}
class MockupIngredientDatabase extends IngredientDatabase
{
  List<Ingredient> ingredients;
  MockupIngredientDatabase.filled():ingredients=List.empty(growable: true)
  {
    ingredients = [
  // Food Ingredients
  Ingredient.fromAllData(id: 1, name: 'Water'),
  Ingredient.fromAllData(id: 2, name: 'Salt'),
  Ingredient.fromAllData(id: 3, name: 'Whole Grains'),
  Ingredient.fromAllData(id: 4, name: 'Fruit Extract'),
  Ingredient.fromAllData(id: 5, name: 'Tea Leaves'),
  Ingredient.fromAllData(id: 6, name: 'Vegetables'),
  Ingredient.fromAllData(id: 7, name: 'Protein'),
  Ingredient.fromAllData(id: 8, name: 'Vitamin C'),
  Ingredient.fromAllData(id: 9, name: 'Calcium'),
  Ingredient.fromAllData(id: 10, name: 'Oats'),
  Ingredient.fromAllData(id: 11, name: 'Honey'),
  Ingredient.fromAllData(id: 12, name: 'Nuts'),
  Ingredient.fromAllData(id: 13, name: 'Seeds'),
  Ingredient.fromAllData(id: 14, name: 'Coconut'),
  Ingredient.fromAllData(id: 15, name: 'Spices'),
  Ingredient.fromAllData(id: 16, name: 'Herbs'),
  Ingredient.fromAllData(id: 17, name: 'Dried Fruits'),
  Ingredient.fromAllData(id: 18, name: 'Pea Protein'),
  Ingredient.fromAllData(id: 19, name: 'Rice Protein'),
  Ingredient.fromAllData(id: 20, name: 'Potato Starch'),

  // Cosmetic Ingredients
  Ingredient.fromAllData(id: 21, name: 'Aloe Vera'),
  Ingredient.fromAllData(id: 22, name: 'Shea Butter'),
  Ingredient.fromAllData(id: 23, name: 'Essential Oils'),
  Ingredient.fromAllData(id: 24, name: 'Collagen'),
  Ingredient.fromAllData(id: 25, name: 'Hyaluronic Acid'),
  Ingredient.fromAllData(id: 26, name: 'Coconut Oil'),
  Ingredient.fromAllData(id: 27, name: 'Glycerin'),
  Ingredient.fromAllData(id: 28, name: 'Vitamin E'),
  Ingredient.fromAllData(id: 29, name: 'Green Tea Extract'),
  Ingredient.fromAllData(id: 30, name: 'Chamomile Extract'),
  Ingredient.fromAllData(id: 31, name: 'Lavender Oil'),
  Ingredient.fromAllData(id: 32, name: 'Rosehip Oil'),
  Ingredient.fromAllData(id: 33, name: 'Jojoba Oil'),
  Ingredient.fromAllData(id: 34, name: 'Avocado Oil'),
  Ingredient.fromAllData(id: 35, name: 'Argan Oil'),
  Ingredient.fromAllData(id: 36, name: 'Almond Oil'),
  Ingredient.fromAllData(id: 37, name: 'Beeswax'),
  Ingredient.fromAllData(id: 38, name: 'Vitamin A'),
  Ingredient.fromAllData(id: 39, name: 'Sunflower Oil'),
  Ingredient.fromAllData(id: 40, name: 'Cucumber Extract'),

  // Drink Ingredients
  Ingredient.fromAllData(id: 41, name: 'Carbonated Water'),
  Ingredient.fromAllData(id: 42, name: 'Fruit Juice'),
  Ingredient.fromAllData(id: 43, name: 'Electrolytes'),
  Ingredient.fromAllData(id: 44, name: 'Natural Flavors'),
  Ingredient.fromAllData(id: 45, name: 'Green Tea'),
  Ingredient.fromAllData(id: 46, name: 'Black Tea'),
  Ingredient.fromAllData(id: 47, name: 'Coffee Extract'),
  Ingredient.fromAllData(id: 48, name: 'Milk'),
  Ingredient.fromAllData(id: 49, name: 'Soy Milk'),
  Ingredient.fromAllData(id: 50, name: 'Almond Milk'),
  Ingredient.fromAllData(id: 51, name: 'Coconut Water'),
  Ingredient.fromAllData(id: 52, name: 'Maple Syrup'),
  Ingredient.fromAllData(id: 53, name: 'Lemon Juice'),
  Ingredient.fromAllData(id: 54, name: 'Mint'),
  Ingredient.fromAllData(id: 55, name: 'Ginger'),
  Ingredient.fromAllData(id: 56, name: 'Turmeric'),
  Ingredient.fromAllData(id: 57, name: 'Chia Seeds'),
  Ingredient.fromAllData(id: 58, name: 'Kale'),
  Ingredient.fromAllData(id: 59, name: 'Spirulina'),
  Ingredient.fromAllData(id: 60, name: 'Cinnamon'),
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
  Future<String?> login(String email, String password) async {
    for(var e in creds)
    {
      if(e.$1==email&&e.$2==password) {
        switch(e.$4)
        {
        
          case UserRole.client:
            return "client";
          case UserRole.producer:
            return "producer";
          case UserRole.moderator:
            return "moderator";
          case UserRole.admin:
            return "admin";
        }
      }
    }
    return null;
  }

  @override
  Future<String?> register(String username, String email, String password,UserRole userRole) async {
    creds.add((email,password,username,userRole));
    switch(userRole)
        {
        
          case UserRole.client:
            return "client";
          case UserRole.producer:
            return "producer";
          case UserRole.moderator:
            return "moderator";
          case UserRole.admin:
            return "admin";
        }
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