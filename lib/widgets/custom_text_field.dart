import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/size_config.dart';

class CustomTextFiled extends StatefulWidget {
  final bool isPass;
  final String labelText;
  final TextEditingController controller;
  final bool isEnable;
  final String Function(String) validator;

  // final IconButton iconButton;

  const CustomTextFiled({
    Key key,
    this.isPass,
    this.labelText,
    this.controller,
    this.isEnable,
    this.validator,
    // this.iconButton
  }) : super(key: key);

  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    if (widget.isPass) {
      _showPassword = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    return Container(
      width: SizeConfig.widthMultiplier * 95,
      height: 60,
      decoration: BoxDecoration(
        color: CustomColor.backGround,
        border: Border.all(
          color: CustomColor.textFieldBorderColor,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
        child: TextFormField(
          //onSaved: widget.onChanged,
          validator: widget.validator,
          enabled: widget.isEnable,
          controller: widget.controller,
          obscureText: _showPassword,
          focusNode: focusNode,
          cursorColor: CustomColor.backGround,
          decoration: InputDecoration(

              //suffix: widget.iconButton,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon: widget.isPass
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          focusNode.unfocus();
                          focusNode.canRequestFocus = false;
                          _showPassword = !_showPassword;
                        });
                      },
                      child:
                          // Icon(
                          _showPassword
                              ? const Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image(
                                    image: AssetImage("assets/icon/Show.png"),
                                    height: 15,
                                    width: 15,
                                  ),
                                )
                              : const Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image(
                                    image: AssetImage("assets/icon/Hide.png"),
                                    height: 15,
                                    width: 15,
                                  ),
                                  // ),
                                  // _showPassword?Icons.visibility:Icons.visibility_off,
                                  // color: Colors.grey,
                                ),
                    )
                  : const SizedBox(),
              filled: true,
              fillColor: CustomColor.backGround,
              labelText: widget.labelText,
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              contentPadding:
                  const EdgeInsets.only(left: 20, top: 15, bottom: 15)),
        ),
      ),
    );
  }
}
