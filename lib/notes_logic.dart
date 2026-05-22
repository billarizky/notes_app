class NotesLogic {

  List<String> notes = [];

  // tambah catatan
  void addNote(String note) {
    notes.add(note);
  }

  // hapus catatan
  void deleteNote(int index) {
    notes.removeAt(index);
  }

  // edit catatan
  void editNote(int index, String newNote) {
    notes[index] = newNote;
  }
}