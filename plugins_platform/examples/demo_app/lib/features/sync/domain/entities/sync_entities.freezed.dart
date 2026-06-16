// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SyncStatus _$SyncStatusFromJson(Map<String, dynamic> json) {
  return _SyncStatus.fromJson(json);
}

/// @nodoc
mixin _$SyncStatus {
  SyncState get state => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DateTime? get lastSyncTime => throw _privateConstructorUsedError;
  SyncType? get currentSyncType => throw _privateConstructorUsedError;

  /// Serializes this SyncStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncStatusCopyWith<SyncStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStatusCopyWith<$Res> {
  factory $SyncStatusCopyWith(
    SyncStatus value,
    $Res Function(SyncStatus) then,
  ) = _$SyncStatusCopyWithImpl<$Res, SyncStatus>;
  @useResult
  $Res call({
    SyncState state,
    double progress,
    String? message,
    DateTime? lastSyncTime,
    SyncType? currentSyncType,
  });
}

/// @nodoc
class _$SyncStatusCopyWithImpl<$Res, $Val extends SyncStatus>
    implements $SyncStatusCopyWith<$Res> {
  _$SyncStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? progress = null,
    Object? message = freezed,
    Object? lastSyncTime = freezed,
    Object? currentSyncType = freezed,
  }) {
    return _then(
      _value.copyWith(
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as SyncState,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastSyncTime: freezed == lastSyncTime
                ? _value.lastSyncTime
                : lastSyncTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            currentSyncType: freezed == currentSyncType
                ? _value.currentSyncType
                : currentSyncType // ignore: cast_nullable_to_non_nullable
                      as SyncType?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SyncStatusImplCopyWith<$Res>
    implements $SyncStatusCopyWith<$Res> {
  factory _$$SyncStatusImplCopyWith(
    _$SyncStatusImpl value,
    $Res Function(_$SyncStatusImpl) then,
  ) = __$$SyncStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    SyncState state,
    double progress,
    String? message,
    DateTime? lastSyncTime,
    SyncType? currentSyncType,
  });
}

/// @nodoc
class __$$SyncStatusImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$SyncStatusImpl>
    implements _$$SyncStatusImplCopyWith<$Res> {
  __$$SyncStatusImplCopyWithImpl(
    _$SyncStatusImpl _value,
    $Res Function(_$SyncStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? progress = null,
    Object? message = freezed,
    Object? lastSyncTime = freezed,
    Object? currentSyncType = freezed,
  }) {
    return _then(
      _$SyncStatusImpl(
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as SyncState,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastSyncTime: freezed == lastSyncTime
            ? _value.lastSyncTime
            : lastSyncTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        currentSyncType: freezed == currentSyncType
            ? _value.currentSyncType
            : currentSyncType // ignore: cast_nullable_to_non_nullable
                  as SyncType?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncStatusImpl extends _SyncStatus {
  const _$SyncStatusImpl({
    required this.state,
    this.progress = 0.0,
    this.message,
    this.lastSyncTime,
    this.currentSyncType,
  }) : super._();

  factory _$SyncStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncStatusImplFromJson(json);

  @override
  final SyncState state;
  @override
  @JsonKey()
  final double progress;
  @override
  final String? message;
  @override
  final DateTime? lastSyncTime;
  @override
  final SyncType? currentSyncType;

  @override
  String toString() {
    return 'SyncStatus(state: $state, progress: $progress, message: $message, lastSyncTime: $lastSyncTime, currentSyncType: $currentSyncType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStatusImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.currentSyncType, currentSyncType) ||
                other.currentSyncType == currentSyncType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    state,
    progress,
    message,
    lastSyncTime,
    currentSyncType,
  );

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStatusImplCopyWith<_$SyncStatusImpl> get copyWith =>
      __$$SyncStatusImplCopyWithImpl<_$SyncStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncStatusImplToJson(this);
  }
}

abstract class _SyncStatus extends SyncStatus {
  const factory _SyncStatus({
    required final SyncState state,
    final double progress,
    final String? message,
    final DateTime? lastSyncTime,
    final SyncType? currentSyncType,
  }) = _$SyncStatusImpl;
  const _SyncStatus._() : super._();

  factory _SyncStatus.fromJson(Map<String, dynamic> json) =
      _$SyncStatusImpl.fromJson;

  @override
  SyncState get state;
  @override
  double get progress;
  @override
  String? get message;
  @override
  DateTime? get lastSyncTime;
  @override
  SyncType? get currentSyncType;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncStatusImplCopyWith<_$SyncStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncResult _$SyncResultFromJson(Map<String, dynamic> json) {
  return _SyncResult.fromJson(json);
}

/// @nodoc
mixin _$SyncResult {
  bool get success => throw _privateConstructorUsedError;
  int get syncedFeedsCount => throw _privateConstructorUsedError;
  int get syncedArticlesCount => throw _privateConstructorUsedError;
  int get syncedFavoritesCount => throw _privateConstructorUsedError;
  int get failedCount => throw _privateConstructorUsedError;
  List<SyncError> get errors => throw _privateConstructorUsedError;
  DateTime? get syncedAt => throw _privateConstructorUsedError;

  /// Serializes this SyncResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncResultCopyWith<SyncResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncResultCopyWith<$Res> {
  factory $SyncResultCopyWith(
    SyncResult value,
    $Res Function(SyncResult) then,
  ) = _$SyncResultCopyWithImpl<$Res, SyncResult>;
  @useResult
  $Res call({
    bool success,
    int syncedFeedsCount,
    int syncedArticlesCount,
    int syncedFavoritesCount,
    int failedCount,
    List<SyncError> errors,
    DateTime? syncedAt,
  });
}

/// @nodoc
class _$SyncResultCopyWithImpl<$Res, $Val extends SyncResult>
    implements $SyncResultCopyWith<$Res> {
  _$SyncResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? syncedFeedsCount = null,
    Object? syncedArticlesCount = null,
    Object? syncedFavoritesCount = null,
    Object? failedCount = null,
    Object? errors = null,
    Object? syncedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            syncedFeedsCount: null == syncedFeedsCount
                ? _value.syncedFeedsCount
                : syncedFeedsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            syncedArticlesCount: null == syncedArticlesCount
                ? _value.syncedArticlesCount
                : syncedArticlesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            syncedFavoritesCount: null == syncedFavoritesCount
                ? _value.syncedFavoritesCount
                : syncedFavoritesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            failedCount: null == failedCount
                ? _value.failedCount
                : failedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            errors: null == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<SyncError>,
            syncedAt: freezed == syncedAt
                ? _value.syncedAt
                : syncedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SyncResultImplCopyWith<$Res>
    implements $SyncResultCopyWith<$Res> {
  factory _$$SyncResultImplCopyWith(
    _$SyncResultImpl value,
    $Res Function(_$SyncResultImpl) then,
  ) = __$$SyncResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    int syncedFeedsCount,
    int syncedArticlesCount,
    int syncedFavoritesCount,
    int failedCount,
    List<SyncError> errors,
    DateTime? syncedAt,
  });
}

/// @nodoc
class __$$SyncResultImplCopyWithImpl<$Res>
    extends _$SyncResultCopyWithImpl<$Res, _$SyncResultImpl>
    implements _$$SyncResultImplCopyWith<$Res> {
  __$$SyncResultImplCopyWithImpl(
    _$SyncResultImpl _value,
    $Res Function(_$SyncResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? syncedFeedsCount = null,
    Object? syncedArticlesCount = null,
    Object? syncedFavoritesCount = null,
    Object? failedCount = null,
    Object? errors = null,
    Object? syncedAt = freezed,
  }) {
    return _then(
      _$SyncResultImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        syncedFeedsCount: null == syncedFeedsCount
            ? _value.syncedFeedsCount
            : syncedFeedsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        syncedArticlesCount: null == syncedArticlesCount
            ? _value.syncedArticlesCount
            : syncedArticlesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        syncedFavoritesCount: null == syncedFavoritesCount
            ? _value.syncedFavoritesCount
            : syncedFavoritesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        failedCount: null == failedCount
            ? _value.failedCount
            : failedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        errors: null == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<SyncError>,
        syncedAt: freezed == syncedAt
            ? _value.syncedAt
            : syncedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncResultImpl extends _SyncResult {
  const _$SyncResultImpl({
    required this.success,
    this.syncedFeedsCount = 0,
    this.syncedArticlesCount = 0,
    this.syncedFavoritesCount = 0,
    this.failedCount = 0,
    final List<SyncError> errors = const [],
    this.syncedAt,
  }) : _errors = errors,
       super._();

  factory _$SyncResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncResultImplFromJson(json);

  @override
  final bool success;
  @override
  @JsonKey()
  final int syncedFeedsCount;
  @override
  @JsonKey()
  final int syncedArticlesCount;
  @override
  @JsonKey()
  final int syncedFavoritesCount;
  @override
  @JsonKey()
  final int failedCount;
  final List<SyncError> _errors;
  @override
  @JsonKey()
  List<SyncError> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  final DateTime? syncedAt;

  @override
  String toString() {
    return 'SyncResult(success: $success, syncedFeedsCount: $syncedFeedsCount, syncedArticlesCount: $syncedArticlesCount, syncedFavoritesCount: $syncedFavoritesCount, failedCount: $failedCount, errors: $errors, syncedAt: $syncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.syncedFeedsCount, syncedFeedsCount) ||
                other.syncedFeedsCount == syncedFeedsCount) &&
            (identical(other.syncedArticlesCount, syncedArticlesCount) ||
                other.syncedArticlesCount == syncedArticlesCount) &&
            (identical(other.syncedFavoritesCount, syncedFavoritesCount) ||
                other.syncedFavoritesCount == syncedFavoritesCount) &&
            (identical(other.failedCount, failedCount) ||
                other.failedCount == failedCount) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    syncedFeedsCount,
    syncedArticlesCount,
    syncedFavoritesCount,
    failedCount,
    const DeepCollectionEquality().hash(_errors),
    syncedAt,
  );

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncResultImplCopyWith<_$SyncResultImpl> get copyWith =>
      __$$SyncResultImplCopyWithImpl<_$SyncResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncResultImplToJson(this);
  }
}

abstract class _SyncResult extends SyncResult {
  const factory _SyncResult({
    required final bool success,
    final int syncedFeedsCount,
    final int syncedArticlesCount,
    final int syncedFavoritesCount,
    final int failedCount,
    final List<SyncError> errors,
    final DateTime? syncedAt,
  }) = _$SyncResultImpl;
  const _SyncResult._() : super._();

  factory _SyncResult.fromJson(Map<String, dynamic> json) =
      _$SyncResultImpl.fromJson;

  @override
  bool get success;
  @override
  int get syncedFeedsCount;
  @override
  int get syncedArticlesCount;
  @override
  int get syncedFavoritesCount;
  @override
  int get failedCount;
  @override
  List<SyncError> get errors;
  @override
  DateTime? get syncedAt;

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncResultImplCopyWith<_$SyncResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncError _$SyncErrorFromJson(Map<String, dynamic> json) {
  return _SyncError.fromJson(json);
}

/// @nodoc
mixin _$SyncError {
  SyncType get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get itemId => throw _privateConstructorUsedError;
  DateTime? get occurredAt => throw _privateConstructorUsedError;

  /// Serializes this SyncError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncErrorCopyWith<SyncError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncErrorCopyWith<$Res> {
  factory $SyncErrorCopyWith(SyncError value, $Res Function(SyncError) then) =
      _$SyncErrorCopyWithImpl<$Res, SyncError>;
  @useResult
  $Res call({
    SyncType type,
    String message,
    String? itemId,
    DateTime? occurredAt,
  });
}

/// @nodoc
class _$SyncErrorCopyWithImpl<$Res, $Val extends SyncError>
    implements $SyncErrorCopyWith<$Res> {
  _$SyncErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? itemId = freezed,
    Object? occurredAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SyncType,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            itemId: freezed == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String?,
            occurredAt: freezed == occurredAt
                ? _value.occurredAt
                : occurredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SyncErrorImplCopyWith<$Res>
    implements $SyncErrorCopyWith<$Res> {
  factory _$$SyncErrorImplCopyWith(
    _$SyncErrorImpl value,
    $Res Function(_$SyncErrorImpl) then,
  ) = __$$SyncErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    SyncType type,
    String message,
    String? itemId,
    DateTime? occurredAt,
  });
}

/// @nodoc
class __$$SyncErrorImplCopyWithImpl<$Res>
    extends _$SyncErrorCopyWithImpl<$Res, _$SyncErrorImpl>
    implements _$$SyncErrorImplCopyWith<$Res> {
  __$$SyncErrorImplCopyWithImpl(
    _$SyncErrorImpl _value,
    $Res Function(_$SyncErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SyncError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? itemId = freezed,
    Object? occurredAt = freezed,
  }) {
    return _then(
      _$SyncErrorImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SyncType,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        itemId: freezed == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String?,
        occurredAt: freezed == occurredAt
            ? _value.occurredAt
            : occurredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncErrorImpl implements _SyncError {
  const _$SyncErrorImpl({
    required this.type,
    required this.message,
    this.itemId,
    this.occurredAt,
  });

  factory _$SyncErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncErrorImplFromJson(json);

  @override
  final SyncType type;
  @override
  final String message;
  @override
  final String? itemId;
  @override
  final DateTime? occurredAt;

  @override
  String toString() {
    return 'SyncError(type: $type, message: $message, itemId: $itemId, occurredAt: $occurredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncErrorImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, message, itemId, occurredAt);

  /// Create a copy of SyncError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncErrorImplCopyWith<_$SyncErrorImpl> get copyWith =>
      __$$SyncErrorImplCopyWithImpl<_$SyncErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncErrorImplToJson(this);
  }
}

abstract class _SyncError implements SyncError {
  const factory _SyncError({
    required final SyncType type,
    required final String message,
    final String? itemId,
    final DateTime? occurredAt,
  }) = _$SyncErrorImpl;

  factory _SyncError.fromJson(Map<String, dynamic> json) =
      _$SyncErrorImpl.fromJson;

  @override
  SyncType get type;
  @override
  String get message;
  @override
  String? get itemId;
  @override
  DateTime? get occurredAt;

  /// Create a copy of SyncError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncErrorImplCopyWith<_$SyncErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncConflict _$SyncConflictFromJson(Map<String, dynamic> json) {
  return _SyncConflict.fromJson(json);
}

/// @nodoc
mixin _$SyncConflict {
  String get itemId => throw _privateConstructorUsedError;
  SyncType get type => throw _privateConstructorUsedError;
  dynamic get localValue => throw _privateConstructorUsedError;
  dynamic get remoteValue => throw _privateConstructorUsedError;
  DateTime get localUpdatedAt => throw _privateConstructorUsedError;
  DateTime get remoteUpdatedAt => throw _privateConstructorUsedError;

  /// Serializes this SyncConflict to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncConflictCopyWith<SyncConflict> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncConflictCopyWith<$Res> {
  factory $SyncConflictCopyWith(
    SyncConflict value,
    $Res Function(SyncConflict) then,
  ) = _$SyncConflictCopyWithImpl<$Res, SyncConflict>;
  @useResult
  $Res call({
    String itemId,
    SyncType type,
    dynamic localValue,
    dynamic remoteValue,
    DateTime localUpdatedAt,
    DateTime remoteUpdatedAt,
  });
}

/// @nodoc
class _$SyncConflictCopyWithImpl<$Res, $Val extends SyncConflict>
    implements $SyncConflictCopyWith<$Res> {
  _$SyncConflictCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? type = null,
    Object? localValue = freezed,
    Object? remoteValue = freezed,
    Object? localUpdatedAt = null,
    Object? remoteUpdatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SyncType,
            localValue: freezed == localValue
                ? _value.localValue
                : localValue // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            remoteValue: freezed == remoteValue
                ? _value.remoteValue
                : remoteValue // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            localUpdatedAt: null == localUpdatedAt
                ? _value.localUpdatedAt
                : localUpdatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            remoteUpdatedAt: null == remoteUpdatedAt
                ? _value.remoteUpdatedAt
                : remoteUpdatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SyncConflictImplCopyWith<$Res>
    implements $SyncConflictCopyWith<$Res> {
  factory _$$SyncConflictImplCopyWith(
    _$SyncConflictImpl value,
    $Res Function(_$SyncConflictImpl) then,
  ) = __$$SyncConflictImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String itemId,
    SyncType type,
    dynamic localValue,
    dynamic remoteValue,
    DateTime localUpdatedAt,
    DateTime remoteUpdatedAt,
  });
}

/// @nodoc
class __$$SyncConflictImplCopyWithImpl<$Res>
    extends _$SyncConflictCopyWithImpl<$Res, _$SyncConflictImpl>
    implements _$$SyncConflictImplCopyWith<$Res> {
  __$$SyncConflictImplCopyWithImpl(
    _$SyncConflictImpl _value,
    $Res Function(_$SyncConflictImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? type = null,
    Object? localValue = freezed,
    Object? remoteValue = freezed,
    Object? localUpdatedAt = null,
    Object? remoteUpdatedAt = null,
  }) {
    return _then(
      _$SyncConflictImpl(
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SyncType,
        localValue: freezed == localValue
            ? _value.localValue
            : localValue // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        remoteValue: freezed == remoteValue
            ? _value.remoteValue
            : remoteValue // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        localUpdatedAt: null == localUpdatedAt
            ? _value.localUpdatedAt
            : localUpdatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        remoteUpdatedAt: null == remoteUpdatedAt
            ? _value.remoteUpdatedAt
            : remoteUpdatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncConflictImpl implements _SyncConflict {
  const _$SyncConflictImpl({
    required this.itemId,
    required this.type,
    required this.localValue,
    required this.remoteValue,
    required this.localUpdatedAt,
    required this.remoteUpdatedAt,
  });

  factory _$SyncConflictImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncConflictImplFromJson(json);

  @override
  final String itemId;
  @override
  final SyncType type;
  @override
  final dynamic localValue;
  @override
  final dynamic remoteValue;
  @override
  final DateTime localUpdatedAt;
  @override
  final DateTime remoteUpdatedAt;

  @override
  String toString() {
    return 'SyncConflict(itemId: $itemId, type: $type, localValue: $localValue, remoteValue: $remoteValue, localUpdatedAt: $localUpdatedAt, remoteUpdatedAt: $remoteUpdatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncConflictImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other.localValue,
              localValue,
            ) &&
            const DeepCollectionEquality().equals(
              other.remoteValue,
              remoteValue,
            ) &&
            (identical(other.localUpdatedAt, localUpdatedAt) ||
                other.localUpdatedAt == localUpdatedAt) &&
            (identical(other.remoteUpdatedAt, remoteUpdatedAt) ||
                other.remoteUpdatedAt == remoteUpdatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    itemId,
    type,
    const DeepCollectionEquality().hash(localValue),
    const DeepCollectionEquality().hash(remoteValue),
    localUpdatedAt,
    remoteUpdatedAt,
  );

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncConflictImplCopyWith<_$SyncConflictImpl> get copyWith =>
      __$$SyncConflictImplCopyWithImpl<_$SyncConflictImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncConflictImplToJson(this);
  }
}

abstract class _SyncConflict implements SyncConflict {
  const factory _SyncConflict({
    required final String itemId,
    required final SyncType type,
    required final dynamic localValue,
    required final dynamic remoteValue,
    required final DateTime localUpdatedAt,
    required final DateTime remoteUpdatedAt,
  }) = _$SyncConflictImpl;

  factory _SyncConflict.fromJson(Map<String, dynamic> json) =
      _$SyncConflictImpl.fromJson;

  @override
  String get itemId;
  @override
  SyncType get type;
  @override
  dynamic get localValue;
  @override
  dynamic get remoteValue;
  @override
  DateTime get localUpdatedAt;
  @override
  DateTime get remoteUpdatedAt;

  /// Create a copy of SyncConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncConflictImplCopyWith<_$SyncConflictImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncLogEntry _$SyncLogEntryFromJson(Map<String, dynamic> json) {
  return _SyncLogEntry.fromJson(json);
}

/// @nodoc
mixin _$SyncLogEntry {
  int? get id => throw _privateConstructorUsedError;
  SyncType get syncType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int get itemCount => throw _privateConstructorUsedError;
  DateTime get syncedAt => throw _privateConstructorUsedError;

  /// Serializes this SyncLogEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncLogEntryCopyWith<SyncLogEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncLogEntryCopyWith<$Res> {
  factory $SyncLogEntryCopyWith(
    SyncLogEntry value,
    $Res Function(SyncLogEntry) then,
  ) = _$SyncLogEntryCopyWithImpl<$Res, SyncLogEntry>;
  @useResult
  $Res call({
    int? id,
    SyncType syncType,
    String status,
    String? message,
    int itemCount,
    DateTime syncedAt,
  });
}

/// @nodoc
class _$SyncLogEntryCopyWithImpl<$Res, $Val extends SyncLogEntry>
    implements $SyncLogEntryCopyWith<$Res> {
  _$SyncLogEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? syncType = null,
    Object? status = null,
    Object? message = freezed,
    Object? itemCount = null,
    Object? syncedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            syncType: null == syncType
                ? _value.syncType
                : syncType // ignore: cast_nullable_to_non_nullable
                      as SyncType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemCount: null == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                      as int,
            syncedAt: null == syncedAt
                ? _value.syncedAt
                : syncedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SyncLogEntryImplCopyWith<$Res>
    implements $SyncLogEntryCopyWith<$Res> {
  factory _$$SyncLogEntryImplCopyWith(
    _$SyncLogEntryImpl value,
    $Res Function(_$SyncLogEntryImpl) then,
  ) = __$$SyncLogEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    SyncType syncType,
    String status,
    String? message,
    int itemCount,
    DateTime syncedAt,
  });
}

/// @nodoc
class __$$SyncLogEntryImplCopyWithImpl<$Res>
    extends _$SyncLogEntryCopyWithImpl<$Res, _$SyncLogEntryImpl>
    implements _$$SyncLogEntryImplCopyWith<$Res> {
  __$$SyncLogEntryImplCopyWithImpl(
    _$SyncLogEntryImpl _value,
    $Res Function(_$SyncLogEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SyncLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? syncType = null,
    Object? status = null,
    Object? message = freezed,
    Object? itemCount = null,
    Object? syncedAt = null,
  }) {
    return _then(
      _$SyncLogEntryImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        syncType: null == syncType
            ? _value.syncType
            : syncType // ignore: cast_nullable_to_non_nullable
                  as SyncType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemCount: null == itemCount
            ? _value.itemCount
            : itemCount // ignore: cast_nullable_to_non_nullable
                  as int,
        syncedAt: null == syncedAt
            ? _value.syncedAt
            : syncedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncLogEntryImpl implements _SyncLogEntry {
  const _$SyncLogEntryImpl({
    this.id,
    required this.syncType,
    required this.status,
    this.message,
    this.itemCount = 0,
    required this.syncedAt,
  });

  factory _$SyncLogEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncLogEntryImplFromJson(json);

  @override
  final int? id;
  @override
  final SyncType syncType;
  @override
  final String status;
  @override
  final String? message;
  @override
  @JsonKey()
  final int itemCount;
  @override
  final DateTime syncedAt;

  @override
  String toString() {
    return 'SyncLogEntry(id: $id, syncType: $syncType, status: $status, message: $message, itemCount: $itemCount, syncedAt: $syncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncLogEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.syncType, syncType) ||
                other.syncType == syncType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    syncType,
    status,
    message,
    itemCount,
    syncedAt,
  );

  /// Create a copy of SyncLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncLogEntryImplCopyWith<_$SyncLogEntryImpl> get copyWith =>
      __$$SyncLogEntryImplCopyWithImpl<_$SyncLogEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncLogEntryImplToJson(this);
  }
}

abstract class _SyncLogEntry implements SyncLogEntry {
  const factory _SyncLogEntry({
    final int? id,
    required final SyncType syncType,
    required final String status,
    final String? message,
    final int itemCount,
    required final DateTime syncedAt,
  }) = _$SyncLogEntryImpl;

  factory _SyncLogEntry.fromJson(Map<String, dynamic> json) =
      _$SyncLogEntryImpl.fromJson;

  @override
  int? get id;
  @override
  SyncType get syncType;
  @override
  String get status;
  @override
  String? get message;
  @override
  int get itemCount;
  @override
  DateTime get syncedAt;

  /// Create a copy of SyncLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncLogEntryImplCopyWith<_$SyncLogEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
