import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/strings/colors_proj.dart';
import 'package:flutter_svg/svg.dart';


class SocalInput extends StatelessWidget {
  final String iconSrc;
  final press;
  const SocalInput({
    Key? key, 
    required this.iconSrc, 
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
           border: Border.all(
             width: 2,
             color: KPrimaryLightColor,
           ),
           shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
