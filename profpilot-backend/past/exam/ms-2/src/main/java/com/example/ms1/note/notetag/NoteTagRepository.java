package com.example.ms1.note.notetag;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.ms1.note.note.Note;
import java.util.List;
public interface NoteTagRepository extends JpaRepository<NoteTag, Long> {

    List<NoteTag> findByNoteListContains(Note note);
    NoteTag findByName(String name);
}
