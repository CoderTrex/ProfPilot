package com.example.ms1.note.notebook;


import com.example.ms1.note.note.Note;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NotebookRepository extends JpaRepository<Notebook, Long>{
    List<Notebook> findByNameContaining(String keyword);
}
