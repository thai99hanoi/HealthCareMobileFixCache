import 'package:flutter/material.dart';
import 'package:heath_care/model/exercise.dart';
import 'package:heath_care/model/medicine.dart';
import 'package:heath_care/model/report.dart';
import 'package:heath_care/model/report_dto.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/exercise_repository.dart';
import 'package:heath_care/repository/medicine_repository.dart';
import 'package:heath_care/repository/report_dto_repository.dart';
import 'package:heath_care/repository/symptom_repository.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/main_screen.dart';
import 'package:intl/intl.dart';
import 'components/NavSideBar.dart';

class NextScreenReport extends StatefulWidget {
  final ReportDTO reportDTO;
  const NextScreenReport({Key? key, required this.reportDTO}) : super(key: key);

  @override
  State<NextScreenReport> createState() => _NextScreenReportState(reportDTO);
}

class _NextScreenReportState extends State<NextScreenReport> {
  List<int?>? _selectedExercise = [];
  List<Exercise> _allExercise = [];
  List<int?>? _selectedMedicine = [];
  List<Medicine> _allMedicine = [];
  User _profile = new User();
  List<Report> reports = [];
  ReportDTO reportDTO;
  DateFormat f = new DateFormat('hh:mm:ss');
  DateFormat sdf = new DateFormat('yyyy-MM-dd');
  DateTime? startTime;
  DateTime? midTime;
  DateTime? endTime;
  DateTime? now;
  DateTime? today;
  _NextScreenReportState(this.reportDTO) {
    ExerciseRepository().getAllExercises().then((val) => setState(() {
          _allExercise = val!;
        }));
    MedicineRepository().getAllMedicine().then((val) => setState(() {
          _allMedicine = val!;
        }));
    UserRepository().getCurrentUserWithoutCache().then((val) => setState(() {
      _profile = val;
    }));
    ReportDTORepository().getReport(_profile.userId!).then((val) => setState(() {
      reports = val;
    }));
    startTime = f.parse("00:00:00");
    midTime = f.parse("12:00:00");
    endTime = f.parse("24.00.00");
    now = f.parse(DateTime.now().toString());
    today = f.parse(DateTime.now().toString());
  }
  Future save() async {
    Report report = reports.last;
    var _response;
    DateTime dateReport = sdf.parse(report.date.toString());
    DateTime timeReport = f.parse(report.time.toString());
    if (dateReport.isAtSameMomentAs(today!)){
      if ((timeReport.isAfter(startTime!) && timeReport.isBefore(midTime!)) && (now!.isAfter(startTime!) && now!.isBefore(midTime!))) {
        _showerrorDialog("Bạn đã gửi báo cáo vào buổi sáng!");
      } else if ((timeReport.isAfter(midTime!) && timeReport.isBefore(endTime!)) && (now!.isAfter(midTime!) && now!.isBefore(endTime!))) {
        _showerrorDialog("Bạn đã gửi báo cáo vào buổi chiều!");
      } else {
        _response = await ReportDTORepository().createReport(reportDTO);
      }
    } else {
      _response = await ReportDTORepository().createReport(reportDTO);
    }
    print(_response);
    if (_response.toString().contains("CREATE_REPORT_SUCCESS")) {
      showAlertDialog(context);
    } else if (_response.toString().contains("FAIL")) {
      _showerrorDialog("Gửi Báo Cáo Không Thành Công");
    } else {
      _showerrorDialog("Xảy ra lỗi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: const Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
        ),
        body: ListView(children: [
          const Padding(
            padding: EdgeInsets.all(20.10),
            child: Text("Báo Cáo Bài Tập Hàng Ngày",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: _allExercise.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                      title: Text(_allExercise[index].name.toString()),
                      trailing: Checkbox(
                          value: _allExercise[index].isCheck,
                          onChanged: (bool? val) {
                            setState(() {
                              _allExercise[index].isCheck =
                                  !_allExercise[index].isCheck;
                              if (_allExercise[index].isCheck) {
                                _selectedExercise!.add(_allExercise[index].id);
                                reportDTO.exerciseId = _selectedExercise;
                              } else {
                                _selectedExercise!.remove(
                                    _allExercise[index].name.toString());
                              }
                            });
                          }))
                  // Text(symptomAll.data![index].name.toString())
                  ;
            },
          ),
          const Padding(
            padding: EdgeInsets.all(20.10),
            child: Text("Báo Cáo Thuốc Hàng Ngày",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: _allMedicine.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                      title: Text(_allMedicine[index].name.toString()),
                      trailing: Checkbox(
                          value: _allMedicine[index].isCheck,
                          onChanged: (bool? val) {
                            setState(() {
                              _allMedicine[index].isCheck =
                                  !_allMedicine[index].isCheck;
                              if (_allMedicine[index].isCheck) {
                                _selectedMedicine!.add(_allMedicine[index].id);
                                reportDTO.medicineId = _selectedMedicine;
                              } else {
                                _selectedMedicine!.remove(
                                    _allMedicine[index].name.toString());
                              }
                            });
                          }))
                  // Text(symptomAll.data![index].name.toString())
                  ;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: RaisedButton(
              color: Color.fromRGBO(78, 159, 193, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              onPressed: () {
                save();
              },
              child: Text(
                'Gửi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            )),
          ),
        ]),
        drawer: NavDrawer());
  }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An Error Occurs',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Thành Công"),
    content: Text("Báo cáo đã được gửi thành công, quay lại trang chủ."),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
