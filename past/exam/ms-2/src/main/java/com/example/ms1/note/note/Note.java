package com.example.ms1.note.note;

import com.example.ms1.note.notebook.Notebook;
import com.example.ms1.note.notetag.NoteTag;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ManyToAny;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Setter
@Getter
public class Note {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String content;
    private LocalDateTime createDate;

    @ManyToOne(fetch = FetchType.LAZY)
    private Notebook notebook;

    @ManyToMany(fetch = FetchType.LAZY)
    private List<NoteTag> noteTagList = new ArrayList<>();
}