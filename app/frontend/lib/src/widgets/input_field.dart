import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this to pubspec.yaml
import 'dart:io';

class InputField<T> extends StatefulWidget {
  final String label;
  final IconData? icon;
  final T? initialValue;
  final ValueChanged<String?>? onSaved;
  final bool isPassword;
  final bool isTextArea;
  final bool isImagePicker;
  final bool isFilePicker;
  final TextInputType keyboardType;
  final int? maxLength;
  final double? width;
  final FormFieldValidator<String>? validator;
  final ValueChanged<File?>? onImagePicked;
  final ValueChanged<File?>? onFilePicked;
  final TextEditingController? controller; // Add this

  const InputField({
    super.key,
    required this.label,
    this.icon,
    this.initialValue,
    this.onSaved,
    this.isPassword = false,
    this.isTextArea = false,
    this.isImagePicker = false,
    this.isFilePicker = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.width,
    this.validator,
    this.onImagePicked,
    this.onFilePicked,
    this.controller,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = false;
  File? _imageFile;
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.isPassword) {
      _obscureText = true;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      if (widget.onImagePicked != null) {
        widget.onImagePicked!(_imageFile);
      }
    }
  }

  Future<void> _pickFile() async {
    setState(() {
      _selectedFile = File('dummy_cv.pdf');
    });
    if (widget.onFilePicked != null) {
      widget.onFilePicked!(_selectedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isImagePicker) return _buildImagePicker(context);
    if (widget.isFilePicker) return _buildFilePicker(context);
    return _buildTextInput(context);
  }

  Widget _buildTextInput(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        maxLines: widget.isTextArea ? 4 : 1,
        keyboardType: widget.keyboardType,
        initialValue: widget.initialValue,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            height: widget.isTextArea ? 2.5 : null,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon:
              widget.icon != null
                  ? Icon(widget.icon, color: Theme.of(context).primaryColor)
                  : null,
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).primaryColor,
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

  Widget _buildImagePicker(BuildContext context) {
    ImageProvider? imageProvider;

    if (_imageFile != null) {
      imageProvider = FileImage(_imageFile!);
    } else if (widget.initialValue != null) {
      imageProvider = NetworkImage(widget.initialValue);
    }

    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 120,
            backgroundColor: Colors.grey[200],
            backgroundImage: imageProvider,
            child:
                imageProvider == null
                    ? Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    )
                    : null,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.label,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFilePicker(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: _pickFile,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.attach_file, color: Theme.of(context).primaryColor),
                const SizedBox(width: 10),
                Text(
                  _selectedFile != null
                      ? _selectedFile!.path.split('/').last
                      : 'Select File',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
