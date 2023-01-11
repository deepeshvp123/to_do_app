import 'dart:html';
import 'dart:js_util';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/models/modeltask.dart';
import 'package:to_do_app/utilts/colors.dart';
import 'package:to_do_app/utilts/constant.dart';
import 'package:to_do_app/utilts/string.dart';
import 'package:to_do_app/views/task/taskview.dart';
import 'package:to_do_app/widgets/taskwidget.dart';
import 'package:hive_flutter/adapters.dart';

class homescreen extends StatefulWidget {
  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  GlobalKey<SliderDrawerState> dkey = GlobalKey<SliderDrawerState>();
  //checking done task
  int checkdowntask(List<modeltask> task) {
    int i = 0;
    for (modeltask donetasks in task) {
      if (donetasks.iscompleted) {
        i++;
      }
    }
    return i;
  }

//checkinmg the value of  the circle indicator
  dynamic valueoftheindicator(List<modeltask> task) {
    if (task.isEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Main = BaseWidget.of(context);
    var texttheme = Theme.of(context).textTheme;
    return ValueListenableBuilder(
      valueListenable: Main.dataStore.listenToTask(),
      builder: (ctx, Box<modeltask> box, Widget? child) {
        var tasks = box.values.toList();
        //sort task list
        tasks.sort(((a, b) => a.createdatdate.compareTo(b.createdatdate)));
        return Scaffold(
          backgroundColor: Colors.white,
          //floating action button
          floatingActionButton: fab(),
          body: SliderDrawer(
            slider: myslider(),
            child: buildbody(
              tasks,
              Main,
              texttheme,
            ),
            isDraggable: false,
            key: dkey,
            animationDuration: 1000,
          ),
        );
      },
    );
  }

  //main body
  SizedBox buildbody(
      List<modeltask> tasks, BaseWidget Main, TextTheme textTheme) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(55, 0, 0, 0),
            height: 100,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //circular progress indicator
                SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(mycolor.primarycolor),
                    backgroundColor: Colors.grey,
                    value: checkdowntask(tasks) / valueoftheindicator(tasks),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                //texts
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MyString.mainTitle,
                      style: textTheme.headline1,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                   Text("${checkdowntask(tasks)} of ${tasks.length} task",
                      style: textTheme.subtitle1,
                    )
                  ],
                )
              ],
            ),
          ),
          //divider
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),
          //bottom:listview task
          SizedBox(
              width: double.infinity,
              height: 585,
              child: tasks.isNotEmpty
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        var task = tasks[index];
                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                MyString.deleteTask,
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          onDismissed: (direction) {
                            Main.dataStore.dalateTask(task: task);
                          },
                          key: Key(task.id),
                          child: taskwidget(task: tasks[index]),
                        );
                      })
                  //if all tasks done show this widgets
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //lottie
                        FadeIn(
                            child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            "assets/lottie/131659-gifts-and-rewards.json",
                            animate: tasks.isNotEmpty ? false : true,
                          ),
                        )),
                        //bottom texts
                        FadeInUp(
                          child: Text(MyString.doneAllTask),
                          from: 30,
                        )
                      ],
                    )),
        ],
      ),
    );
  }
}

// my drower slider
class myslider extends StatelessWidget {
  myslider({Key? key}) : super(key: key);
  //icons
  List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];
  //texts
  List<String> texts = [
    "home"
        "profile"
        "settings"
        "details"
  ];
  @override
  Widget build(BuildContext context) {
    var textheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 90),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: mycolor.primarygradientcolor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage("assets/image/login.png"),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "DEEPESH VP",
          style: textheme.headline1,
        ),
        Text(
          "FLUTTER DEVELOPER",
          style: textheme.headline3,
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 10,
          ),
          width: double.infinity,
          height: 300,
          child: ListView.builder(
              itemCount: icons.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return InkWell(
                  //ignore avoid print
                  onTap: () => print("$i selected"),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Icon(
                        icons[i],
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        texts[i],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
        )
      ]),
    );
  }
}

//my app bar
class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  MyAppBar({Key? key, 
    required this.drawerKey,
  }) : super(key: key);
  GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<MyAppBar> createState() => _myappbarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _myappbarState extends State<MyAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isdroweropen = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // toggle for drawer and icon animation
  void toggle() {
    setState(() {
      isdroweropen = !isdroweropen;
      if (isdroweropen) {
        controller.forward();
        widget.drawerKey.currentState!.openSlider();
      } else {
        controller.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var base = BaseWidget.of(context).dataStore.box;
    return SizedBox(
      width: double.infinity,
      height: 132,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // animated icon menu and close
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: toggle,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: controller,
                  size: 40,
                ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
            //delete icon
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  base.isEmpty
                      ? warningnotask(context)
                      : deletealltask(context);
                },
                child: Icon(
                  CupertinoIcons.trash,
                  size: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// floating action button
class fab extends StatelessWidget {
  fab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => TaskView(
                taskControllerForSubtitle: null,
                taskControllerForTitle: null,
                task: null)));

      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: mycolor.primarycolor,
            borderRadius: BorderRadius.circular(15),

          ),
          child: Center(
            child: Icon(Icons.add,color: Colors.white,),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable


