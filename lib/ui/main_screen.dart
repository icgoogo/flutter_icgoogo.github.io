import 'package:flutter/material.dart';
import 'package:icgoogo/const/images_path.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/bottom_game.dart';
import 'components/custom_button.dart';
import 'components/grid_projects.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  bool isProjectsOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: ListView(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Container(
              height: 200.0,
              width: 200.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  scale: 7.0,
                  alignment: Alignment(0, 0.3),
                  image: AssetImage(me),
                  fit: BoxFit.none,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              "Hello There",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.apply(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                "I'm Hammad, any inquiries? email me through \n\nhammadsyr@gmail.com",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.apply(
                      color: Colors.white,
                    ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            // Show Projects Grid or standard social navigation buttons
            if (isProjectsOpened) ...[
              CustomButton(
                bgColor: Colors.redAccent,
                title: Text(
                  "Home",
                  style: Theme.of(context).textTheme.bodyMedium?.apply(
                        color: Colors.white,
                      ),
                ),
                onTap: () {
                  setState(() {
                    isProjectsOpened = false;
                  });
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              const GridProjects(),
            ] else ...[
              CustomButton(
                bgColor: Colors.lightGreen,
                title: Text(
                  "Projects/Portfolio",
                  style: Theme.of(context).textTheme.bodyMedium?.apply(
                        color: Colors.white,
                      ),
                ),
                onTap: () {
                  setState(() {
                    isProjectsOpened = true;
                  });
                },
              ),
              const SizedBox(
                height: 60.0,
              ),
              CustomButton(
                bgColor: Colors.deepOrange,
                title: Text(
                  "Stack Overflow",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.apply(
                        color: Colors.white,
                      ),
                ),
                onTap: () async {
                  Uri url = Uri.parse(
                      "https://stackoverflow.com/users/10898364/hammadsyr");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw "could not launch $url";
                  }
                },
              ),
              const SizedBox(
                height: 60.0,
              ),
              CustomButton(
                bgColor: Colors.blueAccent,
                title: Text(
                  "Linkedin",
                  style: Theme.of(context).textTheme.bodyMedium?.apply(
                        color: Colors.white,
                      ),
                ),
                onTap: () async {
                  Uri url =
                      Uri.parse("https://www.linkedin.com/in/hammad-syarif/");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw "could not launch $url";
                  }
                },
              ),
              const SizedBox(
                height: 60.0,
              ),
              CustomButton(
                bgColor: Colors.black,
                title: Text(
                  "Github",
                  style: Theme.of(context).textTheme.bodyMedium?.apply(
                        color: Colors.white,
                      ),
                ),
                onTap: () async {
                  Uri url = Uri.parse("https://github.com/icgoogo");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw "could not launch $url";
                  }
                },
              ),
            ],
            const SizedBox(
              height: 30.0,
            ),
            const SizedBox(
              height: 400.0,
              child: BottomGame(),
            ),
          ],
        ),
      ),
    );
  }
}
