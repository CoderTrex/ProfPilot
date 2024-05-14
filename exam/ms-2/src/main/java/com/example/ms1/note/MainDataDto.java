package com.example.ms1.note;

import com.example.ms1.note.note.Note;
import com.example.ms1.note.notebook.Notebook;
import com.example.ms1.note.notetag.NoteTag;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.aspectj.weaver.ast.Not;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class MainDataDto {
    List<Notebook> notebookList = new ArrayList<>();
    Notebook targetNotebook;
    List<Note> noteList = new ArrayList<>();
    Note targetNote;
    List<Notebook> searchedNotebookList = new ArrayList<>();
    List<Note> searchedNoteList = new ArrayList<>();
    List<NoteTag> tagList = new ArrayList<>();
    List<NoteTag> targetNoteTagList = new ArrayList<>();
    List<Note> searchedTagNoteList = new ArrayList<>();
}
