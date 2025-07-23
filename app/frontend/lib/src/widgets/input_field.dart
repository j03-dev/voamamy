import 'package:flutter/material.dart';

class InputField<T> extends StatefulWidget {
  final String label;
  final IconData? icon;
  final T? initialValue;
  final ValueChanged<String?>? onSaved;
  final bool isPassword;
  final bool isTextArea;
  final bool isFilePicker;
  final TextInputType keyboardType;
  final int? maxLength;
  final double? width;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  const InputField({
    super.key,
    required this.label,
    this.icon,
    this.initialValue,
    this.onSaved,
    this.isPassword = false,
    this.isTextArea = false,
    this.isFilePicker = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.width,
    this.validator,
    this.controller,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    if (widget.isPassword) {
      _obscureText = true;
    }
  }

  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        maxLines: widget.isTextArea ? 4 : 1,
        keyboardType: widget.keyboardType,
        initialValue: widget.initialValue,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(height: widget.isTextArea ? 2.5 : null),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                  : null,
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.isTextArea ? 20 : 15,
            horizontal: 20,
          ),
          alignLabelWithHint: widget.isTextArea,
        ),
        onSaved: widget.onSaved,
        validator: widget.validator,
      ),
    );
  }
}
