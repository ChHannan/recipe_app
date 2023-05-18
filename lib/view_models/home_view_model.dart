import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/models/cuisine.dart';
import 'package:recipe_app/models/food.dart';
import 'package:recipe_app/repositories/food_repository.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, AsyncValue<List<Food>>>((ref) {
  return HomeViewModel(
    foodRepository: ref.read(foodRepoProvider),
  );
});

class HomeViewModel extends StateNotifier<AsyncValue<List<Food>>> {
  FoodRepository foodRepository;
  List<Food> foods = [];
  List<Category> categories = [];
  List<Cuisine> cuisines = [];
  List<Category> selectedCategories = [];
  List<Cuisine> selectedCuisines = [];

  HomeViewModel({
    required this.foodRepository,
  }) : super(const AsyncValue.loading()) {
    _fetchFoodData();
  }

  /// Fetch the food data on load
  void _fetchFoodData() async {
    try {
      foods = await foodRepository.fetchFoods();
      categories = await foodRepository.fetchCategories();
      cuisines = await foodRepository.fetchCuisines();
      state = AsyncValue.data(foods);
    } catch (err, e) {
      state = AsyncValue.error(err, e);
    }
  }

  /// Search the food list based on the entered query
  void searchFood(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(foods);
    } else {
      final filteredList = foods
          .where((food) =>
              food.name.toLowerCase().contains(query.toLowerCase()) ||
              food.chef.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredList);
    }
  }

  /// Filter on the base of categories and cuisines
  void applyFilters() {
    if (selectedCategories.isEmpty && selectedCuisines.isEmpty) {
      state = AsyncValue.data(foods);
    } else {
      final filteredList = foods.where((food) {
        final categoryIds =
            selectedCategories.map((category) => category.id).toList();
        final cuisineIds =
            selectedCuisines.map((cuisine) => cuisine.id).toList();
        final matchesCategory =
            selectedCategories.isEmpty || categoryIds.contains(food.categoryId);
        final matchesCuisine =
            selectedCuisines.isEmpty || cuisineIds.contains(food.cuisineId);
        return matchesCategory && matchesCuisine;
      }).toList();
      state = AsyncValue.data(filteredList);
    }
  }

  /// Reset all applied filters
  void clearFilters() {
    selectedCategories = [];
    selectedCuisines = [];
    state = AsyncValue.data(foods);
  }
}
