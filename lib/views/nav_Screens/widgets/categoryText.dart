import 'package:flutter/cupertino.dart';

class categoryText extends StatelessWidget {
  const categoryText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Category",style: TextStyle(fontSize: 19),),
    );
  }
}
