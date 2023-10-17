// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return _UserData.fromJson(json);
}

/// @nodoc
mixin _$UserData {
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  List<String>? get bookMarkMarkerIds => throw _privateConstructorUsedError;
  int get markersCounts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataCopyWith<UserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) then) =
      _$UserDataCopyWithImpl<$Res, UserData>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String? userName,
      String? imageUrl,
      dynamic createdAt,
      List<String>? bookMarkMarkerIds,
      int markersCounts});
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res, $Val extends UserData>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? userName = freezed,
    Object? imageUrl = freezed,
    Object? createdAt = freezed,
    Object? bookMarkMarkerIds = freezed,
    Object? markersCounts = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      bookMarkMarkerIds: freezed == bookMarkMarkerIds
          ? _value.bookMarkMarkerIds
          : bookMarkMarkerIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      markersCounts: null == markersCounts
          ? _value.markersCounts
          : markersCounts // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserDataCopyWith<$Res> implements $UserDataCopyWith<$Res> {
  factory _$$_UserDataCopyWith(
          _$_UserData value, $Res Function(_$_UserData) then) =
      __$$_UserDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String? userName,
      String? imageUrl,
      dynamic createdAt,
      List<String>? bookMarkMarkerIds,
      int markersCounts});
}

/// @nodoc
class __$$_UserDataCopyWithImpl<$Res>
    extends _$UserDataCopyWithImpl<$Res, _$_UserData>
    implements _$$_UserDataCopyWith<$Res> {
  __$$_UserDataCopyWithImpl(
      _$_UserData _value, $Res Function(_$_UserData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? userName = freezed,
    Object? imageUrl = freezed,
    Object? createdAt = freezed,
    Object? bookMarkMarkerIds = freezed,
    Object? markersCounts = null,
  }) {
    return _then(_$_UserData(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      bookMarkMarkerIds: freezed == bookMarkMarkerIds
          ? _value._bookMarkMarkerIds
          : bookMarkMarkerIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      markersCounts: null == markersCounts
          ? _value.markersCounts
          : markersCounts // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserData implements _UserData {
  const _$_UserData(
      {required this.uid,
      required this.email,
      this.userName,
      this.imageUrl,
      required this.createdAt,
      final List<String>? bookMarkMarkerIds,
      required this.markersCounts})
      : _bookMarkMarkerIds = bookMarkMarkerIds;

  factory _$_UserData.fromJson(Map<String, dynamic> json) =>
      _$$_UserDataFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String? userName;
  @override
  final String? imageUrl;
  @override
  final dynamic createdAt;
  final List<String>? _bookMarkMarkerIds;
  @override
  List<String>? get bookMarkMarkerIds {
    final value = _bookMarkMarkerIds;
    if (value == null) return null;
    if (_bookMarkMarkerIds is EqualUnmodifiableListView)
      return _bookMarkMarkerIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int markersCounts;

  @override
  String toString() {
    return 'UserData(uid: $uid, email: $email, userName: $userName, imageUrl: $imageUrl, createdAt: $createdAt, bookMarkMarkerIds: $bookMarkMarkerIds, markersCounts: $markersCounts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserData &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality()
                .equals(other._bookMarkMarkerIds, _bookMarkMarkerIds) &&
            (identical(other.markersCounts, markersCounts) ||
                other.markersCounts == markersCounts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      userName,
      imageUrl,
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(_bookMarkMarkerIds),
      markersCounts);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserDataCopyWith<_$_UserData> get copyWith =>
      __$$_UserDataCopyWithImpl<_$_UserData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserDataToJson(
      this,
    );
  }
}

abstract class _UserData implements UserData {
  const factory _UserData(
      {required final String uid,
      required final String email,
      final String? userName,
      final String? imageUrl,
      required final dynamic createdAt,
      final List<String>? bookMarkMarkerIds,
      required final int markersCounts}) = _$_UserData;

  factory _UserData.fromJson(Map<String, dynamic> json) = _$_UserData.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  String? get userName;
  @override
  String? get imageUrl;
  @override
  dynamic get createdAt;
  @override
  List<String>? get bookMarkMarkerIds;
  @override
  int get markersCounts;
  @override
  @JsonKey(ignore: true)
  _$$_UserDataCopyWith<_$_UserData> get copyWith =>
      throw _privateConstructorUsedError;
}
