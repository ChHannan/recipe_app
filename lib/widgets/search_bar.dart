import 'package:flutter/material.dart';

import 'filter_bottom_sheet.dart';
import 'input_field.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onChange;

  const SearchBar({
    super.key,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: InputField(
              onChange: onChange,
              leadingIcon: Icons.search,
              hint: 'Search for food...',
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: const Color(0xff70B9BE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.filter_list_alt,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  context: context,
                  builder: (BuildContext context) {
                    return const FilterBottomSheet();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
