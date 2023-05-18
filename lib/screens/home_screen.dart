import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/view_models/home_view_model.dart';
import 'package:recipe_app/widgets/food_card.dart';
import 'package:recipe_app/widgets/search_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Search',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SearchBar(
              onChange: (value) {
                ref.read(homeViewModelProvider.notifier).searchFood(
                      value.trim(),
                    );
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: state.when(
                data: (foodList) => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: foodList.length,
                  itemBuilder: (context, index) {
                    final food = foodList[index];
                    return FoodCard(food: food);
                  },
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
                error: (error, stackTrace) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
