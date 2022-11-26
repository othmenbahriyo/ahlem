import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/strings/colors_proj.dart';


class RoundedButton extends StatelessWidget {
  final String? text;
  final Function? press;
  final double fontsize;
  final double verticalPadding;
  final Function? onPressed;
  final Color? color, textColor;
  const RoundedButton({
    Key? key,
    this.text,
    this.press,
    this.onPressed,
    this.verticalPadding = 16,
    this.fontsize = 16,  
    this.color = KPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var kPrimaryColor;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
  
    return ElevatedButton(
      child: Text(
        text!,
        style: TextStyle(color: textColor,fontSize: fontsize),
        
      ),
      onPressed: ()=>onPressed!.call()
      
      
    );
  }
}