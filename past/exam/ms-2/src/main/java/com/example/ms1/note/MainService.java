package com.example.ms1.note;

import com.example.ms1.note.note.Note;
import com.example.ms1.note.note.NoteService;
import com.example.ms1.note.notebook.Notebook;
import com.example.ms1.note.notebook.NotebookService;
import com.example.ms1.note.notetag.NoteTag;
import com.example.ms1.note.notetag.NoteTagService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class MainService {

    private final NotebookService notebookService;
    private final NoteService noteService;
    private final NoteTagService noteTagService;

    public MainDataDto getDefaultMainData(String keyword, String tagKeyword) {
        List<Notebook> notebookList = notebookService.getNotebookList();

        if (notebookList.isEmpty()) {
            Notebook notebook = this.saveDefaultNotebook();
            notebookList.add(notebook);
        }

        Notebook targetNotebook = notebookList.get(0);
        List<Note> noteList = targetNotebook.getNoteList();
        Note targetNote = noteList.get(0);
        List<Notebook> searchedNotebookList = notebookService.getSearchNoteList(keyword);
        List<Note> searchedNoteList = noteService.getSearchedNoteList(keyword);

        System.out.println("tagKeyword: " + tagKeyword);
        List<Note> searchedTagNoteList = noteService.getSearchedTagNoteList(tagKeyword);
        List<NoteTag> tagList = noteTagService.getNoteTagList();
        List<NoteTag> noteTagList = noteTagService.getNoteTagListByNote(targetNote);


        List<Note> sortedNoteList;
        if (targetNotebook.getSort()) {
            sortedNoteList = noteService.getSortedListByCreateDate(targetNotebook);
        } else {
            sortedNoteList = noteService.getSortedListByTitle(targetNotebook);
        }

        MainDataDto mainDataDto = new MainDataDto(notebookList, targetNotebook, sortedNoteList, targetNote, searchedNotebookList, searchedNoteList, tagList, noteTagList, searchedTagNoteList);
        return mainDataDto;
    }

    public MainDataDto getMainData(Long notebookId, Long noteId, String keyword, String tagKeyword) {
        MainDataDto mainDataDto = this.getDefaultMainData(keyword, tagKeyword);
        Notebook targetNotebook = this.getNotebook(notebookId);
        Note targetNote = noteService.getNote(noteId);


        List<Note> sortedNoteList;
                noteTagService.getNoteTagListByNote(targetNote);

        if (targetNotebook.getSort()) {
            sortedNoteList = noteService.getSortedListByCreateDate(targetNotebook);
        } else {
            sortedNoteList = noteService.getSortedListByTitle(targetNotebook);
        }

        mainDataDto.setTargetNote(targetNote);
        mainDataDto.setNoteList(sortedNoteList);
        mainDataDto.setTargetNoteTagList(noteTagService.getNoteTagListByNote(targetNote));

        return mainDataDto;
    }
    public Notebook addToNotebook(Long notebookId) {
        Notebook notebook = this.getNotebook(notebookId);
        Note note = noteService.saveDefault();
        notebook.addNote(note);
        return notebookService.save(notebook);
    }

    public Notebook getNotebook(Long notebookId) {
        return notebookService.getNotebook(notebookId);
    }

    public List<Notebook> getNotebookList() {
        return notebookService.getNotebookList();
    }

    public Notebook saveDefaultNotebook() {
        Notebook notebook = new Notebook();
        notebook.setName("새노트북");
        notebook.setSort(true);
        Note note = noteService.saveDefault();
        notebook.addNote(note);

        return notebookService.save(notebook);
    }

    public void saveGroupNotebook(Long notebookId) {
        Notebook parent = this.getNotebook(notebookId);
        Notebook child = this.saveDefaultNotebook();
        parent.addChild(child);

        notebookService.save(parent);
    }

    public void delete(Long id) {

        Notebook notebook = this.getNotebook(id);

        if(notebook.getChildren().isEmpty()) {
            deleteBasic(notebook);
        }
        else {
            deleteGroup(notebook);
        }
    }

    public void deleteGroup(Notebook notebook) {
        List<Notebook> children = notebook.getChildren();
        for (Notebook child : children) {
            deleteBasic(child);
        }
        deleteBasic(notebook);
    }

    public void deleteBasic(Notebook notebook) {

        List<Note> noteList = notebook.getNoteList();
        // 노트 먼저 삭제
        for (Note note : noteList) {
            noteService.delete(note.getId());
        }
        // 노트북 삭제
        notebookService.delete(notebook.getId());
    }
}
