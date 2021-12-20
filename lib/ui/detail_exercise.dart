import 'package:flutter/material.dart';
import 'package:heath_care/model/exercise.dart';
import 'package:heath_care/model/exercise_detail.dart';
import 'package:heath_care/repository/exercise_detail_repository.dart';
import 'package:heath_care/repository/exercise_repository.dart';
import 'package:heath_care/utils/api.dart';

class DetailScreenExcercise extends StatefulWidget {
  const DetailScreenExcercise({Key? key, required this.ExerciseId})
      : super(key: key);
  final int ExerciseId;

  @override
  _DetailScreenExcerciseState createState() =>
      _DetailScreenExcerciseState(ExerciseId);
}

class _DetailScreenExcerciseState extends State<DetailScreenExcercise> {
  Exercise ex = new Exercise();
  List<ExerciseDetail> exDetail = [];
  final int ExerciseId;

  _DetailScreenExcerciseState(this.ExerciseId) {
    ExerciseRepository().getExerciseById(ExerciseId).then((val) => setState(() {
          ex = val;
        }));
    ExerciseDetailRepository()
        .getDetailExercise(ExerciseId)
        .then((vall) => setState(() {
              exDetail = vall;
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (ex.name == null) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
            title: Text("Chi Tiết Bài Tập"),
          ),
          body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: Text("Chi Tiết Bài Tập"),
        ),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20.10),
                  child: Text(ex.name.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      )),
                ),

                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.10),
                    child: Text(ex.description.toString(),
                        style: TextStyle(

                          fontSize: 18,
                        )),
                  ),

                ),

              ],
            ),

            Padding(
              padding: const EdgeInsets.all(30.20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("HƯỚNG DẪN",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    )),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: exDetail.length,
                itemBuilder: (BuildContext context, int index) {
                  if (exDetail.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                   return  Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        exDetail[index].imageDescription != null
                        ? Image.network(
                          Api.imageUrl +
                              exDetail[index]
                                  .imageDescription
                                  .toString(),
                          fit: BoxFit.cover,
                        )
                        : SizedBox(height: 0,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              exDetail[index].description.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              exDetail[index].detail.toString()),
                        ),
                      ],
                    );


                  }
                })

          ],
        ),
      );
    }
  }
}
