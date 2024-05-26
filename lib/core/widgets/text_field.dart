import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class TextInput extends StatefulWidget {
  const TextInput({required this.data, required this.controller, this.hrPadding, this.vrPadding, super.key});
  final Map data;
  final double? hrPadding;
  final double? vrPadding;
  final TextEditingController controller;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late bool obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscureText = widget.data['type'] == 'password';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data['keyboardType'] == 'phoneNum') {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: widget.vrPadding ?? 0, horizontal: widget.hrPadding ?? 0),
        child: IntlPhoneField(
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
        padding: EdgeInsets.symmetric(vertical: widget.vrPadding ?? 10, horizontal: widget.hrPadding ?? 0),
        child: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: obscureText, // Toggle text visibility
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
                        obscureText = !obscureText; // Toggle text visibility on button press
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
