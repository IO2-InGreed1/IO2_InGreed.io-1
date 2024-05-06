// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'session_data.dart';

class SessionDataMapper extends ClassMapperBase<SessionData> {
  SessionDataMapper._();

  static SessionDataMapper? _instance;
  static SessionDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SessionDataMapper._());
      ClientMapper.ensureInitialized();
      ProducerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SessionData';

  static String _$userToken(SessionData v) => v.userToken;
  static const Field<SessionData, String> _f$userToken =
      Field('userToken', _$userToken);
  static Client? _$currentClient(SessionData v) => v.currentClient;
  static const Field<SessionData, Client> _f$currentClient =
      Field('currentClient', _$currentClient);
  static String _$navigatorPath(SessionData v) => v.navigatorPath;
  static const Field<SessionData, String> _f$navigatorPath =
      Field('navigatorPath', _$navigatorPath);
  static Producer? _$currentProducer(SessionData v) => v.currentProducer;
  static const Field<SessionData, Producer> _f$currentProducer =
      Field('currentProducer', _$currentProducer);
  static Admin? _$currentAdmin(SessionData v) => v.currentAdmin;
  static const Field<SessionData, Admin> _f$currentAdmin =
      Field('currentAdmin', _$currentAdmin);
  static Moderator? _$currentModerator(SessionData v) => v.currentModerator;
  static const Field<SessionData, Moderator> _f$currentModerator =
      Field('currentModerator', _$currentModerator);
  static Database _$database(SessionData v) => v.database;
  static const Field<SessionData, Database> _f$database =
      Field('database', _$database, mode: FieldMode.member);

  @override
  final MappableFields<SessionData> fields = const {
    #userToken: _f$userToken,
    #currentClient: _f$currentClient,
    #navigatorPath: _f$navigatorPath,
    #currentProducer: _f$currentProducer,
    #currentAdmin: _f$currentAdmin,
    #currentModerator: _f$currentModerator,
    #database: _f$database,
  };

  static SessionData _instantiate(DecodingData data) {
    return SessionData.fromAllData(
        userToken: data.dec(_f$userToken),
        currentClient: data.dec(_f$currentClient),
        navigatorPath: data.dec(_f$navigatorPath),
        currentProducer: data.dec(_f$currentProducer),
        currentAdmin: data.dec(_f$currentAdmin),
        currentModerator: data.dec(_f$currentModerator));
  }

  @override
  final Function instantiate = _instantiate;

  static SessionData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SessionData>(map);
  }

  static SessionData fromJson(String json) {
    return ensureInitialized().decodeJson<SessionData>(json);
  }
}

mixin SessionDataMappable {
  String toJson() {
    return SessionDataMapper.ensureInitialized()
        .encodeJson<SessionData>(this as SessionData);
  }

  Map<String, dynamic> toMap() {
    return SessionDataMapper.ensureInitialized()
        .encodeMap<SessionData>(this as SessionData);
  }

  SessionDataCopyWith<SessionData, SessionData, SessionData> get copyWith =>
      _SessionDataCopyWithImpl(this as SessionData, $identity, $identity);
  @override
  String toString() {
    return SessionDataMapper.ensureInitialized()
        .stringifyValue(this as SessionData);
  }

  @override
  bool operator ==(Object other) {
    return SessionDataMapper.ensureInitialized()
        .equalsValue(this as SessionData, other);
  }

  @override
  int get hashCode {
    return SessionDataMapper.ensureInitialized().hashValue(this as SessionData);
  }
}

extension SessionDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SessionData, $Out> {
  SessionDataCopyWith<$R, SessionData, $Out> get $asSessionData =>
      $base.as((v, t, t2) => _SessionDataCopyWithImpl(v, t, t2));
}

abstract class SessionDataCopyWith<$R, $In extends SessionData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ClientCopyWith<$R, Client, Client>? get currentClient;
  ProducerCopyWith<$R, Producer, Producer>? get currentProducer;
  $R call(
      {String? userToken,
      Client? currentClient,
      String? navigatorPath,
      Producer? currentProducer,
      Admin? currentAdmin,
      Moderator? currentModerator});
  SessionDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SessionDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SessionData, $Out>
    implements SessionDataCopyWith<$R, SessionData, $Out> {
  _SessionDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SessionData> $mapper =
      SessionDataMapper.ensureInitialized();
  @override
  ClientCopyWith<$R, Client, Client>? get currentClient =>
      $value.currentClient?.copyWith.$chain((v) => call(currentClient: v));
  @override
  ProducerCopyWith<$R, Producer, Producer>? get currentProducer =>
      $value.currentProducer?.copyWith.$chain((v) => call(currentProducer: v));
  @override
  $R call(
          {String? userToken,
          Object? currentClient = $none,
          String? navigatorPath,
          Object? currentProducer = $none,
          Object? currentAdmin = $none,
          Object? currentModerator = $none}) =>
      $apply(FieldCopyWithData({
        if (userToken != null) #userToken: userToken,
        if (currentClient != $none) #currentClient: currentClient,
        if (navigatorPath != null) #navigatorPath: navigatorPath,
        if (currentProducer != $none) #currentProducer: currentProducer,
        if (currentAdmin != $none) #currentAdmin: currentAdmin,
        if (currentModerator != $none) #currentModerator: currentModerator
      }));
  @override
  SessionData $make(CopyWithData data) => SessionData.fromAllData(
      userToken: data.get(#userToken, or: $value.userToken),
      currentClient: data.get(#currentClient, or: $value.currentClient),
      navigatorPath: data.get(#navigatorPath, or: $value.navigatorPath),
      currentProducer: data.get(#currentProducer, or: $value.currentProducer),
      currentAdmin: data.get(#currentAdmin, or: $value.currentAdmin),
      currentModerator:
          data.get(#currentModerator, or: $value.currentModerator));

  @override
  SessionDataCopyWith<$R2, SessionData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SessionDataCopyWithImpl($value, $cast, t);
}
