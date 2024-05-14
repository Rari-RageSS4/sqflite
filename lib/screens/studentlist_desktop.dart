
import 'package:flutter/material.dart';
import 'package:sqflite_db/screens/profilescreen_desktop.dart';
import '../../../db/functions/db_functions.dart';
import '../../../db/model/data_model.dart';

class StudentlistDesktop extends StatefulWidget {
  const StudentlistDesktop({super.key});

  @override
  State<StudentlistDesktop> createState() => _StudentlistDesktopState();
}

class _StudentlistDesktopState extends State<StudentlistDesktop> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<StudentModel> searchedStudent = [];

  @override
  void initState() {
    DBFunctions.instance.getAllStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          if (studentList.isEmpty) {
            return const Center(
              child: Text(
                "Student list is empty",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          if (isSearching &&
              searchController.text.isNotEmpty &&
              searchedStudent.isEmpty) {
            return const Center(
              child: Text(
                "No student found",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 220,
              crossAxisCount: 4,
              childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 20.0,
                ),
            itemBuilder: (_, index) {
              final StudentModel data;
              if (isSearching &&
                  searchedStudent.isNotEmpty &&
                  searchController.text.isNotEmpty) {
                data = searchedStudent[index];
              } else {
                data = studentList[index];
              }
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfilescreenDesktop(data: data, index: index), 
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    ),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: NetworkImage('https://purepng.com/public/uploads/large/purepng.com-ninjashinobininjacovert-agentassassinationguerrilla-warfaresamuraiclip-art-1421526960633owjjy.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              data.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteStudentAlert(context, data.id!);
                            },
                            color: Colors.red,
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: isSearching && searchController.text.isNotEmpty
                ? searchedStudent.length
                : studentList.length,
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: const BackButton(
        color: Colors.white,
      ),
      toolbarHeight: 75,
      backgroundColor: const Color.fromARGB(255, 169, 63, 255),
      centerTitle: true,
      title: isSearching
          ? TextFormField(
              controller: searchController,
              onChanged: (value) {
                searchedStudent.clear();
                for (var student in studentListNotifier.value) {
                  if (student.name
                      .toLowerCase()
                      .contains(value.toLowerCase())) {
                    searchedStudent.add(student);
                  }
                }
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            )
          : const Text('Student list',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white
            ),
          ),
      actions: [
        IconButton(
          color: Colors.white,
          onPressed: () {
            setState(() {
              isSearching = !isSearching;
            });
          },
          icon:
              isSearching ? const Icon(Icons.close) : const Icon(Icons.search),
        ),
        const SizedBox(width: 20,)
      ],
    );
  }

  Future<void> deleteStudentAlert(context, int id) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Are you sure want to delete ?'),
          actions: [
            TextButton(
                onPressed: () async {
                  await DBFunctions.instance.deleteStudent(id);
                  Navigator.of(context).pop();
                  showSnackbar();
                },
                child: const Text('Yes')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            
          ],
        );
      },
    );
  }

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deleted successfully'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
      ),
    );
  }
}