import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Cung cấp một hàm để xử lý các tuyến được đặt tên. 
        //Sử dụng chức năng này để xác định tuyến đường được đặt tên đang được đẩy và tạo chính xác màn
        onGenerateRoute: (settings) {
          // Nếu bạn đẩy tuyến PassArgument
          if (settings.name == PassArgumentsScreen.routeName) {
            // Truyền các đối số sang đúng loại: ScreenArgument.
            final ScreenArguments args = settings.arguments;

            // Sau đó, trích xuất dữ liệu cần thiết từ các đối số và truyền dữ liệu đến đúng màn hình.
            return MaterialPageRoute(
              builder: (context) {
                return PassArgumentsScreen(
                  title: args.title,
                  message: args.message,
                );
              },
            );
          }
          
          // Mã chỉ hỗ trợ PassArgumentScreen.routeName ngay bây giờ.
          // Các giá trị khác cần được thực hiện nếu chúng ta thêm chúng. Khẳng định
          // ở đây sẽ giúp nhắc nhở chúng ta về điều đó cao hơn trong ngăn xếp cuộc gọi, vì
          // xác nhận này nếu không sẽ bắn ở đâu đó trong khung
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
        title: 'Navigation with Arguments',
        home: HomeScreen(),
        routes: {
          ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
        });
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Một nút điều hướng đến một tuyến đường được đặt tên đó.
            // Tuyến đường được đặt tên trích xuất các đối số của chính nó.
            RaisedButton(
              child: Text("Navigate to screen that extracts arguments"),
              onPressed: () {
                // Khi người dùng nhấn nút, điều hướng đến một tuyến đường được đặt tên
                // và cung cấp các đối số dưới dạng tham số tùy chọn.
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Extract Arguments Screen',
                    'This message is extracted in the build method.',
                  ),
                );
              },
            ),
            
            // Một nút điều hướng đến một tuyến đường được đặt tên. Đối với tuyến đường này, giải nén
            // các đối số trong hàm onGenerateRoute và truyền chúng
            // vào màn hình.
            RaisedButton(
              child: Text("Navigate to a named that accepts arguments"),
              onPressed: () {
                // Khi người dùng nhấn nút, điều hướng đến một tuyến đường được đặt tên
                // và cung cấp các đối số dưới dạng tham số tùy chọn.
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Accept Arguments Screen',
                    'This message is extracted in the onGenerateRoute function.',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


// Một widget trích xuất các đối số cần thiết từ ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Trích xuất các đối số từ cài đặt ModalRoute hiện tại và truyền chúng là ScreenArgument.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

// Một Widget chấp nhận các đối số cần thiết thông qua hàm tạo.
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  // Widget này chấp nhận các đối số làm tham số constructor.
  // Nó không trích xuất các đối số từ ModalRoute.
  // Các đối số được trích xuất bởi hàm onGenerateRoute được cung cấp cho
  // widget vật liệu
  const PassArgumentsScreen({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}


// Truyền bất kỳ đối tượng nào vào tham số đối số. 
// Trong ví dụ này,tạo một lớp chứa cả tiêu đề và thông báo có thể tùy chỉnh.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
