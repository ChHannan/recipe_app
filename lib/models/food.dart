import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  /// The id of food item
  final String id;

  /// The name of food
  final String name;

  /// The category type of food
  final String categoryId;

  /// The cuisine type of food
  final String cuisineId;

  /// The chef name of food
  final String chef;

  /// The image of food
  final String image;

  Food({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.cuisineId,
    required this.chef,
    required this.image,
  });

  /// Map firebase doc snapshot to Food
  factory Food.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Food(
      id: snapshot.id,
      name: data['name'],
      categoryId: data['categoryId'],
      cuisineId: data['cuisineId'],
      chef: data['chef'],
      image: data['image'],
    );
  }

  @override
  String toString() {
    return 'Food{id: $id, name: $name, categoryId: $categoryId, cuisineId: $cuisineId, chef: $chef, image: $image}';
  }
}
