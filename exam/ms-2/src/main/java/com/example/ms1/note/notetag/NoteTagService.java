package com.example.ms1.note.notetag;

import com.example.ms1.note.note.NoteService;
import com.example.ms1.note.notebook.NotebookRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import com.example.ms1.note.note.Note;
import java.util.List;

@Service
@RequiredArgsConstructor
public class NoteTagService {
    private final NoteTagRepository noteTagRepository;
    private final NoteService noteService;

    public NoteTag create(Long noteId, String name) {
        Note note = noteService.getNote(noteId);
        NoteTag noteTag = noteTagRepository.findByName(name);
        if (noteTag == null) {
            noteTag = new NoteTag();
        }

        noteTag.getNoteList().add(note);
        noteTag.setName(name);
        return noteTagRepository.save(noteTag);
    }

    public void delete(Long tagId, Long noteId) {
        // 해당 테그와 연결된 하나의 노트에서만 해당 테그를 삭제한다.
        Note note = noteService.getNote(noteId);
        NoteTag noteTag = noteTagRepository.findById(tagId).orElseThrow();
        noteTag.getNoteList().remove(note);
        noteTagRepository.save(noteTag);
    }

    public List<NoteTag> getNoteTagList() {
        return noteTagRepository.findAll();
    }
    public List<NoteTag> getNoteTagListByNote(Note note) {
        return noteTagRepository.findByNoteListContains(note);
    }
}
