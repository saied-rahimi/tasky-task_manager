import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class TextField extends StatefulWidget {
  const TextField({required this.data, required this.controller, this.hrPadding, this.vrPadding, super.key});
  final Map data;
  final double? hrPadding;
  final double? vrPadding;
  final TextEditingController controller;

  @override
  State<TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  late bool obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscureText = widget.data['type'] == 'password';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data['type'] == 'phoneNum') {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: widget.vrPadding ?? 10, horizontal: widget.hrPadding ?? 0),
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
          keyboardType: widget.data['keyboardType'],
          obscureText: obscureText, // Toggle text visibility
          decoration: InputDecoration(
            labelText: '${widget.data['liable']}',
            border: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: widget.data['type'] == 'password'
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
