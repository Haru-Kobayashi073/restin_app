// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marker_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MarkerData _$MarkerDataFromJson(Map<String, dynamic> json) {
  return _MarkerData.fromJson(json);
}

/// @nodoc
mixin _$MarkerData {
  String get creatorId => throw _privateConstructorUsedError;
  String get docId => throw _privateConstructorUsedError;
  String get markerId => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MarkerDataCopyWith<MarkerData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkerDataCopyWith<$Res> {
  factory $MarkerDataCopyWith(
          MarkerData value, $Res Function(MarkerData) then) =
      _$MarkerDataCopyWithImpl<$Res, MarkerData>;
  @useResult
  $Res call(
      {String creatorId,
      String docId,
      String markerId,
      dynamic createdAt,
      String title,
      String? description,
      double latitude,
      double longitude});
}

/// @nodoc
class _$MarkerDataCopyWithImpl<$Res, $Val extends MarkerData>
    implements $MarkerDataCopyWith<$Res> {
  _$MarkerDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creatorId = null,
    Object? docId = null,
    Object? markerId = null,
    Object? createdAt = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      markerId: null == markerId
          ? _value.markerId
          : markerId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MarkerDataCopyWith<$Res>
    implements $MarkerDataCopyWith<$Res> {
  factory _$$_MarkerDataCopyWith(
          _$_MarkerData value, $Res Function(_$_MarkerData) then) =
      __$$_MarkerDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String creatorId,
      String docId,
      String markerId,
      dynamic createdAt,
      String title,
      String? description,
      double latitude,
      double longitude});
}

/// @nodoc
class __$$_MarkerDataCopyWithImpl<$Res>
    extends _$MarkerDataCopyWithImpl<$Res, _$_MarkerData>
    implements _$$_MarkerDataCopyWith<$Res> {
  __$$_MarkerDataCopyWithImpl(
      _$_MarkerData _value, $Res Function(_$_MarkerData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creatorId = null,
    Object? docId = null,
    Object? markerId = null,
    Object? createdAt = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$_MarkerData(
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      markerId: null == markerId
          ? _value.markerId
          : markerId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MarkerData implements _MarkerData {
  const _$_MarkerData(
      {required this.creatorId,
      required this.docId,
      required this.markerId,
      required this.createdAt,
      required this.title,
      this.description,
      required this.latitude,
      required this.longitude});

  factory _$_MarkerData.fromJson(Map<String, dynamic> json) =>
      _$$_MarkerDataFromJson(json);

  @override
  final String creatorId;
  @override
  final String docId;
  @override
  final String markerId;
  @override
  final dynamic createdAt;
  @override
  final String title;
  @override
  final String? description;
  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'MarkerData(creatorId: $creatorId, docId: $docId, markerId: $markerId, createdAt: $createdAt, title: $title, description: $description, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MarkerData &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.docId, docId) || other.docId == docId) &&
            (identical(other.markerId, markerId) ||
                other.markerId == markerId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      creatorId,
      docId,
      markerId,
      const DeepCollectionEquality().hash(createdAt),
      title,
      description,
      latitude,
      longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MarkerDataCopyWith<_$_MarkerData> get copyWith =>
      __$$_MarkerDataCopyWithImpl<_$_MarkerData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MarkerDataToJson(
      this,
    );
  }
}

abstract class _MarkerData implements MarkerData {
  const factory _MarkerData(
      {required final String creatorId,
      required final String docId,
      required final String markerId,
      required final dynamic createdAt,
      required final String title,
      final String? description,
      required final double latitude,
      required final double longitude}) = _$_MarkerData;

  factory _MarkerData.fromJson(Map<String, dynamic> json) =
      _$_MarkerData.fromJson;

  @override
  String get creatorId;
  @override
  String get docId;
  @override
  String get markerId;
  @override
  dynamic get createdAt;
  @override
  String get title;
  @override
  String? get description;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(ignore: true)
  _$$_MarkerDataCopyWith<_$_MarkerData> get copyWith =>
      throw _privateConstructorUsedError;
}
