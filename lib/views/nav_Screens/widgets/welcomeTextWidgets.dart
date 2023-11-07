import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class welcomeWidgets extends StatelessWidget {
  const welcomeWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12,),
          child: Text("Hello , What Are You \n Looking For..",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
        ),
        Container(child: SvgPicture.asset('assets/icons/cart.svg',width: 20,),)
      ],);
  }
}