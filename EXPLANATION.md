# EXPLICATION DETAILLEE - Spring MVC - JSP - JSTL

## Table des matieres

1. [Introduction](#introduction)
2. [Technologies utilisees](#technologies-utilisees)
3. [Architecture du projet](#architecture-du-projet)
4. [Explication de JSP](#explication-de-jsp)
5. [Explication de JSTL](#explication-de-jstl)
6. [Configuration Spring MVC](#configuration-spring-mvc)
7. [Couche Controller](#couche-controller)
8. [Couche Service](#couche-service)
9. [Couche DAO](#couche-dao)
10. [Couche Entity/DTO](#couche-entitydto)
11. [Base de donnees](#base-de-donnees)
12. [Vues JSP](#vues-jsp)
13. [Conclusion](#conclusion)

---

## Introduction

Ce projet est une application de **gestion de taches** developpee avec **Spring MVC**, **JSP** et **JSTL**. Il demontre les bases du framework Spring MVC avec une technologie de vues simple et directe.

### Objectifs pedagogiques

- Comprendre le fonctionnement de Spring MVC
- Apprendre a utiliser JSP pour les vues dynamiques
- Maitriser les tags JSTL pour eviter le code Java brut dans les vues
- Comprendre l'architecture en couches (Controller, Service, DAO)

---

## Technologies utilisees

| Technologie | Version | Role |
|-------------|---------|------|
| **Java** | 11 | Langage de programmation |
| **Spring MVC** | 5.2.22.RELEASE | Framework web |
| **JSP** | 2.3 | Pages dynamiques cote serveur |
| **JSTL** | 1.2 | Bibliotheque de tags standard |
| **Hibernate** | 5.4.10.Final | ORM (Object-Relational Mapping) |
| **MySQL** | 8.x | Base de donnees |
| **Bootstrap** | 5.2.0 | Framework CSS |
| **Maven** | 3.9.x | Outil de build |
| **Tomcat** | 9.x | Serveur d'application |

---

## Architecture du projet

### Architecture en couches

```
┌─────────────────────────────────────────────────────────┐
│                    VUE (JSP + JSTL)                      │
│  index.jsp | todos.jsp | add-todo.jsp | edit-todo.jsp   │
└─────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────┐
│                  CONTROLLER (Spring MVC)                 │
│                   TodoController.java                    │
│  @Controller | @GetMapping | @PostMapping               │
└─────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────┐
│                    SERVICE (Metier)                      │
│              ITodoService.java | TodoService.java       │
│                  Logique metier                         │
└─────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────┐
│                DAO (Data Access Object)                  │
│           Repository.java | RepositoryImpl.java        │
│              TodoDao.java | ITodoDao.java               │
└─────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────┐
│              ENTITY / DTO / MAPPER                       │
│    TodoEntity.java | TodoDto.java | TodoMapper.java     │
└─────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────┐
│                BASE DE DONNEES (MySQL)                   │
│                    table : todos                         │
└─────────────────────────────────────────────────────────┘
```

### Structure des dossiers

```
springmvc-todo/
├── pom.xml                                    # Configuration Maven
├── src/main/
│   ├── java/com/todo/app/
│   │   ├── MyServletInitializer.java          # Initialisation Servlet 3.0+
│   │   ├── config/
│   │   │   ├── SpringWebConfig.java           # Configuration Spring MVC
│   │   │   ├── HibernateUtil.java             # Configuration Hibernate
│   │   │   └── PropertiesReader.java          # Lecture du fichier properties
│   │   ├── controller/
│   │   │   └── TodoController.java            # Controller Spring MVC
│   │   ├── entities/
│   │   │   └── TodoEntity.java                # Entite Hibernate (table todos)
│   │   ├── dto/
│   │   │   └── TodoDto.java                   # Data Transfer Object
│   │   ├── dao/
│   │   │   ├── Repository.java                # Interface Repository generique
│   │   │   ├── RepositoryImpl.java            # Implementation Hibernate
│   │   │   ├── ITodoDao.java                  # Interface DAO specifique
│   │   │   └── TodoDao.java                   # DAO specifique aux taches
│   │   ├── mapper/
│   │   │   └── TodoMapper.java                # Mapping Entity <-> DTO
│   │   └── service/
│   │       ├── ITodoService.java              # Interface Service
│   │       └── TodoService.java               # Implementation service
│   ├── resources/
│   │   └── database.properties                # Configuration BDD
│   └── webapp/WEB-INF/jsp/
│       ├── index.jsp                           # Tableau de bord
│       ├── todos.jsp                           # Liste des taches
│       ├── add-todo.jsp                        # Formulaire d'ajout
│       └── edit-todo.jsp                       # Formulaire de modification
```

---

## Explication de JSP

### Qu'est-ce que JSP ?

**JSP (JavaServer Pages)** est une technologie de pages dynamiques cote serveur qui permet de melanger du HTML avec du code Java pour generer des pages web dynamiques.

### Comment ça fonctionne ?

1. Le client envoie une requete HTTP au serveur
2. Le serveur Tomcat trouve le fichier JSP correspondant
3. Le JSP est compile en servlet Java
4. La servlet genere du HTML dynamique
5. Le HTML est envoye au client

### Syntaxe de base

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Declaration de variables Java --%>
<% String titre = "Ma Page"; %>

<%-- Affichage de variables --%>
<h1><%= titre %></h1>

<%-- Expression EL (Expression Language) --%>
<h1>${titre}</h1>
```

### Exemple dans notre projet

```jsp
<%-- index.jsp - Tableau de bord --%>
<div class="stat-value text-primary">${totalTaches}</div>
<div class="stat-label">Total Taches</div>

<div class="stat-value text-warning">${enAttente}</div>
<div class="stat-label">En Attente</div>

<div class="stat-value text-success">${enCours}</div>
<div class="stat-label">En Cours</div>
```

**Explication :**
- `${totalTaches}` : Affiche la valeur de l'attribut "totalTaches" passe par le controller
- Le controllerprepare les donnees et les envoie au model
- Le JSP les affiche avec la syntaxe EL `${nomAttribut}`

---

## Explication de JSTL

### Qu'est-ce que JSTL ?

**JSTL (JSP Standard Tag Library)** est une bibliotheque de tags standards qui remplace le code Java brut dans les JSP par des tags XML simples et lisibles.

### Pourquoi utiliser JSTL ?

**Sans JSTL (mauvais) :**
```jsp
<% for(TodoDto todo : todos) { %>
    <tr>
        <td><%= todo.getTitre() %></td>
        <td><%= todo.getPriorite() %></td>
    </tr>
<% } %>
```

**Avec JSTL (bon) :**
```jsp
<c:forEach var="todo" items="${todos}">
    <tr>
        <td>${todo.titre}</td>
        <td>${todo.priorite}</td>
    </tr>
</c:forEach>
```

### Tags JSTL utilises dans le projet

#### 1. `<c:forEach>` - Boucle

```jsp
<%-- Parcourir une liste de taches --%>
<c:forEach var="todo" items="${todos}">
    <tr>
        <td>${todo.titre}</td>
        <td>${todo.priorite}</td>
    </tr>
</c:forEach>

<%-- Parcourir avec index --%>
<c:forEach var="todo" items="${todos}" begin="0" end="4">
    <tr>
        <td>${todo.titre}</td>
    </tr>
</c:forEach>
```

#### 2. `<c:if>` - Condition

```jsp
<%-- Afficher uniquement si la condition est vraie --%>
<c:if test="${todo.dateEcheance != null}">
    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
</c:if>
```

#### 3. `<c:choose>/<c:when>/<c:otherwise>` - Switch

```jsp
<%-- Choisir selon la valeur --%>
<c:choose>
    <c:when test="${todo.priorite == 'HAUTE'}">
        <span class="badge bg-danger">Haute</span>
    </c:when>
    <c:when test="${todo.priorite == 'MOYENNE'}">
        <span class="badge bg-warning">Moyenne</span>
    </c:when>
    <c:otherwise>
        <span class="badge bg-info">Basse</span>
    </c:otherwise>
</c:choose>
```

#### 4. `<fmt:formatDate>` - Formatage de dates

```jsp
<%-- Formater une date --%>
<fmt:parseDate value="${todo.dateEcheance}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
<fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
```

---

## Configuration Spring MVC

### Initialisation Servlet 3.0+ (sans web.xml)

```java
public class MyServletInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
    
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[0]; // Pas de contexte racine
    }
    
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{SpringWebConfig.class}; // Contexte servlet
    }
    
    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"}; // DispatcherServlet sur "/"
    }
}
```

**Explication :**
- `AbstractAnnotationConfigDispatcherServletInitializer` remplace le web.xml
- `getServletConfigClasses()` : Charge la configuration Spring MVC
- `getServletMappings()` : Mappe le DispatcherServlet sur toutes les URLs

### Configuration du View Resolver

```java
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.todo.app")
public class SpringWebConfig implements WebMvcConfigurer {

    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/jsp/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }
}
```

**Explication :**
- `InternalResourceViewResolver` : Resout les noms de vues vers des JSP
- `setPrefix("/WEB-INF/jsp/")` : Repertoire des JSP
- `setSuffix(".jsp")` : Extension des fichiers
- Quand le controller retourne `"index"`, Spring cherche `/WEB-INF/jsp/index.jsp`

---

## Couche Controller

### Le pattern MVC

```
Requete HTTP --> Controller --> Service --> DAO --> Base de donnees
                  │
                  ▼
              Model (donnees)
                  │
                  ▼
              View (JSP)
```

### TodoController.java

```java
@Controller
public class TodoController {

    private final ITodoService todoService = new TodoService();

    // Page d'accueil - Tableau de bord
    @GetMapping("/")
    public String dashboard(Model model) {
        List<TodoDto> allTodos = todoService.findAll();
        
        // Calcul des statistiques
        long enAttente = allTodos.stream()
            .filter(t -> "EN_ATTENTE".equals(t.getStatut())).count();
        long enCours = allTodos.stream()
            .filter(t -> "EN_COURS".equals(t.getStatut())).count();
        long terminee = allTodos.stream()
            .filter(t -> "TERMINEE".equals(t.getStatut())).count();
        
        // Envoi des donnees au model
        model.addAttribute("todos", allTodos);
        model.addAttribute("totalTaches", allTodos.size());
        model.addAttribute("enAttente", enAttente);
        model.addAttribute("enCours", enCours);
        model.addAttribute("terminee", terminee);
        
        return "index"; // Resolu vers /WEB-INF/jsp/index.jsp
    }

    // Liste des taches
    @GetMapping("/todos")
    public String listTodos(@RequestParam(value = "statut", required = false) String statut,
                            Model model) {
        List<TodoDto> todos;
        if (statut != null) {
            todos = todoService.findByStatut(statut);
        } else {
            todos = todoService.findAll();
        }
        model.addAttribute("todos", todos);
        return "todos";
    }

    // Formulaire d'ajout
    @GetMapping("/todos/add")
    public String showAddForm(Model model) {
        model.addAttribute("todo", new TodoDto());
        return "add-todo";
    }

    // Enregistrer une tache
    @PostMapping("/todos/save")
    public String saveTodo(@RequestParam("titre") String titre,
                           @RequestParam("priorite") String priorite,
                           @RequestParam("statut") String statut) {
        TodoDto todo = new TodoDto();
        todo.setTitre(titre);
        todo.setPriorite(priorite);
        todo.setStatut(statut);
        todoService.save(todo);
        return "redirect:/todos"; // Redirection apres enregistrement
    }
}
```

**Explication des annotations :**
- `@Controller` : Marque la classe comme controller Spring MVC
- `@GetMapping("/...")` : Mappe les requetes GET
- `@PostMapping("/...")` : Mappe les requetes POST
- `@RequestParam` : Recupere les parametres de la requete
- `Model model` : Objet pour passer des donnees a la vue
- `return "index"` : Nom de la vue a afficher

---

## Couche Service

### TodoService.java

```java
public class TodoService implements ITodoService {

    private final ITodoDao todoDao = new TodoDao();

    @Override
    public TodoDto save(TodoDto todoDto) {
        TodoEntity entity = TodoMapper.toTodoEntity(todoDto);
        todoDao.save(entity);
        return TodoMapper.toTodoDto(entity);
    }

    @Override
    public TodoDto update(TodoDto todoDto) {
        TodoEntity entity = TodoMapper.toTodoEntity(todoDto);
        todoDao.update(entity);
        return TodoMapper.toTodoDto(entity);
    }

    @Override
    public void delete(Long id) {
        todoDao.delete(id);
    }

    @Override
    public TodoDto findById(Long id) {
        TodoEntity entity = todoDao.findById(id);
        return TodoMapper.toTodoDto(entity);
    }

    @Override
    public List<TodoDto> findAll() {
        return TodoMapper.toListTodoDto(todoDao.findAll());
    }
}
```

**Explication :**
- Le Service contient la logique metier
- Il utilise le DAO pour acceder aux donnees
- Il convertit les Entity en DTO avant de les renvoyer
- Il applique les regles metier (validation, calculs, etc.)

---

## Couche DAO

### Repository generique

```java
public interface Repository<T> {
    T save(T entity);
    T update(T entity);
    void delete(Long id);
    T findById(Long id);
    List<T> findAll();
}
```

### Implementation Hibernate

```java
public class RepositoryImpl<T> implements Repository<T> {
    private final Class<T> entityClass;

    public RepositoryImpl(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    @Override
    public T save(T entity) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(entity);
            transaction.commit();
            return entity;
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
    }

    @Override
    public List<T> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<T> query = session.createQuery(
                "FROM " + entityClass.getSimpleName(), entityClass);
            return query.list();
        }
    }
}
```

**Explication :**
- `Repository<T>` : Interface generique pour toutes les entites
- `RepositoryImpl<T>` : Implementation Hibernate reutilisable
- `session.save(entity)` : Enregistre dans la base de donnees
- `session.createQuery(...)` : Execute une requete HQL

---

## Couche Entity/DTO

### TodoEntity.java (Entite Hibernate)

```java
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

    public enum Priorite {
        HAUTE, MOYENNE, BASSE
    }

    public enum Statut {
        EN_ATTENTE, EN_COURS, TERMINEE
    }
}
```

**Explication des annotations JPA :**
- `@Entity` : Marque la classe comme entite JPA
- `@Table(name = "todos")` : Nom de la table dans la BDD
- `@Id` : Cle primaire
- `@GeneratedValue` : Auto-increment
- `@Column` : Colonne dans la table
- `@Enumerated` : Stocke l'enum comme String dans la BDD

### TodoDto.java (Data Transfer Object)

```java
public class TodoDto {
    private Long id;
    private String titre;
    private String description;
    private String priorite;
    private String statut;
    private LocalDate dateEcheance;
    
    // Getters et Setters
}
```

**Pourquoi un DTO ?**
- L'Entity contient les annotations Hibernate (pas pour la vue)
- Le DTO est simple, sans dependance a la base de donnees
- Permet de transferer les donnees entre les couches

### TodoMapper.java (Mapping)

```java
public class TodoMapper {

    public static TodoDto toTodoDto(TodoEntity entity) {
        if (entity == null) return null;
        return new TodoDto(
            entity.getId(),
            entity.getTitre(),
            entity.getDescription(),
            entity.getPriorite().name(),
            entity.getStatut().name(),
            entity.getDateEcheance()
        );
    }

    public static TodoEntity toTodoEntity(TodoDto dto) {
        if (dto == null) return null;
        TodoEntity entity = new TodoEntity();
        entity.setId(dto.getId());
        entity.setTitre(dto.getTitre());
        entity.setDescription(dto.getDescription());
        entity.setPriorite(TodoEntity.Priorite.valueOf(dto.getPriorite()));
        entity.setStatut(TodoEntity.Statut.valueOf(dto.getStatut()));
        entity.setDateEcheance(dto.getDateEcheance());
        return entity;
    }
}
```

---

## Base de donnees

### Script SQL

```sql
CREATE DATABASE IF NOT EXISTS todo_db;
USE todo_db;

CREATE TABLE todos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    description TEXT,
    priorite ENUM('HAUTE', 'MOYENNE', 'BASSE') DEFAULT 'MOYENNE',
    statut ENUM('EN_ATTENTE', 'EN_COURS', 'TERMINEE') DEFAULT 'EN_ATTENTE',
    date_echeance DATE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Configuration Hibernate

```java
public class HibernateUtil {
    private static SessionFactory sessionFactory;

    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            Properties settings = new Properties();
            settings.put("hibernate.connection.driver_class", "com.mysql.cj.jdbc.Driver");
            settings.put("hibernate.connection.url", "jdbc:mysql://localhost:3306/todo_db");
            settings.put("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
            settings.put("hibernate.hbm2ddl.auto", "update");
            // ...
        }
        return sessionFactory;
    }
}
```

**Explication :**
- `hbm2ddl.auto = update` : Hibernate cree/met a jour les tables automatiquement
- `dialect` : Adapte les requetes SQL pour MySQL 8

---

## Vues JSP

### Exemple complet : index.jsp

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Todo App - Tableau de bord</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Tableau de bord</h1>
        
        <div class="row">
            <div class="col-md-3">
                <div class="stat-value text-primary">${totalTaches}</div>
                <div class="stat-label">Total Taches</div>
            </div>
            <div class="col-md-3">
                <div class="stat-value text-warning">${enAttente}</div>
                <div class="stat-label">En Attente</div>
            </div>
        </div>

        <table class="table">
            <c:forEach var="todo" items="${todos}">
                <tr>
                    <td>${todo.titre}</td>
                    <td>
                        <c:choose>
                            <c:when test="${todo.priorite == 'HAUTE'}">
                                <span class="badge bg-danger">Haute</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-warning">Moyenne</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
```

---

## Conclusion

Ce projet demontre les bases de Spring MVC avec JSP et JSTL :

1. **JSP** : Technologie simple pour les pages dynamiques
2. **JSTL** : Evite le code Java brut dans les vues
3. **Spring MVC** : Framework web puissant et flexible
4. **Architecture en couches** : Separation claire des responsabilites

### Avantages de cette approche
- Simple a comprendre pour les debutants
- Direct et concis
- Bien maitrise dans le monde professionnel

### Inconvenients
- Mauvaise separation HTML/Java (dans les JSP)
- Pas de validation HTML cote client
- Code difficile a maintenir sur de gros projets

### Vers quoi aller ?
- **Tiles** : Ajouter un layout reutilisable (Projet 2)
- **Thymeleaf** : Utiliser des templates HTML naturels (Projet 3)
