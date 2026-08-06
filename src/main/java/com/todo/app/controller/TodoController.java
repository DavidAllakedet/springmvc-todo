package com.todo.app.controller;

import com.todo.app.dto.TodoDto;
import com.todo.app.entities.TodoEntity;
import com.todo.app.service.ITodoService;
import com.todo.app.service.TodoService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class TodoController {

    private final ITodoService todoService = new TodoService();

    @GetMapping("/")
    public String dashboard(Model model) {
        List<TodoDto> allTodos = todoService.findAll();
        long enAttente = allTodos.stream().filter(t -> "EN_ATTENTE".equals(t.getStatut())).count();
        long enCours = allTodos.stream().filter(t -> "EN_COURS".equals(t.getStatut())).count();
        long terminee = allTodos.stream().filter(t -> "TERMINEE".equals(t.getStatut())).count();
        long haute = allTodos.stream().filter(t -> "HAUTE".equals(t.getPriorite())).count();

        model.addAttribute("todos", allTodos);
        model.addAttribute("totalTaches", allTodos.size());
        model.addAttribute("enAttente", enAttente);
        model.addAttribute("enCours", enCours);
        model.addAttribute("terminee", terminee);
        model.addAttribute("hautePriorite", haute);
        return "index";
    }

    @GetMapping("/todos")
    public String listTodos(@RequestParam(value = "statut", required = false) String statut,
                            @RequestParam(value = "priorite", required = false) String priorite,
                            Model model) {
        List<TodoDto> todos;
        if (statut != null && !statut.isEmpty()) {
            todos = todoService.findByStatut(statut);
            model.addAttribute("filterStatut", statut);
        } else if (priorite != null && !priorite.isEmpty()) {
            todos = todoService.findByPriorite(priorite);
            model.addAttribute("filterPriorite", priorite);
        } else {
            todos = todoService.findAll();
        }
        model.addAttribute("todos", todos);
        return "todos";
    }

    @GetMapping("/todos/add")
    public String showAddForm(Model model) {
        model.addAttribute("todo", new TodoDto());
        return "add-todo";
    }

    @PostMapping("/todos/save")
    public String saveTodo(@RequestParam("titre") String titre,
                           @RequestParam(value = "description", required = false) String description,
                           @RequestParam("priorite") String priorite,
                           @RequestParam("statut") String statut,
                           @RequestParam(value = "dateEcheance", required = false) String dateEcheance) {
        TodoDto todo = new TodoDto();
        todo.setTitre(titre);
        todo.setDescription(description);
        todo.setPriorite(priorite);
        todo.setStatut(statut);
        if (dateEcheance != null && !dateEcheance.isEmpty()) {
            todo.setDateEcheance(java.time.LocalDate.parse(dateEcheance));
        }
        todoService.save(todo);
        return "redirect:/todos";
    }

    @GetMapping("/todos/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        TodoDto todo = todoService.findById(id);
        model.addAttribute("todo", todo);
        return "edit-todo";
    }

    @PostMapping("/todos/update")
    public String updateTodo(@RequestParam("id") Long id,
                             @RequestParam("titre") String titre,
                             @RequestParam(value = "description", required = false) String description,
                             @RequestParam("priorite") String priorite,
                             @RequestParam("statut") String statut,
                             @RequestParam(value = "dateEcheance", required = false) String dateEcheance) {
        TodoDto todo = new TodoDto();
        todo.setId(id);
        todo.setTitre(titre);
        todo.setDescription(description);
        todo.setPriorite(priorite);
        todo.setStatut(statut);
        if (dateEcheance != null && !dateEcheance.isEmpty()) {
            todo.setDateEcheance(java.time.LocalDate.parse(dateEcheance));
        }
        todoService.update(todo);
        return "redirect:/todos";
    }

    @GetMapping("/todos/delete/{id}")
    public String deleteTodo(@PathVariable("id") Long id) {
        todoService.delete(id);
        return "redirect:/todos";
    }
}
