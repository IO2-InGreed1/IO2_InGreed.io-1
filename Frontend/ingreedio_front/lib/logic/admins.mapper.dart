// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'admins.dart';

class ModeratorMapper extends ClassMapperBase<Moderator> {
  ModeratorMapper._();

  static ModeratorMapper? _instance;
  static ModeratorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ModeratorMapper._());
      OpinionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Moderator';

  static int _$moderatorNumber(Moderator v) => v.moderatorNumber;
  static const Field<Moderator, int> _f$moderatorNumber =
      Field('moderatorNumber', _$moderatorNumber);
  static List<Opinion> _$editedOpinionList(Moderator v) => v.editedOpinionList;
  static const Field<Moderator, List<Opinion>> _f$editedOpinionList =
      Field('editedOpinionList', _$editedOpinionList);

  @override
  final MappableFields<Moderator> fields = const {
    #moderatorNumber: _f$moderatorNumber,
    #editedOpinionList: _f$editedOpinionList,
  };

  static Moderator _instantiate(DecodingData data) {
    return Moderator.fromAllData(
        moderatorNumber: data.dec(_f$moderatorNumber),
        editedOpinionList: data.dec(_f$editedOpinionList));
  }

  @override
  final Function instantiate = _instantiate;

  static Moderator fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Moderator>(map);
  }

  static Moderator fromJson(String json) {
    return ensureInitialized().decodeJson<Moderator>(json);
  }
}

mixin ModeratorMappable {
  String toJson() {
    return ModeratorMapper.ensureInitialized()
        .encodeJson<Moderator>(this as Moderator);
  }

  Map<String, dynamic> toMap() {
    return ModeratorMapper.ensureInitialized()
        .encodeMap<Moderator>(this as Moderator);
  }

  ModeratorCopyWith<Moderator, Moderator, Moderator> get copyWith =>
      _ModeratorCopyWithImpl(this as Moderator, $identity, $identity);
  @override
  String toString() {
    return ModeratorMapper.ensureInitialized()
        .stringifyValue(this as Moderator);
  }

  @override
  bool operator ==(Object other) {
    return ModeratorMapper.ensureInitialized()
        .equalsValue(this as Moderator, other);
  }

  @override
  int get hashCode {
    return ModeratorMapper.ensureInitialized().hashValue(this as Moderator);
  }
}

extension ModeratorValueCopy<$R, $Out> on ObjectCopyWith<$R, Moderator, $Out> {
  ModeratorCopyWith<$R, Moderator, $Out> get $asModerator =>
      $base.as((v, t, t2) => _ModeratorCopyWithImpl(v, t, t2));
}

