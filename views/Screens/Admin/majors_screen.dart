import 'package:flutter/material.dart';
import 'package:flutter_cvmaker/models/major_model.dart';
import 'package:flutter_cvmaker/view_model/major_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MajorScreen extends StatefulWidget {
  const MajorScreen({super.key});

  @override
  State<MajorScreen> createState() => _MajorScreenState();
}

class _MajorScreenState extends State<MajorScreen> {
  MajorViewModel viewModel = MajorViewModel();

  addMajor(context) async {
    TextEditingController _majorNameController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          String text = "";
          return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                  title: Text(
                    " اضافة تخصص",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  content: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            maxLines: 2,
                            controller: _majorNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              labelText: 'اسم التخصص',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'يرجى ادخال اسم التخصص';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                EasyLoading.show(status: 'جاري التنفيذ...');
                                try {
                                  viewModel.addMajor(MajorModel(
                                      enteredDate: DateTime.now().toString(),
                                      name: _majorNameController.text));
                                  Navigator.pop(context);
                                  Future.delayed(
                                      const Duration(milliseconds: 2000), () {
                                    EasyLoading.showSuccess("تم الحفظ");
                                  });
                                  EasyLoading.dismiss();
                                } catch (e) {
                                  EasyLoading.dismiss();
                                }
                              }
                            },
                            color: Color(0xffffffff),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(
                                  color: Color(0xff02cbff), width: 1),
                            ),
                            child: Text(
                              "اضافة",
                            ),
                            textColor: Color(0xff000000),
                            height: 40,
                            minWidth: 140,
                          ),
                        ],
                      ),
                    ),
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(),
          body: StreamBuilder(
            stream: viewModel.getAllMajors(),
            builder: (context, AsyncSnapshot<List<MajorModel>> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("there is an error"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData) {
                return Center(child: Text("لا  توجد طلبات انضمام  "));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var major = snapshot.data![index];
                    return Card(
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            // leading: Text("ادارة التطبيق"),
                            title: Text("اسم التخصص: ${major.name} "),
                            subtitle:
                                Text('تاريخ الاضافة: ${major.enteredDate} '),
                            trailing: InkWell(
                                onTap: () {
                                  viewModel.deleteMajor(major);
                                },
                                child: Icon(Icons.delete)),
                          ),
                        ],
                      ),
                      elevation: 10,
                    );
                  },
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                addMajor(context);
              },
              child: Icon(Icons.add)),
        ));
  }
}
