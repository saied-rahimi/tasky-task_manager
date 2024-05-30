import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    required this.data,
    required this.controller,
    this.hrPadding,
    this.vrPadding,
    this.validator,
    this.intValidator,
    super.key,
  });

  final Map data;
  final double? hrPadding;
  final double? vrPadding;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? Function(PhoneNumber?)? intValidator;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    if (widget.data['keyboardType'] == 'phoneNum') {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: widget.vrPadding ?? 0,
          horizontal: widget.hrPadding ?? 0,
        ),
        child: IntlPhoneField(
          validator: widget.intValidator,
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: '${widget.data['liable']}',
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          initialCountryCode: 'AF',
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: widget.vrPadding ?? 10,
          horizontal: widget.hrPadding ?? 0,
        ),
        child: TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          keyboardType: widget.data['keyboardType'] == 'int' ? TextInputType.number : TextInputType.text,
          obscureText: widget.data['keyboardType'] == 'password' ? obscureText : false,
          decoration: InputDecoration(
            hintText: '${widget.data['hint']}',
            labelText: '${widget.data['liable']}',
            border: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: widget.data['keyboardType'] == 'password'
                ? IconButton(
                    icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      );
    }
  }
}
