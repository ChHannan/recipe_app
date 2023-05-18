import 'package:cloud_firestore/cloud_firestore.dart';

class Cuisine {
  /// The id of cuisine
  final String id;

  /// The name of cuisine
  final String name;

  Cuisine({
    required this.id,
    required this.name,
  });

  /// Map firebase doc snapshot to Cuisine
  factory Cuisine.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Cuisine(
      id: snapshot.id,
      name: data['name'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Cuisine{id: $id, name: $name}';
  }
}
