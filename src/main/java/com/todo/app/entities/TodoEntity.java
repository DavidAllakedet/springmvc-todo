package com.todo.app.entities;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "todos")
public class TodoEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String titre;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Priorite priorite = Priorite.MOYENNE;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Statut statut = Statut.EN_ATTENTE;

    @Column(name = "date_echeance")
    private LocalDate dateEcheance;

    @Column(name = "date_creation")
    private LocalDateTime dateCreation = LocalDateTime.now();

    public enum Priorite {
        HAUTE, MOYENNE, BASSE
    }

    public enum Statut {
        EN_ATTENTE, EN_COURS, TERMINEE
    }

    public TodoEntity() {}

    public TodoEntity(String titre, String description, Priorite priorite, Statut statut, LocalDate dateEcheance) {
        this.titre = titre;
        this.description = description;
        this.priorite = priorite;
        this.statut = statut;
        this.dateEcheance = dateEcheance;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Priorite getPriorite() { return priorite; }
    public void setPriorite(Priorite priorite) { this.priorite = priorite; }

    public Statut getStatut() { return statut; }
    public void setStatut(Statut statut) { this.statut = statut; }

    public LocalDate getDateEcheance() { return dateEcheance; }
    public void setDateEcheance(LocalDate dateEcheance) { this.dateEcheance = dateEcheance; }

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }
}
