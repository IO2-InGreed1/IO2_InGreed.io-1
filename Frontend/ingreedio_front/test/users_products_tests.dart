import 'package:flutter_test/flutter_test.dart';
import 'package:ingreedio_front/admins.dart';
import 'package:ingreedio_front/products.dart';
import 'package:ingreedio_front/users.dart';
class TestInitializer
{
  static Producer get producer=>Producer.fromAllData(companyName: "Test", nip: "0", representativeName: "Name", representativeSurname: "Surname", telephoneNumber: "000000000");
  static Product get product=>Product.fromAllData(category: Category.cosmetics, id: 0, ingredients: [], name: "Test", opinions: [], producer: producer, promotionUntil: DateTime(0));
  static Client get client=>Client.fromAllData(id: 0, isBlocked: false, mail: "mail@mail.com", password: "myPassword", username: "User", preferences: [], favoriteProducts: []);
  static List<Preference> get preferences
  {
    Preference p1=Preference.fromAllData(allergens: [], id: 0, isActive: true, name: "preferance 1", prefered: [commonIngredients[1],commonIngredients[2]]);
    Preference p2=Preference.fromAllData(allergens: [commonIngredients[1]], id: 1, isActive: false, name: "preferance 2", prefered: [commonIngredients[3],commonIngredients[0]]);
    Preference p3=Preference.fromAllData(allergens: [commonIngredients[0],commonIngredients[3]], id: 2, isActive: false, name: "preferance 3", prefered: [commonIngredients[2],commonIngredients[1]]);
    return [p1,p2,p3];
  }
  static List<Ingredient> get commonIngredients
  {
    Ingredient i1=Ingredient.fromAllData(iconUrl: "", id: 0, name: "i1");
    Ingredient i2=Ingredient.fromAllData(iconUrl: "", id: 1, name: "i2");
    Ingredient i3=Ingredient.fromAllData(iconUrl: "", id: 2, name: "i3");
    Ingredient i4=Ingredient.fromAllData(iconUrl: "", id: 3, name: "i4");
    Ingredient i5=Ingredient.fromAllData(iconUrl: "", id: 4, name: "i5");
    return [i1,i2,i3,i4,i5];
  }
  static Moderator get moderator=>Moderator.fromAllData(moderatorNumber: 0, editedOpinionList: []);
  static List<Opinion> get opinions
  {
    Opinion o1=Opinion.fromAllData(author: client, id: 0, product: product, score: 0, text: "opinion1");
    Opinion o2=Opinion.fromAllData(author: client, id: 1, product: product, score: 1, text: "opinion2");
    Opinion o3=Opinion.fromAllData(author: client, id: 2, product: product, score: 3, text: "opinion3");
    return [o1,o2,o3];
  }
}
void main() {
  test('IProducer.promoteProduct(Product) changes product promotion time', () {
    //Arrange
    Producer producer=TestInitializer.producer;
    Product product=TestInitializer.product;
    DateTime time=DateTime(2017);
    //Act
    producer.promoteProduct(product,time);
    //Assert
    expect(product.promotionUntil, equals(time));
  });
  test('Client.removePreferance() removes user preference, when preference exists', () {
    //Arrange
    Client client=TestInitializer.client;
    Preference preference=TestInitializer.preferences[0];
    client.preferences=TestInitializer.preferences;
    //Act
    client.removePreferance(preference);
    //Assert
    expect(client.preferences, equals([TestInitializer.preferences[1],TestInitializer.preferences[2]]));
  });
  //(un)blocking user tests
  test('ControlPanel.blockUser() blocks not-blocked user', () {
    //Arrange
    Client user=TestInitializer.client;
    ControlPanel controlPanel=ControlPanel();
    //Act
    controlPanel.blockUser(user);
    //Assert
    expect(user.isBlocked, equals(true));
  });
  test('ControlPanel.unBlockUser() unblocks blocked user', () {
    //Arrange
    Client user=TestInitializer.client..isBlocked=true;
    ControlPanel controlPanel=ControlPanel();
    //Act
    controlPanel.unBlockUser(user);
    //Assert
    expect(user.isBlocked, equals(false));
  });
  test('ControlPanel.unBlockUser() does nothing to un-blocked user', () {
    //Arrange
    Client user=TestInitializer.client..isBlocked=false;
    ControlPanel controlPanel=ControlPanel();
    //Act
    controlPanel.unBlockUser(user);
    //Assert
    expect(user.isBlocked, equals(false));
  });
  test('ControlPanel.blockUser() does nothing to blocked user', () {
    //Arrange
    Client user=TestInitializer.client..isBlocked=true;
    ControlPanel controlPanel=ControlPanel();
    //Act
    controlPanel.blockUser(user);
    //Assert
    expect(user.isBlocked, equals(true));
  });
  test('Moderator.clearEditedOpinionList() clears edited opinions list', () {
    //Arrange
    Moderator moderator=TestInitializer.moderator;
    moderator.editedOpinionList=TestInitializer.opinions;
    //Act
    moderator.clearEditedOpinionList();
    //Assert
    expect(moderator.editedOpinionList, equals([]));
  });
}
