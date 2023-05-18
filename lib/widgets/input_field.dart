import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String hint;
  final IconData leadingIcon;
  final bool isObscure;
  final Function(String)? onChange;
  final String? Function(String?)? validator;

  const InputField({
    Key? key,
    this.controller,
    this.label,
    required this.hint,
    required this.leadingIcon,
    this.onChange,
    this.isObscure = false,
    this.validator,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool isPasswordVisible;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...{
          Column(
            children: [
              Text(
                widget.label ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        },
        TextFormField(
          controller: widget.controller,
          onChanged: widget.onChange,
          obscureText: isPasswordVisible,
          validator: widget.validator,
          cursorColor: const Color(0xff70B9BE),
          decoration: InputDecoration(
            hintText: widget.hint,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            prefixIcon: Icon(
              widget.leadingIcon,
              color: Colors.black54,
            ),
            suffixIcon: widget.isObscure
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
