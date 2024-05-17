package com.example.ms1.note;

import com.example.ms1.note.note.Note;
import com.example.ms1.note.note.NoteRepository;
import com.example.ms1.note.note.NoteService;
import com.example.ms1.note.notebook.Notebook;
import com.example.ms1.note.notebook.NotebookRepository;
import com.example.ms1.note.notebook.NotebookService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class MainController {
    private final MainService mainService;

    @RequestMapping("/")
    public String main(Model model, String keyword, String tagKeyword, @RequestParam(defaultValue = "false") String isSearchModal, @RequestParam(defaultValue = "false") String isTagSearchModal) {

        MainDataDto mainDataDto = mainService.getDefaultMainData(keyword, tagKeyword);
        model.addAttribute("mainDataDto", mainDataDto);
        model.addAttribute("isSearchModal", isSearchModal);
        model.addAttribute("isTagSearchModal", isTagSearchModal);
        return "main";
    }

}
