// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_add_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddNewStoryResponse _$AddNewStoryResponseFromJson(Map<String, dynamic> json) {
  return _AddNewStoryResponse.fromJson(json);
}

/// @nodoc
mixin _$AddNewStoryResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddNewStoryResponseCopyWith<AddNewStoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddNewStoryResponseCopyWith<$Res> {
  factory $AddNewStoryResponseCopyWith(
          AddNewStoryResponse value, $Res Function(AddNewStoryResponse) then) =
      _$AddNewStoryResponseCopyWithImpl<$Res, AddNewStoryResponse>;
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class _$AddNewStoryResponseCopyWithImpl<$Res, $Val extends AddNewStoryResponse>
    implements $AddNewStoryResponseCopyWith<$Res> {
  _$AddNewStoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddNewStoryResponseImplCopyWith<$Res>
    implements $AddNewStoryResponseCopyWith<$Res> {
  factory _$$AddNewStoryResponseImplCopyWith(_$AddNewStoryResponseImpl value,
          $Res Function(_$AddNewStoryResponseImpl) then) =
      __$$AddNewStoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class __$$AddNewStoryResponseImplCopyWithImpl<$Res>
    extends _$AddNewStoryResponseCopyWithImpl<$Res, _$AddNewStoryResponseImpl>
    implements _$$AddNewStoryResponseImplCopyWith<$Res> {
  __$$AddNewStoryResponseImplCopyWithImpl(_$AddNewStoryResponseImpl _value,
      $Res Function(_$AddNewStoryResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_$AddNewStoryResponseImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddNewStoryResponseImpl implements _AddNewStoryResponse {
  const _$AddNewStoryResponseImpl({required this.error, required this.message});

  factory _$AddNewStoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddNewStoryResponseImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;

  @override
  String toString() {
    return 'AddNewStoryResponse(error: $error, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddNewStoryResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddNewStoryResponseImplCopyWith<_$AddNewStoryResponseImpl> get copyWith =>
      __$$AddNewStoryResponseImplCopyWithImpl<_$AddNewStoryResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddNewStoryResponseImplToJson(
      this,
    );
  }
}

abstract class _AddNewStoryResponse implements AddNewStoryResponse {
  const factory _AddNewStoryResponse(
      {required final bool error,
      required final String message}) = _$AddNewStoryResponseImpl;

  factory _AddNewStoryResponse.fromJson(Map<String, dynamic> json) =
      _$AddNewStoryResponseImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$AddNewStoryResponseImplCopyWith<_$AddNewStoryResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
