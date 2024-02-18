// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_upload_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoryUploadResponse _$StoryUploadResponseFromJson(Map<String, dynamic> json) {
  return _StoryUploadResponse.fromJson(json);
}

/// @nodoc
mixin _$StoryUploadResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryUploadResponseCopyWith<StoryUploadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryUploadResponseCopyWith<$Res> {
  factory $StoryUploadResponseCopyWith(
          StoryUploadResponse value, $Res Function(StoryUploadResponse) then) =
      _$StoryUploadResponseCopyWithImpl<$Res, StoryUploadResponse>;
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class _$StoryUploadResponseCopyWithImpl<$Res, $Val extends StoryUploadResponse>
    implements $StoryUploadResponseCopyWith<$Res> {
  _$StoryUploadResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$StoryUploadResponseImplCopyWith<$Res>
    implements $StoryUploadResponseCopyWith<$Res> {
  factory _$$StoryUploadResponseImplCopyWith(_$StoryUploadResponseImpl value,
          $Res Function(_$StoryUploadResponseImpl) then) =
      __$$StoryUploadResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class __$$StoryUploadResponseImplCopyWithImpl<$Res>
    extends _$StoryUploadResponseCopyWithImpl<$Res, _$StoryUploadResponseImpl>
    implements _$$StoryUploadResponseImplCopyWith<$Res> {
  __$$StoryUploadResponseImplCopyWithImpl(_$StoryUploadResponseImpl _value,
      $Res Function(_$StoryUploadResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_$StoryUploadResponseImpl(
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
class _$StoryUploadResponseImpl implements _StoryUploadResponse {
  _$StoryUploadResponseImpl({required this.error, required this.message});

  factory _$StoryUploadResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryUploadResponseImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;

  @override
  String toString() {
    return 'StoryUploadResponse(error: $error, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryUploadResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryUploadResponseImplCopyWith<_$StoryUploadResponseImpl> get copyWith =>
      __$$StoryUploadResponseImplCopyWithImpl<_$StoryUploadResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryUploadResponseImplToJson(
      this,
    );
  }
}

abstract class _StoryUploadResponse implements StoryUploadResponse {
  factory _StoryUploadResponse(
      {required final bool error,
      required final String message}) = _$StoryUploadResponseImpl;

  factory _StoryUploadResponse.fromJson(Map<String, dynamic> json) =
      _$StoryUploadResponseImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$StoryUploadResponseImplCopyWith<_$StoryUploadResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
