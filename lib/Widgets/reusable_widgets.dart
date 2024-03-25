// reusable Textformfields
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';

TextFormField showTextFormField({
  required TextEditingController? controller,
  required String labelText,
  required Function(String?)? validator,
  required IconData prefixIcon,
  required IconData? suffixIcon,
  required TextInputType textInputType,
  required bool obscureText,
}) {
  return TextFormField(
    keyboardType: textInputType,
    controller: controller,
    autovalidateMode: AutovalidateMode.disabled,
    textCapitalization: TextCapitalization.sentences,
    textAlign: TextAlign.start,
    autocorrect: true,
    validator: validator as String? Function(String?)?,
    obscureText: obscureText,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      suffixIcon: Icon(suffixIcon),
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

//reusable texts
// big Text
Text showBigText({
  required String text,
  required FontWeight fontWeight,
}) {
  return Text(
    text,
    style: TextStyle(
      color: bigTextcolor,
      fontSize: 22,
      fontWeight: fontWeight,
    ),
  );
}

// medium text
Text mediumText({
  required String text,
  required FontWeight fontWeight,
}) {
  return Text(
    text,
    style: TextStyle(
      color: mediumTextcolor,
      fontSize: 18,
      fontWeight: fontWeight,
    ),
  );
}

//small Text
Text smallText({
  required String text,
  required FontWeight fontWeight,
}) {
  return Text(
    text,
    style: TextStyle(
      color: smallTextcolor,
      fontSize: 16,
      fontWeight: fontWeight,
    ),
  );
}

// reusable  buttons
// Outlined buttons
Widget showOutlinedButton({
  required Function() function,
  required String text,
}) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: outlinedButtonColors,
      ),
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// reusable  spacing
// Large space
Widget showLargespace() {
  return const SizedBox(
    height: 20,
  );
}

// medium space
Widget showmediumspace() {
  return const SizedBox(
    height: 15,
  );
}

// small space
Widget showsmallspace() {
  return const SizedBox(
    height: 20,
  );
}
