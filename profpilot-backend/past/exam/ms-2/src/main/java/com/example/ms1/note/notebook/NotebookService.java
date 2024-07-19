package com.example.ms1.note.notebook;

import com.example.ms1.note.notetag.NoteTagService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class NotebookService {
    private final NotebookRepository notebookRepository;
    private NoteTagService noteTagService;

    public Notebook getNotebook(Long notebookId) {
        return notebookRepository.findById(notebookId).orElseThrow();
    }

    public List<Notebook> getNotebookList() {
        return notebookRepository.findAll();
    }

    public Notebook save(Notebook notebook) {
        return notebookRepository.save(notebook);
    }

    public void delete(Long id) {
        notebookRepository.deleteById(id);
    }

    public void update(Long id, String title) {
        Notebook notebook = notebookRepository.findById(id).orElseThrow();
        notebook.setName(title);
        notebookRepository.save(notebook);
    }

    public List<Notebook> getSearchNoteList(String keyword) {
        return notebookRepository.findByNameContaining(keyword);
    }


}
