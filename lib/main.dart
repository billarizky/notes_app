import 'package:flutter/material.dart';
import '../notes_logic.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  final NotesLogic _notesLogic = NotesLogic();
  final TextEditingController _controller = TextEditingController();

  void _tambahCatatan() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _notesLogic.addNote(_controller.text.trim());
      });
      _controller.clear();
    }
  }

  void _hapusCatatan(int index) {
    setState(() {
      _notesLogic.deleteNote(index);
    });
  }

  void _editCatatan(int index) {

    // controller khusus edit (BIAR TIDAK KONFLIK)
    final TextEditingController editController =
        TextEditingController(text: _notesLogic.notes[index]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("✏️ Edit Catatan"),

          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: "Masukkan catatan baru",
            ),
          ),

          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("❌ Batal"),
            ),

            ElevatedButton(
              onPressed: () {

                if (editController.text.trim().isNotEmpty) {
                  setState(() {
                    _notesLogic.editNote(
                      index,
                      editController.text.trim(),
                    );
                  });
                }

                Navigator.pop(context);
              },
              child: const Text("✅ Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("📝 Notes App"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "✍️ Masukkan catatan",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _tambahCatatan,
                child: const Text("➕ Tambah Catatan"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: _notesLogic.notes.isEmpty
                  ? const Center(
                      child: Text("📭 Belum ada catatan"),
                    )
                  : ListView.builder(
                      itemCount: _notesLogic.notes.length,
                      itemBuilder: (context, index) {

                        return Card(
                          child: ListTile(
                            title: Text(
                              "📌 ${_notesLogic.notes[index]}",
                            ),

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                IconButton(
                                  onPressed: () => _editCatatan(index),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                ),

                                IconButton(
                                  onPressed: () => _hapusCatatan(index),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}