import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/view_models/home_view_model.dart';

import 'action_button.dart';
import 'filter_box.dart';

class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final homeVm = ref.read(homeViewModelProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const Center(
              child: Text(
                'Filter',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              children: homeVm.categories.map((category) {
                return FilterBox(
                  id: category.id,
                  name: category.name,
                  isSelected: homeVm.selectedCategories.contains(category),
                  onChanged: (isSelected) {
                    setState(() {
                      if (isSelected) {
                        homeVm.selectedCategories.add(category);
                      } else {
                        homeVm.selectedCategories.remove(category);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Cuisines',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 16,
              children: homeVm.cuisines.map((cuisine) {
                final isSelected = homeVm.selectedCuisines.contains(cuisine);
                return FilterBox(
                  id: cuisine.id,
                  name: cuisine.name,
                  isSelected: isSelected,
                  onChanged: (isSelected) {
                    setState(() {
                      if (isSelected) {
                        homeVm.selectedCuisines.add(cuisine);
                      } else {
                        homeVm.selectedCuisines.remove(cuisine);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 32.0),
            ActionButton(
              label: 'Apply Filter',
              backgroundColor: const Color(0xff70B9BE),
              onTap: () {
                homeVm.applyFilters();
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16.0),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: () {
                homeVm.clearFilters();
                Navigator.pop(context);
              },
              child: const Text(
                'Clear Filter',
                style: TextStyle(
                  color: Color(0xff70B9BE),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
