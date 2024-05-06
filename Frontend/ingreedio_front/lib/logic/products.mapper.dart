// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'products.dart';

class ProductMapper extends ClassMapperBase<Product> {
  ProductMapper._();

  static ProductMapper? _instance;
  static ProductMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductMapper._());
      IngredientMapper.ensureInitialized();
      ProducerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Product';

  static Category _$category(Product v) => v.category;
  static const Field<Product, Category> _f$category =
      Field('category', _$category);
  static String _$description(Product v) => v.description;
  static const Field<Product, String> _f$description =
      Field('description', _$description);
  static int _$id(Product v) => v.id;
  static const Field<Product, int> _f$id = Field('id', _$id);
  static List<Ingredient> _$ingredients(Product v) => v.ingredients;
  static const Field<Product, List<Ingredient>> _f$ingredients =
      Field('ingredients', _$ingredients);
  static String _$name(Product v) => v.name;
  static const Field<Product, String> _f$name = Field('name', _$name);
  static Producer _$producer(Product v) => v.producer;
  static const Field<Product, Producer> _f$producer =
      Field('producer', _$producer);
  static DateTime _$promotionUntil(Product v) => v.promotionUntil;
  static const Field<Product, DateTime> _f$promotionUntil =
      Field('promotionUntil', _$promotionUntil);

  @override
  final MappableFields<Product> fields = const {
    #category: _f$category,
    #description: _f$description,
    #id: _f$id,
    #ingredients: _f$ingredients,
    #name: _f$name,
    #producer: _f$producer,
    #promotionUntil: _f$promotionUntil,
  };

  static Product _instantiate(DecodingData data) {
    return Product.fromAllData(
        category: data.dec(_f$category),
        description: data.dec(_f$description),
        id: data.dec(_f$id),
        ingredients: data.dec(_f$ingredients),
        name: data.dec(_f$name),
        producer: data.dec(_f$producer),
        promotionUntil: data.dec(_f$promotionUntil));
  }

  @override
  final Function instantiate = _instantiate;

  static Product fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Product>(map);
  }

  static Product fromJson(String json) {
    return ensureInitialized().decodeJson<Product>(json);
  }
}

mixin ProductMappable {
  String toJson() {
    return ProductMapper.ensureInitialized()
        .encodeJson<Product>(this as Product);
  }

  Map<String, dynamic> toMap() {
    return ProductMapper.ensureInitialized()
        .encodeMap<Product>(this as Product);
  }

  ProductCopyWith<Product, Product, Product> get copyWith =>
      _ProductCopyWithImpl(this as Product, $identity, $identity);
  @override
  String toString() {
    return ProductMapper.ensureInitialized().stringifyValue(this as Product);
  }

  @override
  bool operator ==(Object other) {
    return ProductMapper.ensureInitialized()
        .equalsValue(this as Product, other);
  }

  @override
  int get hashCode {
    return ProductMapper.ensureInitialized().hashValue(this as Product);
  }
}

extension ProductValueCopy<$R, $Out> on ObjectCopyWith<$R, Product, $Out> {
  ProductCopyWith<$R, Product, $Out> get $asProduct =>
      $base.as((v, t, t2) => _ProductCopyWithImpl(v, t, t2));
}

