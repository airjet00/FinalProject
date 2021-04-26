# FinalProject:
# Voyager's Handbook

### Description
Attention to detail is key when traveling internationally: you don't want to get stuck in customs, make a mistake about visa requirements, or forget that you're not allowed to chew gum in Singapore. Voyager's Handbook is a web app that allows a user to keep track of important information about travel requirements for various countries. With Voyager's Handbook, a user can plan trips in a "My Trips" section, and generate checklists of requirements for the countries they will be visiting. They can access vetted information entered by site administrators, and also view comments and tips left by other users. Finally, the user also can create a "Wishlist" of countries to keep in mind for future travel plans.

### How to Run
* Access online at: -- link --

### Topics and Technologies Used
Front End:
* HTML, CSS, Bootstrap
* Angular
* TypeScript

Creating and consuming a REST API

Back End:
* Spring framework, including Spring Boot, Spring Data, Spring Security, and Spring REST
* Dependency management: Gradle
* Test-driven design with JUnit
* Relational databases: MySQL, Java Persistence API with Hibernate

## API
### AdviceType

| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|
| GET | `countries/{cid}/adviceTypes` | void | `List<AdviceType>` | Gets all AdviceTypes for a given Country |
| GET | `countries/{cid}/adviceTypes/{atid}` | void | `AdviceType` | Get an AdviceType by Country ID and advice type ID |
| POST | `api/countries/{cid}/adviceTypes` | `AdviceType`, `Principal` | `AdviceType` | Create AdviceType for a given Country |
| PUT | `api/countries/{cid}/adviceTypes/{atid}` | `AdviceType`, `Principal` | `AdviceType` | Create an AdviceType for a given Country | 
| DELETE | `api/countries/{cid}/adviceTypes/{atid}` | `Principal` | void | Delete AdviceType by Country ID and AdviceType ID |


### Auth

| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|
| GET | `authenticate` | `Principal` | `Principal` | Authenticates a User |
| POST | `register` | `User` | `User` | Registers a new User |


### Comment
| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|








#### Picture
| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|

#### Trip
| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|

#### User
| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|


### Lessons Learned
* Erik:

* Eric: This was a great opportunity to build something from the ground up while collaborating remotely. Communication was key to avoid merge conflicts and wasted effort. We did great as a team by communicating on Slack, Trello, and Zoom. It was also great to get some more experience in Angular, along with the by-now-familiar back-end technologies.

* Chelsey:

* Thomas: