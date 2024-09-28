import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> filteredNotes = [];
  bool isSorted = false;

  @override
  void initState() {
    super.initState();
    filteredNotes = sampleNotes;
  }

  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    notes.sort((a, b) => isSorted
        ? a.modifiedTime.compareTo(b.modifiedTime)
        : b.modifiedTime.compareTo(a.modifiedTime));
    isSorted = !isSorted;
    return notes;
  }

  Color getRandomBackgroundColor() {
    return backgroundColors[Random().nextInt(backgroundColors.length)];
  }

  void onSearch(String query) {
    setState(() {
      filteredNotes = sampleNotes.where((note) {
        final contentLower = note.content.toLowerCase();
        final titleLower = note.title.toLowerCase();
        final searchLower = query.toLowerCase();
        return contentLower.contains(searchLower) ||
            titleLower.contains(searchLower);
      }).toList();
    });
  }

  void deleteNoteAt(int index) {
    setState(() {
      Note noteToRemove = filteredNotes[index];
      sampleNotes.remove(noteToRemove);
      filteredNotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 20),
            Expanded(child: _buildNoteList()),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'ColorNote Notepad',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              filteredNotes = sortNotesByModifiedTime(filteredNotes);
            });
          },
          icon: _buildIconWithBackground(
            icon: Icons.color_lens,
            backgroundColor: Colors.grey.shade800.withOpacity(0.8),
          ),
        )
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

  Widget _buildSearchBar() {
    return TextField(
      onChanged: onSearch,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        hintText: "Search notes...",
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        fillColor: Colors.grey.shade800,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _buildNoteList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 30),
      itemCount: filteredNotes.length,
      itemBuilder: (context, index) {
        return _buildNoteCard(index);
      },
    );
  }

  Widget _buildNoteCard(int index) {
    final note = filteredNotes[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      color: getRandomBackgroundColor(),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          onTap: () async => _editNoteScreen(index),
          title: _buildNoteTitle(note),
          subtitle: _buildNoteSubtitle(note),
          trailing: _buildDeleteButton(index),
        ),
      ),
    );
  }

  Widget _buildNoteTitle(Note note) {
    return RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: '${note.title}\n',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: note.content,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteSubtitle(Note note) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        'Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(note.modifiedTime)}',
        style: TextStyle(
          fontSize: 10,
          fontStyle: FontStyle.italic,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }

  Widget _buildDeleteButton(int index) {
    return IconButton(
      onPressed: () async {
        final result = await _confirmDeleteDialog();
        if (result == true) {
          deleteNoteAt(index);
        }
      },
      icon: const Icon(Icons.delete),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const EditScreen(),
          ),
        );
        if (result != null) {
          _addNewNote(result);
        }
      },
      elevation: 10,
      backgroundColor: Colors.grey.shade800,
      child: const Icon(Icons.add, size: 38, color: Colors.white),
    );
  }

  Future<void> _editNoteScreen(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EditScreen(note: filteredNotes[index]),
      ),
    );
    if (result != null) {
      setState(() {
        int originalIndex = sampleNotes.indexOf(filteredNotes[index]);
        final updatedNote = Note(
          id: sampleNotes[originalIndex].id,
          title: result[0],
          content: result[1],
          modifiedTime: DateTime.now(),
        );
        sampleNotes[originalIndex] = updatedNote;
        filteredNotes[index] = updatedNote;
      });
    }
  }

  void _addNewNote(List<String> result) {
    setState(() {
      sampleNotes.add(Note(
        id: sampleNotes.length,
        title: result[0],
        content: result[1],
        modifiedTime: DateTime.now(),
      ));
      filteredNotes = sampleNotes;
    });
  }

  Future<bool?> _confirmDeleteDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade500,
          icon: const Icon(Icons.info, color: Colors.grey),
          title: const Text(
            'Are you sure you want to delete?',
            style: TextStyle(color: Colors.white),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDialogButton('Yes', Colors.green, true),
              _buildDialogButton('No', Colors.red, false),
            ],
          ),
        );
      },
    );
  }

  ElevatedButton _buildDialogButton(String text, Color color, bool result) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context, result);
      },
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: SizedBox(
        width: 60,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
