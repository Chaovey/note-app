import 'package:flutter/material.dart';
import '../models/note.dart';

class EditScreen extends StatefulWidget {
  final Note? note;
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _initializeTextControllers();
  }

  void _initializeTextControllers() {
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(child: _buildNoteEditor()),
          ],
        ),
      ),
      floatingActionButton: _buildSaveButton(),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: _buildIconWithBackground(
            icon: Icons.arrow_back_ios_new,
            backgroundColor: Colors.grey.shade800.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildIconWithBackground({required IconData icon, required Color backgroundColor}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget _buildNoteEditor() {
    return ListView(
      children: [
        _buildTitleField(),
        _buildContentField(),
      ],
    );
  }

  Widget _buildTitleField() {
    return TextField(
      controller: _titleController,
      style: const TextStyle(color: Colors.white, fontSize: 30),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 30),
      ),
    );
  }

  Widget _buildContentField() {
    return TextField(
      controller: _contentController,
      style: const TextStyle(color: Colors.white),
      maxLines: null,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Type something here',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildSaveButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pop(context, [_titleController.text, _contentController.text]);
      },
      elevation: 10,
      backgroundColor: Colors.grey.shade800,
      child: const Icon(Icons.save, size: 38, color: Colors.white),
    );
  }
}
