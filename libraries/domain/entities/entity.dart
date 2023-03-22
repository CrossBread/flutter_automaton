import 'named_entity.dart';
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

/// [Entity] is the base abstract class for business objects.
///
/// It should be extended by any class representing business object (See also [NamedEntity]).  The [uuid] is
/// intended to be used across DTO objects that may facilitate the storage of this [Entity] to an
/// external data source. **Note:**  [kCurrentApiVersion] should be incremented any time
/// new fields are introduced or removed that do not have default values.
///
/// Objects extending [Entity] should attempt to upgrade themselves if their [apiVersion]
/// is less than the [kCurrentApiVersion].
///
/// Classes extending [Entity] should ideally be immutable and implement a `.copyWith()` method
/// for capturing changes on a new instance of the entity.  If the copy represents *the same* entity,
/// then the [uuid] of the original [Entity] should be set as the [uuid] on the copy.
abstract class Entity extends Equatable {
  /// This API version should be incremented any time fields are introduced or removed that do not have default values.
  static const int kCurrentApiVersion = 1;

  /// Universal Unique ID for use with external data storage.  For example, with Firestore this could be used
  /// as the document id.
  final String uuid;

  /// The version of the api used by the current data the object holds.
  final int apiVersion;

  /// The time the original or an immutable copy of this object was created.  If the [uuid] of two instances
  /// of an [Entity] are identical, then the [modifiedDateTime] would indicate which copy is most recent.
  final DateTime modifiedDateTime;

  Entity({String? uuid, int? apiVersion, DateTime? modifiedDateTime})
      : this.modifiedDateTime = modifiedDateTime ?? DateTime.now().toUtc(),
        this.apiVersion = apiVersion ?? kCurrentApiVersion,
        this.uuid = uuid ?? Uuid().v4();

  /// An empty [Entity] with default values for all fields can be helpful for avoiding null checks.
  Entity.empty()
      : this.uuid = '',
        this.apiVersion = -1,
        this.modifiedDateTime = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);

  /// For use with @[JsonSerializable]
  Map<String, dynamic> toJson();

  /// List of properties for use in determining equality of [Entity] instances.  Sub Classes
  /// should still override [Equatable.props],and provide a definition
  /// but should include `super.props` to remain consistent with other [Entity] equality checks.
  ///
  /// **Example using spread (ellipsis) operator `...` :**
  /// ```dart
  /// @override
  ///   List<Object?> get props => [
  ///         ...super.props,
  ///         this.subClassPropertyA,
  ///         this.subClassPropertyB,
  ///       ];
  /// ```
  /// Note: Intentionally ignoring modifiedDateTime when checking for equality
  @override
  List<Object?> get props => [
        this.apiVersion,
        this.uuid, // TODO: Test case for equality of uuids
      ];
}
