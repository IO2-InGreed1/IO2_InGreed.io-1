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
      UserMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SessionData';

  static String _$userToken(SessionData v) => v.userToken;
  static const Field<SessionData, String> _f$userToken =
      Field('userToken', _$userToken);
  static User? _$currentUser(SessionData v) => v.currentUser;
  static const Field<SessionData, User> _f$currentUser =
      Field('currentUser', _$currentUser);
  static bool _$registerScreen(SessionData v) => v.registerScreen;
  static const Field<SessionData, bool> _f$registerScreen =
      Field('registerScreen', _$registerScreen, mode: FieldMode.member);

  @override
  final MappableFields<SessionData> fields = const {
    #userToken: _f$userToken,
    #currentUser: _f$currentUser,
    #registerScreen: _f$registerScreen,
  };

  static SessionData _instantiate(DecodingData data) {
    return SessionData.fromAllData(
        userToken: data.dec(_f$userToken),
        currentUser: data.dec(_f$currentUser));
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
  UserCopyWith<$R, User, User>? get currentUser;
  $R call({String? userToken, User? currentUser});
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
  UserCopyWith<$R, User, User>? get currentUser =>
      $value.currentUser?.copyWith.$chain((v) => call(currentUser: v));
  @override
  $R call({String? userToken, Object? currentUser = $none}) =>
      $apply(FieldCopyWithData({
        if (userToken != null) #userToken: userToken,
        if (currentUser != $none) #currentUser: currentUser
      }));
  @override
  SessionData $make(CopyWithData data) => SessionData.fromAllData(
      userToken: data.get(#userToken, or: $value.userToken),
      currentUser: data.get(#currentUser, or: $value.currentUser));

  @override
  SessionDataCopyWith<$R2, SessionData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SessionDataCopyWithImpl($value, $cast, t);
}
