package com.example.ms1.note.note;

import com.example.ms1.note.notebook.Notebook;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NoteRepository extends JpaRepository<Note, Long> {
    List<Note> findByNotebook(Notebook notebook);
    List<Note> findByTitleContaining(String keyword);

    List<Note> findByNotebookOrderByCreateDateDesc(Notebook notebook);
    List<Note> findByNotebookOrderByCreateDateAsc(Notebook notebook);
    List<Note> findByNotebookOrderByTitle(Notebook notebook);
}