abstract class ProductCopyWith<$R, $In extends Product, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Ingredient, IngredientCopyWith<$R, Ingredient, Ingredient>>
      get ingredients;
  ProducerCopyWith<$R, Producer, Producer> get producer;
  $R call(
      {Category? category,
      String? description,
      int? id,
      List<Ingredient>? ingredients,
      String? name,
      Producer? producer,
      DateTime? promotionUntil});
  ProductCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProductCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Product, $Out>
    implements ProductCopyWith<$R, Product, $Out> {
  _ProductCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Product> $mapper =
      ProductMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Ingredient, IngredientCopyWith<$R, Ingredient, Ingredient>>
      get ingredients => ListCopyWith($value.ingredients,
          (v, t) => v.copyWith.$chain(t), (v) => call(ingredients: v));
  @override
  ProducerCopyWith<$R, Producer, Producer> get producer =>
      $value.producer.copyWith.$chain((v) => call(producer: v));
  @override
  $R call(
          {Category? category,
          String? description,
          int? id,
          List<Ingredient>? ingredients,
          String? name,
          Producer? producer,
          DateTime? promotionUntil}) =>
      $apply(FieldCopyWithData({
        if (category != null) #category: category,
        if (description != null) #description: description,
        if (id != null) #id: id,
        if (ingredients != null) #ingredients: ingredients,
        if (name != null) #name: name,
        if (producer != null) #producer: producer,
        if (promotionUntil != null) #promotionUntil: promotionUntil
      }));
  @override
  Product $make(CopyWithData data) => Product.fromAllData(
      category: data.get(#category, or: $value.category),
      description: data.get(#description, or: $value.description),
      id: data.get(#id, or: $value.id),
      ingredients: data.get(#ingredients, or: $value.ingredients),
      name: data.get(#name, or: $value.name),
      producer: data.get(#producer, or: $value.producer),
      promotionUntil: data.get(#promotionUntil, or: $value.promotionUntil));

  @override
  ProductCopyWith<$R2, Product, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProductCopyWithImpl($value, $cast, t);
}

class IngredientMapper extends ClassMapperBase<Ingredient> {
  IngredientMapper._();

  static IngredientMapper? _instance;
  static IngredientMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IngredientMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Ingredient';

  static String _$iconURL(Ingredient v) => v.iconURL;
  static const Field<Ingredient, String> _f$iconURL =
      Field('iconURL', _$iconURL);
  static int _$id(Ingredient v) => v.id;
  static const Field<Ingredient, int> _f$id = Field('id', _$id);
  static String _$name(Ingredient v) => v.name;
  static const Field<Ingredient, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<Ingredient> fields = const {
    #iconURL: _f$iconURL,
    #id: _f$id,
    #name: _f$name,
  };

  static Ingredient _instantiate(DecodingData data) {
    return Ingredient.fromAllData(
        iconURL: data.dec(_f$iconURL),
        id: data.dec(_f$id),
        name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static Ingredient fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Ingredient>(map);
  }

  static Ingredient fromJson(String json) {
    return ensureInitialized().decodeJson<Ingredient>(json);
  }
}

mixin IngredientMappable {
  String toJson() {
    return IngredientMapper.ensureInitialized()
        .encodeJson<Ingredient>(this as Ingredient);
  }

  Map<String, dynamic> toMap() {
    return IngredientMapper.ensureInitialized()
        .encodeMap<Ingredient>(this as Ingredient);
  }

  IngredientCopyWith<Ingredient, Ingredient, Ingredient> get copyWith =>
      _IngredientCopyWithImpl(this as Ingredient, $identity, $identity);
  @override
  String toString() {
    return IngredientMapper.ensureInitialized()
        .stringifyValue(this as Ingredient);
  }

  @override
  bool operator ==(Object other) {
    return IngredientMapper.ensureInitialized()
        .equalsValue(this as Ingredient, other);
  }

  @override
  int get hashCode {
    return IngredientMapper.ensureInitialized().hashValue(this as Ingredient);
  }
}

extension IngredientValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Ingredient, $Out> {
  IngredientCopyWith<$R, Ingredient, $Out> get $asIngredient =>
      $base.as((v, t, t2) => _IngredientCopyWithImpl(v, t, t2));
}

abstract class IngredientCopyWith<$R, $In extends Ingredient, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? iconURL, int? id, String? name});
  IngredientCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IngredientCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Ingredient, $Out>
    implements IngredientCopyWith<$R, Ingredient, $Out> {
  _IngredientCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Ingredient> $mapper =
      IngredientMapper.ensureInitialized();
  @override
  $R call({String? iconURL, int? id, String? name}) =>
      $apply(FieldCopyWithData({
        if (iconURL != null) #iconURL: iconURL,
        if (id != null) #id: id,
        if (name != null) #name: name
      }));
  @override
  Ingredient $make(CopyWithData data) => Ingredient.fromAllData(
      iconURL: data.get(#iconURL, or: $value.iconURL),
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name));

  @override
  IngredientCopyWith<$R2, Ingredient, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IngredientCopyWithImpl($value, $cast, t);
}
