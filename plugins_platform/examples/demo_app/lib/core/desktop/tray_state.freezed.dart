// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tray_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TrayState {
  /// 是否已初始化
  bool get isInitialized => throw _privateConstructorUsedError;

  /// 当前未读数量
  /// Requirements: 5.1
  int get unreadCount => throw _privateConstructorUsedError;

  /// 是否正在同步
  /// Requirements: 5.2
  bool get isSyncing => throw _privateConstructorUsedError;

  /// 最后同步时间
  /// Requirements: 5.3
  DateTime? get lastSyncTime => throw _privateConstructorUsedError;

  /// 错误信息
  /// Requirements: 5.4
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of TrayState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrayStateCopyWith<TrayState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrayStateCopyWith<$Res> {
  factory $TrayStateCopyWith(TrayState value, $Res Function(TrayState) then) =
      _$TrayStateCopyWithImpl<$Res, TrayState>;
  @useResult
  $Res call({
    bool isInitialized,
    int unreadCount,
    bool isSyncing,
    DateTime? lastSyncTime,
    String? errorMessage,
  });
}

/// @nodoc
class _$TrayStateCopyWithImpl<$Res, $Val extends TrayState>
    implements $TrayStateCopyWith<$Res> {
  _$TrayStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrayState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitialized = null,
    Object? unreadCount = null,
    Object? isSyncing = null,
    Object? lastSyncTime = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isInitialized: null == isInitialized
                ? _value.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                      as bool,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isSyncing: null == isSyncing
                ? _value.isSyncing
                : isSyncing // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastSyncTime: freezed == lastSyncTime
                ? _value.lastSyncTime
                : lastSyncTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrayStateImplCopyWith<$Res>
    implements $TrayStateCopyWith<$Res> {
  factory _$$TrayStateImplCopyWith(
    _$TrayStateImpl value,
    $Res Function(_$TrayStateImpl) then,
  ) = __$$TrayStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isInitialized,
    int unreadCount,
    bool isSyncing,
    DateTime? lastSyncTime,
    String? errorMessage,
  });
}

/// @nodoc
class __$$TrayStateImplCopyWithImpl<$Res>
    extends _$TrayStateCopyWithImpl<$Res, _$TrayStateImpl>
    implements _$$TrayStateImplCopyWith<$Res> {
  __$$TrayStateImplCopyWithImpl(
    _$TrayStateImpl _value,
    $Res Function(_$TrayStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrayState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitialized = null,
    Object? unreadCount = null,
    Object? isSyncing = null,
    Object? lastSyncTime = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$TrayStateImpl(
        isInitialized: null == isInitialized
            ? _value.isInitialized
            : isInitialized // ignore: cast_nullable_to_non_nullable
                  as bool,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isSyncing: null == isSyncing
            ? _value.isSyncing
            : isSyncing // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastSyncTime: freezed == lastSyncTime
            ? _value.lastSyncTime
            : lastSyncTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$TrayStateImpl extends _TrayState {
  const _$TrayStateImpl({
    this.isInitialized = false,
    this.unreadCount = 0,
    this.isSyncing = false,
    this.lastSyncTime,
    this.errorMessage,
  }) : super._();

  /// 是否已初始化
  @override
  @JsonKey()
  final bool isInitialized;

  /// 当前未读数量
  /// Requirements: 5.1
  @override
  @JsonKey()
  final int unreadCount;

  /// 是否正在同步
  /// Requirements: 5.2
  @override
  @JsonKey()
  final bool isSyncing;

  /// 最后同步时间
  /// Requirements: 5.3
  @override
  final DateTime? lastSyncTime;

  /// 错误信息
  /// Requirements: 5.4
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'TrayState(isInitialized: $isInitialized, unreadCount: $unreadCount, isSyncing: $isSyncing, lastSyncTime: $lastSyncTime, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrayStateImpl &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.isSyncing, isSyncing) ||
                other.isSyncing == isSyncing) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isInitialized,
    unreadCount,
    isSyncing,
    lastSyncTime,
    errorMessage,
  );

  /// Create a copy of TrayState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrayStateImplCopyWith<_$TrayStateImpl> get copyWith =>
      __$$TrayStateImplCopyWithImpl<_$TrayStateImpl>(this, _$identity);
}

abstract class _TrayState extends TrayState {
  const factory _TrayState({
    final bool isInitialized,
    final int unreadCount,
    final bool isSyncing,
    final DateTime? lastSyncTime,
    final String? errorMessage,
  }) = _$TrayStateImpl;
  const _TrayState._() : super._();

  /// 是否已初始化
  @override
  bool get isInitialized;

  /// 当前未读数量
  /// Requirements: 5.1
  @override
  int get unreadCount;

  /// 是否正在同步
  /// Requirements: 5.2
  @override
  bool get isSyncing;

  /// 最后同步时间
  /// Requirements: 5.3
  @override
  DateTime? get lastSyncTime;

  /// 错误信息
  /// Requirements: 5.4
  @override
  String? get errorMessage;

  /// Create a copy of TrayState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrayStateImplCopyWith<_$TrayStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
