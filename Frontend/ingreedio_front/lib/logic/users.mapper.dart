// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'users.dart';

class UserMapper extends ClassMapperBase<User> {
  UserMapper._();

  static UserMapper? _instance;
  static UserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserMapper._());
      ClientMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'User';

  static int _$id(User v) => v.id;
  static const Field<User, int> _f$id = Field('id', _$id);
  static bool _$isBlocked(User v) => v.isBlocked;
  static const Field<User, bool> _f$isBlocked = Field('isBlocked', _$isBlocked);
  static String _$mail(User v) => v.mail;
  static const Field<User, String> _f$mail = Field('mail', _$mail);
  static String? _$password(User v) => v.password;
  static const Field<User, String> _f$password = Field('password', _$password);
  static String _$username(User v) => v.username;
  static const Field<User, String> _f$username = Field('username', _$username);

  @override
  final MappableFields<User> fields = const {
    #id: _f$id,
    #isBlocked: _f$isBlocked,
    #mail: _f$mail,
    #password: _f$password,
    #username: _f$username,
  };

  static User _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'User', 'Type', '${data.value['Type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static User fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<User>(map);
  }

  static User fromJson(String json) {
    return ensureInitialized().decodeJson<User>(json);
  }
}

mixin UserMappable {
  String toJson();
  Map<String, dynamic> toMap();
  UserCopyWith<User, User, User> get copyWith;
}

abstract class UserCopyWith<$R, $In extends User, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      bool? isBlocked,
      String? mail,
      String? password,
      String? username});
  UserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ClientMapper extends SubClassMapperBase<Client> {
  ClientMapper._();

  static ClientMapper? _instance;
  static ClientMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClientMapper._());
      UserMapper.ensureInitialized().addSubMapper(_instance!);
      ProductMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Client';

  static int _$id(Client v) => v.id;
  static const Field<Client, int> _f$id = Field('id', _$id);
  static bool _$isBlocked(Client v) => v.isBlocked;
  static const Field<Client, bool> _f$isBlocked =
      Field('isBlocked', _$isBlocked);
  static String _$mail(Client v) => v.mail;
  static const Field<Client, String> _f$mail = Field('mail', _$mail);
  static String? _$password(Client v) => v.password;
  static const Field<Client, String> _f$password =
      Field('password', _$password);
  static String _$username(Client v) => v.username;
  static const Field<Client, String> _f$username =
      Field('username', _$username);
  static List<Product> _$favoriteProducts(Client v) => v.favoriteProducts;
  static const Field<Client, List<Product>> _f$favoriteProducts =
      Field('favoriteProducts', _$favoriteProducts);

  @override
  final MappableFields<Client> fields = const {
    #id: _f$id,
    #isBlocked: _f$isBlocked,
    #mail: _f$mail,
    #password: _f$password,
    #username: _f$username,
    #favoriteProducts: _f$favoriteProducts,
  };

  @override
  final String discriminatorKey = 'Type';
  @override
  final dynamic discriminatorValue = "Client";
  @override
  late final ClassMapperBase superMapper = UserMapper.ensureInitialized();

  static Client _instantiate(DecodingData data) {
    return Client.fromAllData(
        id: data.dec(_f$id),
        isBlocked: data.dec(_f$isBlocked),
        mail: data.dec(_f$mail),
        password: data.dec(_f$password),
        username: data.dec(_f$username),
        favoriteProducts: data.dec(_f$favoriteProducts));
  }

  @override
  final Function instantiate = _instantiate;

  static Client fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Client>(map);
  }

  static Client fromJson(String json) {
    return ensureInitialized().decodeJson<Client>(json);
  }
}

mixin ClientMappable {
  String toJson() {
    return ClientMapper.ensureInitialized().encodeJson<Client>(this as Client);
  }

  Map<String, dynamic> toMap() {
    return ClientMapper.ensureInitialized().encodeMap<Client>(this as Client);
  }

  ClientCopyWith<Client, Client, Client> get copyWith =>
      _ClientCopyWithImpl(this as Client, $identity, $identity);
  @override
  String toString() {
    return ClientMapper.ensureInitialized().stringifyValue(this as Client);
  }

  @override
  bool operator ==(Object other) {
    return ClientMapper.ensureInitialized().equalsValue(this as Client, other);
  }

  @override
  int get hashCode {
    return ClientMapper.ensureInitialized().hashValue(this as Client);
  }
}

extension ClientValueCopy<$R, $Out> on ObjectCopyWith<$R, Client, $Out> {
  ClientCopyWith<$R, Client, $Out> get $asClient =>
      $base.as((v, t, t2) => _ClientCopyWithImpl(v, t, t2));
}

abstract class ClientCopyWith<$R, $In extends Client, $Out>
    implements UserCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Product, ProductCopyWith<$R, Product, Product>>
      get favoriteProducts;
  @override
  $R call(
      {int? id,
      bool? isBlocked,
      String? mail,
      String? password,
      String? username,
      List<Product>? favoriteProducts});
  ClientCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ClientCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Client, $Out>
    implements ClientCopyWith<$R, Client, $Out> {
  _ClientCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Client> $mapper = ClientMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Product, ProductCopyWith<$R, Product, Product>>
      get favoriteProducts => ListCopyWith($value.favoriteProducts,
          (v, t) => v.copyWith.$chain(t), (v) => call(favoriteProducts: v));
  @override
  $R call(
          {int? id,
          bool? isBlocked,
          String? mail,
          Object? password = $none,
          String? username,
          List<Product>? favoriteProducts}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (isBlocked != null) #isBlocked: isBlocked,
        if (mail != null) #mail: mail,
        if (password != $none) #password: password,
        if (username != null) #username: username,
        if (favoriteProducts != null) #favoriteProducts: favoriteProducts
      }));
  @override
  Client $make(CopyWithData data) => Client.fromAllData(
      id: data.get(#id, or: $value.id),
      isBlocked: data.get(#isBlocked, or: $value.isBlocked),
      mail: data.get(#mail, or: $value.mail),
      password: data.get(#password, or: $value.password),
      username: data.get(#username, or: $value.username),
      favoriteProducts:
          data.get(#favoriteProducts, or: $value.favoriteProducts));

  @override
  ClientCopyWith<$R2, Client, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ClientCopyWithImpl($value, $cast, t);
}
