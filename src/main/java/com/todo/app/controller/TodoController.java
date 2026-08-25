package com.todo.app.controller;

import com.todo.app.dto.TodoDto;
import com.todo.app.entities.TodoEntity;
import com.todo.app.service.ITodoService;
import com.todo.app.service.TodoService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
                            @RequestParam(value = "q", required = false) String query,
                            Model model) {
        List<TodoDto> todos;
        if (query != null && !query.trim().isEmpty()) {
            todos = todoService.findByTitreContaining(query.trim());
            model.addAttribute("searchQuery", query.trim());
        } else if (statut != null && !statut.isEmpty()) {
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
                           @RequestParam(value = "dateEcheance", required = false) String dateEcheance,
                           RedirectAttributes redirectAttributes) {
        if (titre == null || titre.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("titreError", "Le titre est obligatoire.");
            return "redirect:/todos/add";
        }
        if (titre.trim().length() < 3 || titre.trim().length() > 100) {
            redirectAttributes.addFlashAttribute("titreError", "Le titre doit contenir entre 3 et 100 caracteres.");
            return "redirect:/todos/add";
        }
        try {
            TodoEntity.Priorite.valueOf(priorite);
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("enumError", "Priorite invalide.");
            return "redirect:/todos/add";
        }
        try {
            TodoEntity.Statut.valueOf(statut);
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("enumError", "Statut invalide.");
            return "redirect:/todos/add";
        }
        java.time.LocalDate echeance = null;
        if (dateEcheance != null && !dateEcheance.isEmpty()) {
            try {
                echeance = java.time.LocalDate.parse(dateEcheance);
                if (echeance.isBefore(java.time.LocalDate.now())) {
                    redirectAttributes.addFlashAttribute("dateError", "La date d'echeance ne peut pas etre dans le passe.");
                    return "redirect:/todos/add";
                }
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("dateError", "Format de date invalide.");
                return "redirect:/todos/add";
            }
        }
        TodoDto todo = new TodoDto();
        todo.setTitre(titre.trim());
        todo.setDescription(description);
        todo.setPriorite(priorite);
        todo.setStatut(statut);
        todo.setDateEcheance(echeance);
        todoService.save(todo);
        redirectAttributes.addFlashAttribute("successMessage", "Tache creee avec succes !");
        return "redirect:/todos";
    }

    @GetMapping("/todos/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        TodoDto todo = todoService.findById(id);
        if (todo == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tache introuvable.");
            return "redirect:/todos";
        }
        model.addAttribute("todo", todo);
        return "edit-todo";
    }

    @PostMapping("/todos/update")
    public String updateTodo(@RequestParam("id") Long id,
                             @RequestParam("titre") String titre,
                             @RequestParam(value = "description", required = false) String description,
                             @RequestParam("priorite") String priorite,
                             @RequestParam("statut") String statut,
                             @RequestParam(value = "dateEcheance", required = false) String dateEcheance,
                             RedirectAttributes redirectAttributes) {
        if (titre == null || titre.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("titreError", "Le titre est obligatoire.");
            return "redirect:/todos/edit/" + id;
        }
        if (titre.trim().length() < 3 || titre.trim().length() > 100) {
            redirectAttributes.addFlashAttribute("titreError", "Le titre doit contenir entre 3 et 100 caracteres.");
            return "redirect:/todos/edit/" + id;
        }
        java.time.LocalDate echeance = null;
        if (dateEcheance != null && !dateEcheance.isEmpty()) {
            try {
                echeance = java.time.LocalDate.parse(dateEcheance);
                if (echeance.isBefore(java.time.LocalDate.now())) {
                    redirectAttributes.addFlashAttribute("dateError", "La date d'echeance ne peut pas etre dans le passe.");
                    return "redirect:/todos/edit/" + id;
                }
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("dateError", "Format de date invalide.");
                return "redirect:/todos/edit/" + id;
            }
        }
        TodoDto todo = new TodoDto();
        todo.setId(id);
        todo.setTitre(titre.trim());
        todo.setDescription(description);
        todo.setPriorite(priorite);
        todo.setStatut(statut);
        todo.setDateEcheance(echeance);
        todoService.update(todo);
        redirectAttributes.addFlashAttribute("successMessage", "Tache mise a jour avec succes !");
        return "redirect:/todos";
    }

    @PostMapping("/todos/delete/{id}")
    public String deleteTodo(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        TodoDto todo = todoService.findById(id);
        if (todo == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tache introuvable.");
            return "redirect:/todos";
        }
        todoService.delete(id);
        redirectAttributes.addFlashAttribute("successMessage", "Tache supprimee avec succes !");
        return "redirect:/todos";
    }
}
