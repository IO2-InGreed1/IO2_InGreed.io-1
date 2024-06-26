import 'package:test/test.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
class TestInitializer
{
  static Producer get producer=>Producer.fromAllData(companyName: "Test", nip: "0", representativeName: "Name", representativeSurname: "Surname", telephoneNumber: "000000000",    id: 0, isBlocked: false, mail: 'mail', password: '', username: 'producer');
  static Product get product=>Product.fromAllData(category: Category.cosmetics, id: 0, ingredients: [], name: "Test", producer: producer, promotionUntil: DateTime(0),description: "desc");
  static Client get client=>Client.fromAllData(id: 0, isBlocked: false, mail: "mail@mail.com", password: "myPassword", username: "User", favoriteProducts: []);
  static List<Preference> get preferences
  {
    Preference p1=Preference.fromAllData(client: client,allergens: [], id: 0, name: "preferance 1", prefered: [commonIngredients[1],commonIngredients[2]],category: null);
    Preference p2=Preference.fromAllData(client: client,allergens: [commonIngredients[1]], id: 1, name: "preferance 2", prefered: [commonIngredients[3],commonIngredients[0]],category: null);
    Preference p3=Preference.fromAllData(client: client,allergens: [commonIngredients[0],commonIngredients[3]], id: 2, name: "preferance 3", prefered: [commonIngredients[2],commonIngredients[1]],category: null);
    return [p1,p2,p3];
  }
  static List<Ingredient> get commonIngredients
  {
    Ingredient i1=Ingredient.fromAllData(iconURL: "", id: 0, name: "i1");
    Ingredient i2=Ingredient.fromAllData(iconURL: "", id: 1, name: "i2");
    Ingredient i3=Ingredient.fromAllData(iconURL: "", id: 2, name: "i3");
    Ingredient i4=Ingredient.fromAllData(iconURL: "", id: 3, name: "i4");
    Ingredient i5=Ingredient.fromAllData(iconURL: "", id: 4, name: "i5");
    return [i1,i2,i3,i4,i5];
  }
  static Moderator get moderator=>Moderator.fromAllData(id: 11, isBlocked: false, mail: 'XP@foo.com', password: null, username: 'Michał',moderatorNumber: 0, editedOpinionList: []);
  static List<Opinion> get opinions
  {
    Opinion o1=Opinion.fromAllData(author: client, id: 0, product: product, score: 0, text: "opinion1");
    Opinion o2=Opinion.fromAllData(author: client, id: 1, product: product, score: 1, text: "opinion2");
    Opinion o3=Opinion.fromAllData(author: client, id: 2, product: product, score: 3, text: "opinion3");
    return [o1,o2,o3];
  }
}
void main() {
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
}
