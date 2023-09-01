import 'package:flutter/material.dart';
import 'package:flutter_estudos/shared/app_images.dart';

class ImageAssetsPage extends StatefulWidget {
  const ImageAssetsPage({super.key});

  @override
  State<ImageAssetsPage> createState() => _Pagina1State();
}

class _Pagina1State extends State<ImageAssetsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.user1,
          height: 75,
        ),
        Image.asset(
          AppImages.user2,
          height: 75,
        ),
        Image.asset(
          AppImages.user3,
          height: 75,
        ),
      ],
    );
  }
}
