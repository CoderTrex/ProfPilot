package com.example.ms1.note.notebook;

import com.example.ms1.note.MainService;
import com.example.ms1.note.note.Note;
import com.example.ms1.note.note.NoteService;
import com.example.ms1.note.notetag.NoteTagService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class NotebookController {

    private final NotebookService notebookService;
    private final MainService mainService;
    private final NoteTagService noteTagService;

    @PostMapping("/books/write")
    public String write() {
        mainService.saveDefaultNotebook();
        return "redirect:/";
    }

    @PostMapping("/groups/{notebookId}/books/write")
    public String groupWrite(@PathVariable("notebookId") Long notebookId) {

        mainService.saveGroupNotebook(notebookId);
        return "redirect:/";
    }

    @GetMapping("/books/{id}")
    public String detail(@PathVariable("id") Long id) {
        Notebook notebook = notebookService.getNotebook(id);
        Note note = notebook.getNoteList().get(0);

        return "redirect:/books/%d/notes/%d".formatted(id, note.getId());
    }

    @PostMapping("/books/{id}/delete")
    public String delete(@PathVariable("id") Long id) {
//        mainService.delete(id);
        notebookService.delete(id);
        return "redirect:/";
    }


//    /books/${targetNotebook.id}/update|
    @GetMapping("/books/{id}/update")
    public String update(@PathVariable("id") Long id, Long targetNoteId, String title) {
        notebookService.update(id, title);
        return "redirect:/books/%d/notes/%d".formatted(id, targetNoteId);
    }

    @GetMapping("/books/{id}/date")
    public String date(@PathVariable("id") Long id) {
        Notebook notebook = notebookService.getNotebook(id);
        notebook.setSort(true);
        notebookService.save(notebook);
        return "redirect:/books/%d/notes/%d".formatted(id, notebook.getNoteList().get(0).getId());
    }


    @GetMapping("/books/{id}/title")
    public String title(@PathVariable("id") Long id) {
        Notebook notebook = notebookService.getNotebook(id);
        notebook.setSort(false);
        notebookService.save(notebook);
        return "redirect:/books/%d/notes/%d".formatted(id, notebook.getNoteList().get(0).getId());
    }

    @PostMapping("/books/{id}/notes/{noteId}/tags")
    public String addTag(@PathVariable("id") Long id, @PathVariable("noteId") Long noteId, String tag) {
        noteTagService.create(noteId, tag);
        return "redirect:/books/%d/notes/%d".formatted(id, noteId);
    }
}