abstract class ModeratorCopyWith<$R, $In extends Moderator, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Opinion, OpinionCopyWith<$R, Opinion, Opinion>>
      get editedOpinionList;
  $R call({int? moderatorNumber, List<Opinion>? editedOpinionList});
  ModeratorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ModeratorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Moderator, $Out>
    implements ModeratorCopyWith<$R, Moderator, $Out> {
  _ModeratorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Moderator> $mapper =
      ModeratorMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Opinion, OpinionCopyWith<$R, Opinion, Opinion>>
      get editedOpinionList => ListCopyWith($value.editedOpinionList,
          (v, t) => v.copyWith.$chain(t), (v) => call(editedOpinionList: v));
  @override
  $R call({int? moderatorNumber, List<Opinion>? editedOpinionList}) =>
      $apply(FieldCopyWithData({
        if (moderatorNumber != null) #moderatorNumber: moderatorNumber,
        if (editedOpinionList != null) #editedOpinionList: editedOpinionList
      }));
  @override
  Moderator $make(CopyWithData data) => Moderator.fromAllData(
      moderatorNumber: data.get(#moderatorNumber, or: $value.moderatorNumber),
      editedOpinionList:
          data.get(#editedOpinionList, or: $value.editedOpinionList));

  @override
  ModeratorCopyWith<$R2, Moderator, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ModeratorCopyWithImpl($value, $cast, t);
}

class AdminMapper extends ClassMapperBase<Admin> {
  AdminMapper._();

  static AdminMapper? _instance;
  static AdminMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdminMapper._());
      ControlPanelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Admin';

  static ControlPanel _$controlPanel(Admin v) => v.controlPanel;
  static const Field<Admin, ControlPanel> _f$controlPanel =
      Field('controlPanel', _$controlPanel);

  @override
  final MappableFields<Admin> fields = const {
    #controlPanel: _f$controlPanel,
  };

  static Admin _instantiate(DecodingData data) {
    return Admin.fromAllData(controlPanel: data.dec(_f$controlPanel));
  }

  @override
  final Function instantiate = _instantiate;

  static Admin fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Admin>(map);
  }

  static Admin fromJson(String json) {
    return ensureInitialized().decodeJson<Admin>(json);
  }
}

mixin AdminMappable {
  String toJson() {
    return AdminMapper.ensureInitialized().encodeJson<Admin>(this as Admin);
  }

  Map<String, dynamic> toMap() {
    return AdminMapper.ensureInitialized().encodeMap<Admin>(this as Admin);
  }

  AdminCopyWith<Admin, Admin, Admin> get copyWith =>
      _AdminCopyWithImpl(this as Admin, $identity, $identity);
  @override
  String toString() {
    return AdminMapper.ensureInitialized().stringifyValue(this as Admin);
  }

  @override
  bool operator ==(Object other) {
    return AdminMapper.ensureInitialized().equalsValue(this as Admin, other);
  }

  @override
  int get hashCode {
    return AdminMapper.ensureInitialized().hashValue(this as Admin);
  }
}

extension AdminValueCopy<$R, $Out> on ObjectCopyWith<$R, Admin, $Out> {
  AdminCopyWith<$R, Admin, $Out> get $asAdmin =>
      $base.as((v, t, t2) => _AdminCopyWithImpl(v, t, t2));
}

abstract class AdminCopyWith<$R, $In extends Admin, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ControlPanelCopyWith<$R, ControlPanel, ControlPanel> get controlPanel;
  $R call({ControlPanel? controlPanel});
  AdminCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AdminCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Admin, $Out>
    implements AdminCopyWith<$R, Admin, $Out> {
  _AdminCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Admin> $mapper = AdminMapper.ensureInitialized();
  @override
  ControlPanelCopyWith<$R, ControlPanel, ControlPanel> get controlPanel =>
      $value.controlPanel.copyWith.$chain((v) => call(controlPanel: v));
  @override
  $R call({ControlPanel? controlPanel}) => $apply(FieldCopyWithData(
      {if (controlPanel != null) #controlPanel: controlPanel}));
  @override
  Admin $make(CopyWithData data) => Admin.fromAllData(
      controlPanel: data.get(#controlPanel, or: $value.controlPanel));

  @override
  AdminCopyWith<$R2, Admin, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AdminCopyWithImpl($value, $cast, t);
}

class ControlPanelMapper extends ClassMapperBase<ControlPanel> {
  ControlPanelMapper._();

  static ControlPanelMapper? _instance;
  static ControlPanelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ControlPanelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ControlPanel';

  @override
  final MappableFields<ControlPanel> fields = const {};

  static ControlPanel _instantiate(DecodingData data) {
    return ControlPanel();
  }

  @override
  final Function instantiate = _instantiate;

  static ControlPanel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ControlPanel>(map);
  }

  static ControlPanel fromJson(String json) {
    return ensureInitialized().decodeJson<ControlPanel>(json);
  }
}

mixin ControlPanelMappable {
  String toJson() {
    return ControlPanelMapper.ensureInitialized()
        .encodeJson<ControlPanel>(this as ControlPanel);
  }

  Map<String, dynamic> toMap() {
    return ControlPanelMapper.ensureInitialized()
        .encodeMap<ControlPanel>(this as ControlPanel);
  }

  ControlPanelCopyWith<ControlPanel, ControlPanel, ControlPanel> get copyWith =>
      _ControlPanelCopyWithImpl(this as ControlPanel, $identity, $identity);
  @override
  String toString() {
    return ControlPanelMapper.ensureInitialized()
        .stringifyValue(this as ControlPanel);
  }

  @override
  bool operator ==(Object other) {
    return ControlPanelMapper.ensureInitialized()
        .equalsValue(this as ControlPanel, other);
  }

  @override
  int get hashCode {
    return ControlPanelMapper.ensureInitialized()
        .hashValue(this as ControlPanel);
  }
}

extension ControlPanelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ControlPanel, $Out> {
  ControlPanelCopyWith<$R, ControlPanel, $Out> get $asControlPanel =>
      $base.as((v, t, t2) => _ControlPanelCopyWithImpl(v, t, t2));
}

abstract class ControlPanelCopyWith<$R, $In extends ControlPanel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  ControlPanelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ControlPanelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ControlPanel, $Out>
    implements ControlPanelCopyWith<$R, ControlPanel, $Out> {
  _ControlPanelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ControlPanel> $mapper =
      ControlPanelMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  ControlPanel $make(CopyWithData data) => ControlPanel();

  @override
  ControlPanelCopyWith<$R2, ControlPanel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ControlPanelCopyWithImpl($value, $cast, t);
}
