package com.todo.app.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class TodoDto {

    private Long id;
    private String titre;
    private String description;
    private String priorite;
    private String statut;
    private LocalDate dateEcheance;
    private LocalDateTime dateCreation;

    public TodoDto() {}

    public TodoDto(Long id, String titre, String description, String priorite, String statut, LocalDate dateEcheance, LocalDateTime dateCreation) {
        this.id = id;
        this.titre = titre;
        this.description = description;
        this.priorite = priorite;
        this.statut = statut;
        this.dateEcheance = dateEcheance;
        this.dateCreation = dateCreation;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPriorite() { return priorite; }
    public void setPriorite(String priorite) { this.priorite = priorite; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public LocalDate getDateEcheance() { return dateEcheance; }
    public void setDateEcheance(LocalDate dateEcheance) { this.dateEcheance = dateEcheance; }

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }
}
