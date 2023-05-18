import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/models/cuisine.dart';
import 'package:recipe_app/models/food.dart';

final foodRepoProvider = Provider<FoodRepository>((ref) {
  return FoodRepository();
});

class FoodRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Food>> fetchFoods() async {
    List<QueryDocumentSnapshot<Object?>> foodItems = await fetchDocs('foods');
    return foodItems.map((doc) => Food.fromSnapshot(doc)).toList();
  }

  Future<List<Category>> fetchCategories() async {
    List<QueryDocumentSnapshot<Object?>> categoriesItems =
        await fetchDocs('categories');
    return categoriesItems.map((doc) => Category.fromSnapshot(doc)).toList();
  }

  Future<List<Cuisine>> fetchCuisines() async {
    List<QueryDocumentSnapshot<Object?>> cuisinesItems =
        await fetchDocs('cuisines');
    return cuisinesItems.map((doc) => Cuisine.fromSnapshot(doc)).toList();
  }

  Future<List<QueryDocumentSnapshot<Object?>>> fetchDocs(String path) async {
    CollectionReference collectionRef = firestore.collection(path);
    final snapshot = await collectionRef.get();
    return snapshot.docs;
  }
}
