import 'package:flutter/material.dart';
import 'package:flutter_estudos/shared/app_images.dart';

class ListViewHorizontal extends StatelessWidget {
  const ListViewHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.user1,
                        height: 100,
                      ),
                      const Text('User 1')
                    ],
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.user2,
                        height: 100,
                      ),
                      const Text('User 2')
                    ],
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.user3,
                        height: 100,
                      ),
                      const Text('User 3')
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
