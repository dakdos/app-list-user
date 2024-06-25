import 'package:flutter/material.dart';
import '/config/export.dart';

class ImageProfile extends StatelessWidget {
  final String? image;
  const ImageProfile(
    {required this.image, Key? key}
  ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(borderRadius: BorderRadius.circular(60),
          child: CachedNetworkImage(
            imageUrl: image!,
            placeholder: (context, url) => SkeletonAnimation(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[300],
                ),
              ),
            ),
            height: 55,
            width: 55,
            fit: BoxFit.cover,
          )
        ),
      ],
    );
  }
}