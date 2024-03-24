// reusable Textformfields
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker_codsoft/Widgets/colors.dart';

TextFormField showTextFormField({
  required TextEditingController controller,
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
    textCapitalization: TextCapitalization.sentences,
    textAlign: TextAlign.start,
    autocorrect: true,
    obscureText: obscureText,
    decoration: InputDecoration(
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
Text mediumBigText({
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
Text smallBigText({
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
  return OutlinedButton(
    onPressed: function,
    child: Text(
      text,
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
