import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/todo_path.dart';
import 'package:todoapp/providers/list_manager.dart';
import 'package:todoapp/theme.dart';
import 'package:todoapp/models/models.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      child: const NoteScreen(),
      name: TodoPages.item,
      key: ValueKey(TodoPages.item),
    );
  }

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _textInside = TextEditingController();
  ChipSelection _selection = ChipSelection.normal;
  Color _color = TodoTheme.normalChipColor;
  @override
  void dispose() {
    super.dispose();
    _title.dispose();
    _description.dispose();
    _textInside.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () async {
                //TODO: Validate Data before adding to the form
                String getSelection = getPriority(_selection);
                // String getColor = getColor(_color);
                await Provider.of<ListManager>(context, listen: false).addTask(
                  Task(
                    title: _title.text,
                    description: _description.text,
                    contextInside: _textInside.text,
                    chipLabel: getSelection,
                    backgroundColor: _color.value,
                  ),
                );
                // ignore: use_build_context_synchronously
                Navigator.pop(context, true);
              },
              icon: const Icon(Icons.check)),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTitleField(),
                  buildDescriptionTextField(),
                  const SizedBox(height: 8),
                  buildChoiceChip(),
                  const SizedBox(height: 8),
                  buildContextInside()
                ],
              ),
            ),
            buildCancelButton(context)
          ],
        ),
      ),
    );
  }

  String getPriority(ChipSelection chip) {
    if (chip == ChipSelection.normal) {
      return 'Normal';
    } else if (chip == ChipSelection.important) {
      return 'Important';
    } else {
      return 'Urgent';
    }
  }

  TextField buildTitleField() {
    return TextField(
      cursorColor: TodoTheme.veryImportantChipCplor,
      controller: _title,
      decoration: InputDecoration(
        hintText: 'Title',
        hintStyle: TodoTheme.lightTextTheme.headline1,
        border: InputBorder.none,
      ),
      style: TodoTheme.lightTextTheme.headline1!
          .copyWith(color: TodoTheme.veryImportantChipCplor),
    );
  }

  Widget buildChoiceChip() {
    return Wrap(
      spacing: 10,
      children: [
        ChoiceChip(
            label: const Text('Normal'),
            selected: _selection == ChipSelection.normal,
            onSelected: (selected) {
              setState(() {
                _selection = ChipSelection.normal;
                _color = TodoTheme.normalChipColor;
              });
            },
            selectedColor: TodoTheme.normalChipColor),
        ChoiceChip(
          label: const Text('Important'),
          selected: _selection == ChipSelection.important,
          onSelected: (selected) => setState(() {
            _selection = ChipSelection.important;
            _color = TodoTheme.importantChipColor;
          }),
          selectedColor: TodoTheme.importantChipColor,
        ),
        ChoiceChip(
          label: const Text('Urgent'),
          selected: _selection == ChipSelection.urgent,
          onSelected: (selected) => setState(() {
            _selection = ChipSelection.urgent;
            _color = TodoTheme.veryImportantChipCplor;
          }),
          selectedColor: TodoTheme.veryImportantChipCplor,
        )
      ],
    );
  }

  Widget buildContextInside() {
    return Expanded(
      child: TextField(
        cursorColor: TodoTheme.veryImportantChipCplor,
        controller: _textInside,
        decoration: const InputDecoration(
            hintText: 'Input your note here!', border: InputBorder.none),
        keyboardType: TextInputType.multiline,
        maxLines: 100,
      ),
    );
  }

  Widget buildDescriptionTextField() {
    return TextField(
      cursorColor: TodoTheme.veryImportantChipCplor,
      controller: _description,
      decoration: InputDecoration(
        hintText: 'Description',
        hintStyle: TodoTheme.lightTextTheme.headline2,
        border: InputBorder.none,
      ),
      style: TodoTheme.lightTextTheme.headline2!
          .copyWith(color: TodoTheme.veryImportantChipCplor),
    );
  }

  Widget buildCancelButton(BuildContext context) {
    return Positioned(
      bottom: 25.0,
      right: 15.0,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              color: Color(0xffFE3577),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Image(image: AssetImage('assets/delete_icon.png')),
        ),
      ),
    );
  }
}
