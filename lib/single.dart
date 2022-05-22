import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class SingleManush extends StatefulWidget {
  var photo, title, date, description;
  SingleManush(
      {required this.photo,
      required this.date,
      required this.title,
      required this.description,
      Key? key})
      : super(key: key);

  @override
  State<SingleManush> createState() => _SingleManushState();
}

class _SingleManushState extends State<SingleManush> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          widget.photo.toString().length > 3
              ? Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  child: Image(image: NetworkImage(widget.photo)))
              : Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  child: Icon(Icons.access_alarms_sharp)),
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 18),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 26),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 26),
            child: Text(
              widget.date,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, bottom: 30),
            child: HtmlWidget(widget.description),
          ),
        ],
      ),
    );
  }
}
