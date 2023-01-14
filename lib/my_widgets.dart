import 'package:flutter/material.dart';

class WaitServer extends StatelessWidget {
  const WaitServer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ErrorServer extends StatelessWidget {
  const ErrorServer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red),
          Text("errInDb"),
        ],
      ),
    );
  }
}

class TheresNotData extends StatelessWidget {
  const TheresNotData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Theres not data"),
        ],
      ),
    );
  }
}



