package com.example.ms1.note.notetag;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@RequiredArgsConstructor
public class NoteTagController {
    private final NoteTagService noteTagService;

    @GetMapping("/tags/delete/{notebookId}/{noteId}/{tagId}")
    public String deleteTag(@PathVariable("notebookId") Long id, @PathVariable("noteId") Long noteId, @PathVariable("tagId") Long tagId) {
        noteTagService.delete(tagId, noteId);
        return "redirect:/books/%d/notes/%d".formatted(id, noteId);
    }
}
