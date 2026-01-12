// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'counter_visibility_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CounterVisibilityState {
  bool get isPoisonVisible => throw _privateConstructorUsedError;
  bool get isSpeedVisible => throw _privateConstructorUsedError;

  /// Create a copy of CounterVisibilityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CounterVisibilityStateCopyWith<CounterVisibilityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounterVisibilityStateCopyWith<$Res> {
  factory $CounterVisibilityStateCopyWith(CounterVisibilityState value,
          $Res Function(CounterVisibilityState) then) =
      _$CounterVisibilityStateCopyWithImpl<$Res, CounterVisibilityState>;
  @useResult
  $Res call({bool isPoisonVisible, bool isSpeedVisible});
}

/// @nodoc
class _$CounterVisibilityStateCopyWithImpl<$Res,
        $Val extends CounterVisibilityState>
    implements $CounterVisibilityStateCopyWith<$Res> {
  _$CounterVisibilityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CounterVisibilityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPoisonVisible = null,
    Object? isSpeedVisible = null,
  }) {
    return _then(_value.copyWith(
      isPoisonVisible: null == isPoisonVisible
          ? _value.isPoisonVisible
          : isPoisonVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isSpeedVisible: null == isSpeedVisible
          ? _value.isSpeedVisible
          : isSpeedVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CounterVisibilityStateImplCopyWith<$Res>
    implements $CounterVisibilityStateCopyWith<$Res> {
  factory _$$CounterVisibilityStateImplCopyWith(
          _$CounterVisibilityStateImpl value,
          $Res Function(_$CounterVisibilityStateImpl) then) =
      __$$CounterVisibilityStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isPoisonVisible, bool isSpeedVisible});
}

/// @nodoc
class __$$CounterVisibilityStateImplCopyWithImpl<$Res>
    extends _$CounterVisibilityStateCopyWithImpl<$Res,
        _$CounterVisibilityStateImpl>
    implements _$$CounterVisibilityStateImplCopyWith<$Res> {
  __$$CounterVisibilityStateImplCopyWithImpl(
      _$CounterVisibilityStateImpl _value,
      $Res Function(_$CounterVisibilityStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CounterVisibilityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPoisonVisible = null,
    Object? isSpeedVisible = null,
  }) {
    return _then(_$CounterVisibilityStateImpl(
      isPoisonVisible: null == isPoisonVisible
          ? _value.isPoisonVisible
          : isPoisonVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isSpeedVisible: null == isSpeedVisible
          ? _value.isSpeedVisible
          : isSpeedVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CounterVisibilityStateImpl implements _CounterVisibilityState {
  const _$CounterVisibilityStateImpl(
      {this.isPoisonVisible = false, this.isSpeedVisible = false});

  @override
  @JsonKey()
  final bool isPoisonVisible;
  @override
  @JsonKey()
  final bool isSpeedVisible;

  @override
  String toString() {
    return 'CounterVisibilityState(isPoisonVisible: $isPoisonVisible, isSpeedVisible: $isSpeedVisible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CounterVisibilityStateImpl &&
            (identical(other.isPoisonVisible, isPoisonVisible) ||
                other.isPoisonVisible == isPoisonVisible) &&
            (identical(other.isSpeedVisible, isSpeedVisible) ||
                other.isSpeedVisible == isSpeedVisible));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isPoisonVisible, isSpeedVisible);

  /// Create a copy of CounterVisibilityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CounterVisibilityStateImplCopyWith<_$CounterVisibilityStateImpl>
      get copyWith => __$$CounterVisibilityStateImplCopyWithImpl<
          _$CounterVisibilityStateImpl>(this, _$identity);
}

abstract class _CounterVisibilityState implements CounterVisibilityState {
  const factory _CounterVisibilityState(
      {final bool isPoisonVisible,
      final bool isSpeedVisible}) = _$CounterVisibilityStateImpl;

  @override
  bool get isPoisonVisible;
  @override
  bool get isSpeedVisible;

  /// Create a copy of CounterVisibilityState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CounterVisibilityStateImplCopyWith<_$CounterVisibilityStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
