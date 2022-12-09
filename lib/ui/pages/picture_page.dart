import 'package:flutter/material.dart';

import 'login_page.dart';

class PicturePage extends StatelessWidget {
  const PicturePage({Key? key, required this.isSuccessfulEntry})
      : super(key: key);

  final bool isSuccessfulEntry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(isSuccessfulEntry
            ? 'https://skr.sh/s/250422/xnoyYOGB.png?download=1&name=%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%2008-12-2022%2017:33:22.png'
            : 'https://skr.sh/s/250422/zJXaVrly.png?download=1&name=%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%2008-12-2022%2017:32:24.png'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
