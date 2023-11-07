
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class searchWudgets extends StatelessWidget {
  const searchWudgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 47,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(decoration: InputDecoration(
          fillColor: Colors.black12.withOpacity(0.1),
          filled: true,

          hintText: "Search For Product",
          border: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset('assets/icons/search.svg',width: 10,),
          ),
        ),),
      ),
    );
  }
}


