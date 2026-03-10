import 'package:flutter/material.dart';

class TextfieldComp extends StatefulWidget {

  final controller;
  final String hintText;
  final bool isPassword; 
  final String? errorText;

  const TextfieldComp({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isPassword,
    this.errorText,
    });

  @override
  State<TextfieldComp> createState() => _TextfieldCompState();
}

class _TextfieldCompState extends State<TextfieldComp> {

  late bool _obsureText;

  @override
  void initState(){
    super.initState();
    _obsureText = widget.isPassword;
  }


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _obsureText,
          decoration: InputDecoration(
                errorText: widget.errorText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 187, 178, 178)),
              //borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: UnderlineInputBorder( //กดที่ textfield แล้วจะเปลี่ยนสี
              borderSide: BorderSide(color: Color.fromARGB(214, 0, 0, 0)),
              //borderRadius: BorderRadius.circular(15),
            ),
            hintText: widget.hintText,
         

            suffixIcon: widget.isPassword
            ? IconButton(
              icon: Icon(
                _obsureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: (){
                setState(() {
                  _obsureText = !_obsureText;
                });
              },
              )
              :null,
          ),

      ),
      );
  }
}