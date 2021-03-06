import 'package:flutter/material.dart';
import 'package:heath_care/model/result.dart';
import 'package:heath_care/repository/result_repository.dart';
import 'package:intl/intl.dart';

class TestResultScreen extends StatefulWidget {
  const TestResultScreen({Key? key}) : super(key: key);

  @override
  _TestResultScreenState createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  _TestResultScreenState() {
    ResultRepository().getAllResultCurrentUserId().then((val) => setState(() {
          _resultsList = val!;
        }));
  }

  final df = new DateFormat('dd-MM-yyyy');
  List<Result>? _resultsList;
  Result? _selectedResult = new Result();
  @override
  Widget build(BuildContext context) {
    return _resultsList != null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(78, 159, 193, 1),
              title: Text("KẾT QUẢ XÉT NGHIỆM"),
            ),
            body: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                    elevation: 1,
                    margin: EdgeInsets.only(bottom: 3),
                    child: ListTile(
                        title: Text("Lần xét nghiệm: "),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        trailing: DropdownButtonHideUnderline(
                            child: DropdownButton(
                          isExpanded: false,
                          items: _resultsList!.map((Result value) {
                            return DropdownMenuItem<Result>(
                              value: value,
                              child: Text(
                                value.numberTest.toString(),
                              ),
                            );
                          }).toList(),
                          onChanged: (Result? value) {
                            setState(() {
                              _selectedResult = value!;
                            });
                          },
                          hint: Align(
                            alignment: Alignment.centerRight,
                            child: _selectedResult!.numberTest != null
                                ? Text(
                                    _selectedResult!.numberTest.toString(),
                                    style: TextStyle(color: Colors.grey),
                                  )
                                : Text(
                                    "Chọn lần xét nghiệm",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                          ),
                          style: TextStyle(
                              color: Colors.black, decorationColor: Colors.red),
                        )))),
              ),
              _selectedResult!.numberTest != null
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 300,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(78, 159, 193, 0.3),
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
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Đơn vị gửi mẫu (nếu có): ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: _selectedResult!.unitName!
                                            .toString()),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Ngày lấy mẫu: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: df.format(
                                            _selectedResult!.collectDate!)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Ngày xét nghiệm: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: df.format(
                                            _selectedResult!.testDate!)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Loại bệnh phẩm: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: _selectedResult!.sampleType!.name
                                            .toString()),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Tình trạng mẫu: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    if (_selectedResult!.status == 1)
                                      TextSpan(text: 'Đạt')
                                    else
                                      TextSpan(text: 'Không Đạt')
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Kết quả xét nghiệm: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    if (_selectedResult!.testResult == 1)
                                      TextSpan(text: 'Dương tính')
                                    else if (_selectedResult!.testResult == 0)
                                      TextSpan(text: 'Âm tính')
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Ghi chú: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: _selectedResult!.comment),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Center(child: Text("Chọn lần xét nghiệm"))
            ]))
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
