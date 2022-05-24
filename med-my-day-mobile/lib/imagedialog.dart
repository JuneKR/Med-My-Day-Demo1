import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 300,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/1.png'),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}

class ImageDialog2 extends StatelessWidget {
  const ImageDialog2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 300,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/mock.jpg'),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}