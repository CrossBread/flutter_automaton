
import 'entity.dart';

/// [NamedEntity] is a specific case of an [Entity] that adds a **human readable display name** intended for
/// user-facing display.  Most entities in the system should extend this abstract class rather than
/// extending [Entity] directly.
abstract class NamedEntity extends Entity {
  final String displayName;

  NamedEntity({required this.displayName, String? uuid, int? apiVersion, DateTime? modifiedDateTime})
      : super(uuid: uuid, apiVersion: apiVersion, modifiedDateTime: modifiedDateTime);

  NamedEntity.empty()
      : this.displayName = '',
        super.empty();

  /// Includes properties from super class
  @override
  List<Object?> get props => [
        ...super.props,
        // Equivalence should only depend on the set of UUIDs associated with an object so that something like
        // a different display name would cause a replacement in a data structure rather than a duplicate.
        // this.displayName,
      ];
}
