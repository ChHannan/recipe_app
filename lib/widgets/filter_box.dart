import 'package:flutter/material.dart';

class FilterBox extends StatefulWidget {
  final String id;
  final String name;
  final bool isSelected;
  final Function(bool selected) onChanged;

  const FilterBox({
    super.key,
    required this.id,
    required this.name,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selected = !_selected;
        widget.onChanged(_selected);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
            color: _selected ? const Color(0xff70B9BE) : Colors.grey[300],
            borderRadius: BorderRadius.circular(24)),
        child: Text(
          widget.name,
          style: TextStyle(
            color: _selected ? Colors.white : const Color(0xff70B9BE),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
