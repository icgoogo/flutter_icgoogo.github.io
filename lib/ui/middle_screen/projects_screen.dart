import 'package:flutter/material.dart';
import 'package:icgoogo/const/images_path.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  ProjectsScreenState createState() => ProjectsScreenState();
}

class ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(10, 10),
                ),
              ],
            ),
            child: Material(
              color: Colors.red,
              child: InkWell(
                child: Image.asset(me),
                onTap: () {},
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text("Ceria"),
        ],
      ),
    );
  }
}
