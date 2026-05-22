import 'package:flutter/material.dart';
import '../notes_logic.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  final NotesLogic logic = NotesLogic();

  final TextEditingController controller = TextEditingController();

  // tambah catatan
  void addNote() {
    if (controller.text.trim().isNotEmpty) {
      setState(() {
        logic.addNote(controller.text.trim());
      });
      controller.clear();
    }
  }

  // hapus catatan
  void deleteNote(int index) {
    setState(() {
      logic.deleteNote(index);
    });
  }

  // edit catatan (DIBENERIN)
  void editNote(int index) {

    final TextEditingController editController =
        TextEditingController(text: logic.notes[index]);

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
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(" ❌ Batal"),
            ),

            ElevatedButton(
              onPressed: () {

                if (editController.text.trim().isNotEmpty) {
                  setState(() {
                    logic.editNote(
                      index,
                      editController.text.trim(),
                    );
                  });
                }

                Navigator.pop(context);
              },
              child: const Text(" ✅Simpan"),
            ),
          ],
        );
      },
    );
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
              controller: controller,
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
                onPressed: addNote,
                child: const Text("➕ Tambah Catatan"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: logic.notes.isEmpty
                  ? const Center(
                      child: Text("📭 Belum ada catatan"),
                    )
                  : ListView.builder(
                      itemCount: logic.notes.length,
                      itemBuilder: (context, index) {

                        return Card(
                          child: ListTile(
                            title: Text(
                              "📌 ${logic.notes[index]}",
                            ),

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                IconButton(
                                  onPressed: () => editNote(index),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                ),

                                IconButton(
                                  onPressed: () => deleteNote(index),
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