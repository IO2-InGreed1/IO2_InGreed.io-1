// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'products.dart';

class CategoryMapper extends EnumMapper<Category> {
  CategoryMapper._();

  static CategoryMapper? _instance;
  static CategoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CategoryMapper._());
    }
    return _instance!;
  }

  static Category fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Category decode(dynamic value) {
    switch (value) {
      case 'cosmetics':
        return Category.cosmetics;
      case 'food':
        return Category.food;
      case 'drink':
        return Category.drink;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Category self) {
    switch (self) {
      case Category.cosmetics:
        return 'cosmetics';
      case Category.food:
        return 'food';
      case Category.drink:
        return 'drink';
    }
  }
}

extension CategoryMapperExtension on Category {
  String toValue() {
    CategoryMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Category>(this) as String;
  }
}

class ProductMapper extends ClassMapperBase<Product> {
  ProductMapper._();

  static ProductMapper? _instance;
  static ProductMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductMapper._());
      CategoryMapper.ensureInitialized();
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
  static bool _$isReported(Product v) => v.isReported;
  static const Field<Product, bool> _f$isReported =
      Field('isReported', _$isReported, opt: true, def: false);

  @override
  final MappableFields<Product> fields = const {
    #category: _f$category,
    #description: _f$description,
    #id: _f$id,
    #ingredients: _f$ingredients,
    #name: _f$name,
    #producer: _f$producer,
    #promotionUntil: _f$promotionUntil,
    #isReported: _f$isReported,
  };

  static Product _instantiate(DecodingData data) {
    return Product.fromAllData(
        category: data.dec(_f$category),
        description: data.dec(_f$description),
        id: data.dec(_f$id),
        ingredients: data.dec(_f$ingredients),
        name: data.dec(_f$name),
        producer: data.dec(_f$producer),
        promotionUntil: data.dec(_f$promotionUntil),
        isReported: data.dec(_f$isReported));
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
      DateTime? promotionUntil,
      bool? isReported});
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
          DateTime? promotionUntil,
          bool? isReported}) =>
      $apply(FieldCopyWithData({
        if (category != null) #category: category,
        if (description != null) #description: description,
        if (id != null) #id: id,
        if (ingredients != null) #ingredients: ingredients,
        if (name != null) #name: name,
        if (producer != null) #producer: producer,
        if (promotionUntil != null) #promotionUntil: promotionUntil,
        if (isReported != null) #isReported: isReported
      }));
  @override
  Product $make(CopyWithData data) => Product.fromAllData(
      category: data.get(#category, or: $value.category),
      description: data.get(#description, or: $value.description),
      id: data.get(#id, or: $value.id),
      ingredients: data.get(#ingredients, or: $value.ingredients),
      name: data.get(#name, or: $value.name),
      producer: data.get(#producer, or: $value.producer),
      promotionUntil: data.get(#promotionUntil, or: $value.promotionUntil),
      isReported: data.get(#isReported, or: $value.isReported));

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
      Field('iconURL', _$iconURL, opt: true, def: "");
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

class OpinionMapper extends ClassMapperBase<Opinion> {
  OpinionMapper._();

  static OpinionMapper? _instance;
  static OpinionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OpinionMapper._());
      ClientMapper.ensureInitialized();
      ProductMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Opinion';

  static Client _$author(Opinion v) => v.author;
  static const Field<Opinion, Client> _f$author = Field('author', _$author);
  static int _$id(Opinion v) => v.id;
  static const Field<Opinion, int> _f$id = Field('id', _$id);
  static Product _$product(Opinion v) => v.product;
  static const Field<Opinion, Product> _f$product = Field('product', _$product);
  static double _$score(Opinion v) => v.score;
  static const Field<Opinion, double> _f$score = Field('score', _$score);
  static String _$text(Opinion v) => v.text;
  static const Field<Opinion, String> _f$text = Field('text', _$text);
  static bool _$isReported(Opinion v) => v.isReported;
  static const Field<Opinion, bool> _f$isReported =
      Field('isReported', _$isReported, mode: FieldMode.member);

  @override
  final MappableFields<Opinion> fields = const {
    #author: _f$author,
    #id: _f$id,
    #product: _f$product,
    #score: _f$score,
    #text: _f$text,
    #isReported: _f$isReported,
  };

  static Opinion _instantiate(DecodingData data) {
    return Opinion.fromAllData(
        author: data.dec(_f$author),
        id: data.dec(_f$id),
        product: data.dec(_f$product),
        score: data.dec(_f$score),
        text: data.dec(_f$text));
  }

  @override
  final Function instantiate = _instantiate;

  static Opinion fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Opinion>(map);
  }

  static Opinion fromJson(String json) {
    return ensureInitialized().decodeJson<Opinion>(json);
  }
}

mixin OpinionMappable {
  String toJson() {
    return OpinionMapper.ensureInitialized()
        .encodeJson<Opinion>(this as Opinion);
  }

  Map<String, dynamic> toMap() {
    return OpinionMapper.ensureInitialized()
        .encodeMap<Opinion>(this as Opinion);
  }

  OpinionCopyWith<Opinion, Opinion, Opinion> get copyWith =>
      _OpinionCopyWithImpl(this as Opinion, $identity, $identity);
  @override
  String toString() {
    return OpinionMapper.ensureInitialized().stringifyValue(this as Opinion);
  }

  @override
  bool operator ==(Object other) {
    return OpinionMapper.ensureInitialized()
        .equalsValue(this as Opinion, other);
  }

  @override
  int get hashCode {
    return OpinionMapper.ensureInitialized().hashValue(this as Opinion);
  }
}

extension OpinionValueCopy<$R, $Out> on ObjectCopyWith<$R, Opinion, $Out> {
  OpinionCopyWith<$R, Opinion, $Out> get $asOpinion =>
      $base.as((v, t, t2) => _OpinionCopyWithImpl(v, t, t2));
}

abstract class OpinionCopyWith<$R, $In extends Opinion, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ClientCopyWith<$R, Client, Client> get author;
  ProductCopyWith<$R, Product, Product> get product;
  $R call(
      {Client? author, int? id, Product? product, double? score, String? text});
  OpinionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _OpinionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Opinion, $Out>
    implements OpinionCopyWith<$R, Opinion, $Out> {
  _OpinionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Opinion> $mapper =
      OpinionMapper.ensureInitialized();
  @override
  ClientCopyWith<$R, Client, Client> get author =>
      $value.author.copyWith.$chain((v) => call(author: v));
  @override
  ProductCopyWith<$R, Product, Product> get product =>
      $value.product.copyWith.$chain((v) => call(product: v));
  @override
  $R call(
          {Client? author,
          int? id,
          Product? product,
          double? score,
          String? text}) =>
      $apply(FieldCopyWithData({
        if (author != null) #author: author,
        if (id != null) #id: id,
        if (product != null) #product: product,
        if (score != null) #score: score,
        if (text != null) #text: text
      }));
  @override
  Opinion $make(CopyWithData data) => Opinion.fromAllData(
      author: data.get(#author, or: $value.author),
      id: data.get(#id, or: $value.id),
      product: data.get(#product, or: $value.product),
      score: data.get(#score, or: $value.score),
      text: data.get(#text, or: $value.text));

  @override
  OpinionCopyWith<$R2, Opinion, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _OpinionCopyWithImpl($value, $cast, t);
}
