# Spring MVC - Todo App (JSP + JSTL)

[![Java](https://img.shields.io/badge/Java-11-green)](https://www.oracle.com/java/)
[![Spring MVC](https://img.shields.io/badge/Spring%20MVC-5.2.22-yellowgreen)](https://spring.io/projects/spring-framework)
[![JSP](https://img.shields.io/badge/JSP-JSTL-blue)](https://www.oracle.com/java/technologies/javaserver-pages.html)
[![MySQL](https://img.shields.io/badge/MySQL-8.x-blue)](https://www.mysql.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.2-purple)](https://getbootstrap.com/)

## Description

Application de gestion de taches developpee avec Spring MVC, JSP et JSTL. Cette application permet de gerer des taches avec des fonctionnalites CRUD completes, un tableau de bord avec statistiques, et des filtres par statut et priorite.

### Capture d'ecran de l'interface

![Dashboard](screenshots/dashboard.png)
*Tableau de bord avec statistiques et dernieres taches*

![Liste des taches](screenshots/todos.png)
*Liste complete des taches avec actions*

![Formulaire](screenshots/add-todo.png)
*Formulaire d'ajout d'une tache*

---

## Environnement

| Outil | Version |
|-------|---------|
| JDK | 11 |
| Tomcat | 9.x |
| Maven | 3.9.x |
| Spring MVC | 5.2.22.RELEASE |
| Hibernate | 5.4.10.Final |
| MySQL | 8.x |
| Bootstrap | 5.2.0 |

---

## Architecture du projet

```
springmvc-todo/
├── pom.xml
├── src/main/
│   ├── java/com/todo/app/
│   │   ├── MyServletInitializer.java        # Initialisation Servlet 3.0+
│   │   ├── config/
│   │   │   ├── SpringWebConfig.java          # Configuration Spring MVC
│   │   │   ├── HibernateUtil.java            # Configuration Hibernate
│   │   │   └── PropertiesReader.java         # Lecture du fichier properties
│   │   ├── controller/
│   │   │   └── TodoController.java           # Controller Spring MVC
│   │   ├── entities/
│   │   │   └── TodoEntity.java               # Entite Hibernate
│   │   ├── dto/
│   │   │   └── TodoDto.java                  # Data Transfer Object
│   │   ├── dao/
│   │   │   ├── Repository.java               # Interface Repository generique
│   │   │   ├── RepositoryImpl.java           # Implementation Hibernate
│   │   │   ├── ITodoDao.java                 # Interface DAO specifique
│   │   │   └── TodoDao.java                  # DAO specifique aux taches
│   │   ├── mapper/
│   │   │   └── TodoMapper.java               # Mapping Entity <-> DTO
│   │   └── service/
│   │       ├── ITodoService.java             # Interface Service
│   │       └── TodoService.java              # Logique metier
│   ├── resources/
│   │   └── database.properties               # Configuration BDD
│   └── webapp/WEB-INF/jsp/
│       ├── index.jsp                          # Tableau de bord
│       ├── todos.jsp                          # Liste des taches
│       ├── add-todo.jsp                       # Formulaire d'ajout
│       └── edit-todo.jsp                      # Formulaire de modification
```

---

## Configuration du projet

### Dependances Maven (pom.xml)

```xml
<dependencies>
    <!-- Spring MVC -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-webmvc</artifactId>
        <version>5.2.22.RELEASE</version>
    </dependency>

    <!-- JSTL -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>jstl</artifactId>
        <version>1.2</version>
    </dependency>

    <!-- Hibernate -->
    <dependency>
        <groupId>org.hibernate</groupId>
        <artifactId>hibernate-entitymanager</artifactId>
        <version>5.4.10.Final</version>
    </dependency>

    <!-- MySQL -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>8.0.13</version>
    </dependency>

    <!-- Bootstrap -->
    <dependency>
        <groupId>org.webjars</groupId>
        <artifactId>bootstrap</artifactId>
        <version>5.2.0</version>
    </dependency>
</dependencies>
```

### Configuration Spring MVC

La configuration est faite par programme (pas de web.xml) via `AbstractAnnotationConfigDispatcherServletInitializer` :

```java
public class MyServletInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{SpringWebConfig.class};
    }

    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }
}
```

Le `SpringWebConfig` configure le view resolver JSP :

```java
@Bean
public InternalResourceViewResolver viewResolver() {
    InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
    viewResolver.setViewClass(JstlView.class);
    viewResolver.setPrefix("/WEB-INF/jsp/");
    viewResolver.setSuffix(".jsp");
    return viewResolver;
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
settings.put("hibernate.connection.driver_class", "com.mysql.cj.jdbc.Driver");
settings.put("hibernate.connection.url", "jdbc:mysql://localhost:3306/todo_db");
settings.put("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
settings.put("hibernate.hbm2ddl.auto", "update");
```

---

## Installation

### 1. Cloner le projet

```bash
git clone https://github.com/votre-username/springmvc-todo.git
cd springmvc-todo
```

### 2. Configurer la base de donnees

Editez le fichier `src/main/resources/database.properties` :

```properties
db.username=root
db.password=votre_mot_de_passe
db.url=jdbc:mysql://localhost:3306/todo_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC&createDatabaseIfNotExist=true
```

### 3. Compiler le projet

```bash
mvn clean install
```

### 4. Deployer sur Tomcat

Copiez le fichier `target/springmvc-todo.war` dans le dossier `webapps` de Tomcat.

---

## Execution

1. Demarrer Tomcat
2. Ouvrir le navigateur : `http://localhost:8080/springmvc-todo/`
3. Le tableau de bord s'affiche

### Routes disponibles

| Methode | URL | Description |
|---------|-----|-------------|
| GET | `/` | Tableau de bord |
| GET | `/todos` | Liste des taches |
| GET | `/todos/add` | Formulaire d'ajout |
| POST | `/todos/save` | Enregistrer une tache |
| GET | `/todos/edit/{id}` | Formulaire de modification |
| POST | `/todos/update` | Mettre a jour une tache |
| GET | `/todos/delete/{id}` | Supprimer une tache |

---

## Code commente

### Controller

```java
@Controller
public class TodoController {
    private final ITodoService todoService = new TodoService();

    @GetMapping("/")
    public String dashboard(Model model) {
        List<TodoDto> allTodos = todoService.findAll();
        // Calcul des statistiques
        long enAttente = allTodos.stream()
            .filter(t -> "EN_ATTENTE".equals(t.getStatut())).count();
        model.addAttribute("enAttente", enAttente);
        return "index";  // Resolu vers /WEB-INF/jsp/index.jsp
    }
}
```

### Vue JSP avec JSTL

```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
```

---

## Technologies utilisees

- **Spring MVC 5.2.22** : Framework web MVC
- **JSP + JSTL** : JavaServer Pages avec Standard Tag Library
- **Hibernate 5.4.10** : ORM pour la persistance
- **MySQL 8** : Base de donnees relationnelle
- **Bootstrap 5.2** : Framework CSS pour le responsive
- **Maven** : Outil de build

---

## Auteur

Developpe avec Spring MVC - JSP - JSTL
