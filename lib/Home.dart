import 'dart:convert';

import 'package:devsecit_news/config.dart';
import 'package:devsecit_news/single.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List posts = [];
  _getPOSTS() async {
    http.Response resp = await http.get(Uri.parse(APP_SERVER + '?genme=true'));
    if (resp.body.toString() != false) {
      try {
        posts = jsonDecode(resp.body);
        setState(() {});
        print("Server response - " + resp.body.toString());
      } catch (e) {}
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getPOSTS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME),
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                _getPOSTS();
              },
              icon: Icon(Icons.replay_outlined))
        ],
      ),
      body: posts.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  title: Text(posts[i]['post_title']),
                  subtitle: Text(posts[i]['date']),
                  leading: posts[i]['thumbnail'].toString().length > 3
                      ? Container(
                          height: 60,
                          width: 60,
                          child:
                              Image(image: NetworkImage(posts[i]['thumbnail'])))
                      : Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          child: Icon(Icons.access_alarms_sharp)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SingleManush(
                                photo: posts[i]['thumbnail'],
                                date: posts[i]['date'],
                                title: posts[i]['post_title'],
                                description: posts[i]['post_content'])));
                  },
                );
              },
            ),
    );
  }
}
