import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final bool? obscureText;
  final Widget icon;
  final Widget? iconSuf;
  final Function? validtor;

  const AppTextFormField(
      {Key? key, required this.controller, this.hint, this.label, this.obscureText, required this.icon, this.iconSuf, this.validtor})
      : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late Widget sufix;

  Widget changeIconPassword(){
    if(widget.obscureText==true) {
      setState(() {
      sufix= Icon(Icons.remove_red_eye);
      widget.obscureText==true;
      });
    }
      else{
     setState(() {
       widget.obscureText==false;

       sufix=Icon(Icons.remove_red_eye_outlined);
     });
    }
      return SizedBox();

  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        prefixIcon: widget.icon,
        suffix:widget.obscureText==true?widget.iconSuf:SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      obscureText: widget.obscureText??false,


    );
  }
}
