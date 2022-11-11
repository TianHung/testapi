import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'models/post.dart';
import 'network/network_request.dart';

void main() {
  runApp(TestApi());
}

class TestApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestApi Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListViewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ListViewPage extends StatefulWidget {
  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  late List<Post> postData=[];

  @override
  void initState() {
    super.initState();
    NetworkRequest.fetchPosts().then((dataFromSever) {
      setState(() {
        postData = dataFromSever;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HTTP Request")),
      body: Column(
        children: [
          Expanded(
            child: Container(color: Colors.yellow,
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: postData.length,
              itemBuilder: (context, index) {

                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${postData[index].id} . ${postData[index].title}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${postData[index].body}",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          )],
      ),
    );
  }
}
