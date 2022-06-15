import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/component.dart';
import 'package:todoapp/database.dart';
import 'package:todoapp/providers/list_manager.dart';
import 'package:todoapp/theme.dart';
import 'package:todoapp/screens/screens.dart';
import '../models/models.dart';

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
              buildTopBar(context),
              const SizedBox(height: 20),
              buildListView(context)
            ],
          ),
          buildAddButton(context)
        ],
      ),
    );
  }

  Widget buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(image: AssetImage('assets/logo.png')),
          Text('List your works!', style: TodoTheme.lightTextTheme.headline2),
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NoteScreen()),
                  ),
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Task>>(
        future: Provider.of<ListManager>(context, listen: false).getTask(),
        builder: (context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TodoTheme.lightTextTheme.headline4,
              ),
            );
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('No Tasks in list',
                      style: TodoTheme.lightTextTheme.headline2))
              : ListView.separated(
                  itemBuilder: (context, index) =>
                      TaskCard(task: snapshot.data![index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: snapshot.data!.length);
        },
      ),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return Positioned(
      bottom: 10.0,
      right: 0,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NoteScreen()),
        ).then((value) => setState(() {})),
        onLongPress: () async {
          await DatabaseHelper.instance.deleteAllTask();
          setState(() {});
        },
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
}



// Widget buildListView(BuildContext context) {
//   return Expanded(
//       child: ListView(
//     children: [
//       TaskCard(
//         task: Task(
//             backgroundColor: TodoTheme.veryImportantChipCplor,
//             chipLabel: ChipSelection.urgent),
//       )
//     ],
//   ));
// }



