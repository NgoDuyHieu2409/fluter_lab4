import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // Bắt đầu ứng dụng với tuyến đường có tên "/". Trong trường hợp này, ứng dụng bắt đầu trên tiện ích FirstScreen.
    initialRoute: '/',
    routes: {
      // Khi điều hướng đến tuyến đường "/", hãy tạo tiện ích FirstScreen.
      '/': (context) => FirstScreen(),
      // Khi điều hướng đến tuyến đường "/second", hãy tạo tiện ích SecondScreen.
      '/second': (context) => SecondScreen(),
    },
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Điều hướng đến màn hình thứ hai bằng cách sử dụng một tuyến đường được đặt tên.
            Navigator.pushNamed(context, '/second');
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Điều hướng quay lại màn hình đầu tiên bằng cách bật tuyến đường hiện tại
            // Tắt ngăn xếp.
            Navigator.pop(context);
            },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}