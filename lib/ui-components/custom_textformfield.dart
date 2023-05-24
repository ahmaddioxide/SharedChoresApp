import 'package:flutter/material.dart';
import 'package:choresmate/ui-components/theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPasswordField;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.isPasswordField,
    required this.controller,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText = widget.isPasswordField ? true : false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.12,
          // height: MediaQuery.of(context).size.height * 0.08,
          height: 64,
          child: Container(
            decoration: const BoxDecoration(
              color: CustomColorSwatch.pimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Icon(
              widget.icon,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          // height: MediaQuery.of(context).size.height * 0.09,
          child: TextFormField(
            // onSaved: widget.onSaved,
            controller: widget.controller,
            obscureText: _obscureText,
            decoration: InputDecoration(

              // errorText: widget.haveError ? widget.errorText : null,
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          debugPrint("Set State Called on tapping eye icon");
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    )
                  : null,
              hintText: widget.hintText,
              labelText: widget.hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
