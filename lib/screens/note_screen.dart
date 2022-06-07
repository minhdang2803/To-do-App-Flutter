import 'package:flutter/material.dart';
import 'package:todoapp/theme.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<bool> _isSelected = [false, false, false];
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _textInside = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _title.dispose();
    _description.dispose();
    _textInside.dispose();
  }

  void choiceOption(bool value, int element1, int element2, int element3) {
    setState(() {
      _isSelected[element1] = value;
      if (_isSelected[element2] == value && _isSelected[element3] == value) {
        return;
      }
      if (_isSelected[element2] == value) {
        _isSelected[element2] = !value;
      }
      if (_isSelected[element3] == value) {
        _isSelected[element3] = !value;
      }
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.check))],
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

  TextField buildTitleField() {
    return TextField(
      controller: _title,
      decoration: InputDecoration(
        hintText: 'Title',
        hintStyle: TodoTheme.lightTextTheme.headline1,
        border: InputBorder.none,
      ),
      style: TodoTheme.lightTextTheme.headline1,
    );
  }

  Widget buildChoiceChip() {
    return Wrap(
      spacing: 10,
      children: [
        ChoiceChip(
            label: const Text('Normal'),
            selected: _isSelected[0],
            onSelected: (value) => choiceOption(value, 0, 1, 2),
            selectedColor: TodoTheme.normalChipColor),
        ChoiceChip(
          label: const Text('Important'),
          selected: _isSelected[1],
          onSelected: (value) => choiceOption(value, 1, 0, 2),
          selectedColor: TodoTheme.importantChipColor,
        ),
        ChoiceChip(
            label: const Text('Very Important'),
            selected: _isSelected[2],
            onSelected: (value) => choiceOption(value, 2, 1, 0),
            selectedColor: TodoTheme.veryImportantChipCplor)
      ],
    );
  }

  Widget buildContextInside() {
    return Expanded(
      child: TextField(
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
      controller: _description,
      decoration: InputDecoration(
        hintText: 'Description',
        hintStyle: TodoTheme.lightTextTheme.headline2,
        border: InputBorder.none,
      ),
      style: TodoTheme.lightTextTheme.headline2,
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
