import 'package:flutter/material.dart';
import 'package:heath_care/model/request.dart';
import 'package:heath_care/repository/request_repository.dart';
import 'package:intl/intl.dart';

class MyRequestScreen extends StatefulWidget {
  const MyRequestScreen({Key? key}) : super(key: key);

  @override
  _MyRequestScreenState createState() => _MyRequestScreenState();
}

class _MyRequestScreenState extends State<MyRequestScreen> {
  final df = new DateFormat('dd-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: Text("DANH SÁCH YÊU CẦU"),
        ),
        body: FutureBuilder<List<Request>?>(
            future: RequestRepository().getRequestByUser(),
            builder: (context, requestAllSnapshot) {
              if (requestAllSnapshot.hasData) {
                return ListView.builder(
                    itemCount: requestAllSnapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(78, 159, 193, 0.9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Ngày yêu cầu: : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: df.format(requestAllSnapshot
                                              .data![index].date!)),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Loại yêu cầu: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: requestAllSnapshot.data![index]
                                              .requestType!.requestTypeName),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Nội dung: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: requestAllSnapshot
                                              .data![index].description),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Ghi Chú: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: requestAllSnapshot
                                              .data![index].note),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Tình trạng yêu cầu: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(text: ""),
                                        ],
                                      ),
                                    ),
                                    requestAllSnapshot.data![index].status == 1
                                        ? Text("Chấp thuận",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    3, 99, 8, 1)))
                                        : (requestAllSnapshot
                                                    .data![index].status ==
                                                2
                                            ? Text("Đang chờ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.yellow))
                                            : Text("Từ chối",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red)))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text("Bạn chưa có yêu cầu nào!"),
                );
              }
            }));
  }
}
