import 'package:flutter/material.dart';
import 'package:todoapp/components/task_card.dart';
import 'package:todoapp/theme.dart';
import 'package:todoapp/screens/screens.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              buildTopBar(context),
              const SizedBox(height: 20),
              buildListView()
            ],
          ),
          buildAddButton(context)
        ],
      ),
    );
  }
}

Widget buildTopBar(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      const Image(image: AssetImage('assets/logo.png')),
      Text('List your works!', style: TodoTheme.lightTextTheme.headline2),
      IconButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NoteScreen())),
          icon: const Icon(Icons.add))
    ],
  );
}

Widget buildListView() {
  return Expanded(
    child: ListView(
      children: const [
        TaskCard(
          title: 'Buy Fish',
          note: 'For the dinner, we can eat fish',
        ),
        SizedBox(height: 8.0),
        TaskCard(),
        SizedBox(height: 8.0),
        TaskCard(),
        SizedBox(height: 8.0),
        TaskCard(),
        SizedBox(height: 8.0),
        TaskCard(),
      ],
    ),
  );
}

Widget buildAddButton(BuildContext context) {
  return Positioned(
    bottom: 10.0,
    right: 0,
    child: InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const NoteScreen())),
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
            color: Color(0xff7349FE),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: const Image(image: AssetImage('assets/add_icon.png')),
      ),
    ),
  );
}
