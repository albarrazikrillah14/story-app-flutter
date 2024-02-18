// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoryDetail _$StoryDetailFromJson(Map<String, dynamic> json) {
  return _StoryDetail.fromJson(json);
}

/// @nodoc
mixin _$StoryDetail {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Story get story => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryDetailCopyWith<StoryDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryDetailCopyWith<$Res> {
  factory $StoryDetailCopyWith(
          StoryDetail value, $Res Function(StoryDetail) then) =
      _$StoryDetailCopyWithImpl<$Res, StoryDetail>;
  @useResult
  $Res call({bool error, String message, Story story});

  $StoryCopyWith<$Res> get story;
}

/// @nodoc
class _$StoryDetailCopyWithImpl<$Res, $Val extends StoryDetail>
    implements $StoryDetailCopyWith<$Res> {
  _$StoryDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? story = null,
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
      story: null == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as Story,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StoryCopyWith<$Res> get story {
    return $StoryCopyWith<$Res>(_value.story, (value) {
      return _then(_value.copyWith(story: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoryDetailImplCopyWith<$Res>
    implements $StoryDetailCopyWith<$Res> {
  factory _$$StoryDetailImplCopyWith(
          _$StoryDetailImpl value, $Res Function(_$StoryDetailImpl) then) =
      __$$StoryDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message, Story story});

  @override
  $StoryCopyWith<$Res> get story;
}

/// @nodoc
class __$$StoryDetailImplCopyWithImpl<$Res>
    extends _$StoryDetailCopyWithImpl<$Res, _$StoryDetailImpl>
    implements _$$StoryDetailImplCopyWith<$Res> {
  __$$StoryDetailImplCopyWithImpl(
      _$StoryDetailImpl _value, $Res Function(_$StoryDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? story = null,
  }) {
    return _then(_$StoryDetailImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      story: null == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as Story,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryDetailImpl implements _StoryDetail {
  _$StoryDetailImpl(
      {required this.error, required this.message, required this.story});

  factory _$StoryDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryDetailImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  @override
  final Story story;

  @override
  String toString() {
    return 'StoryDetail(error: $error, message: $message, story: $story)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryDetailImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.story, story) || other.story == story));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message, story);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryDetailImplCopyWith<_$StoryDetailImpl> get copyWith =>
      __$$StoryDetailImplCopyWithImpl<_$StoryDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryDetailImplToJson(
      this,
    );
  }
}

abstract class _StoryDetail implements StoryDetail {
  factory _StoryDetail(
      {required final bool error,
      required final String message,
      required final Story story}) = _$StoryDetailImpl;

  factory _StoryDetail.fromJson(Map<String, dynamic> json) =
      _$StoryDetailImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  Story get story;
  @override
  @JsonKey(ignore: true)
  _$$StoryDetailImplCopyWith<_$StoryDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
