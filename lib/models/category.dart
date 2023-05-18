import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  /// The id of category
  final String id;

  ///The name of category
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  /// Map firebase doc snapshot to Category
  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Category(
      id: snapshot.id,
      name: data['name'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name}';
  }
}
