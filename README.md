# FinalProject:
# Voyager's Handbook

### Description
Attention to detail is key when traveling internationally: you don't want to get stuck in customs, make a mistake about visa requirements, or forget that you're not allowed to chew gum in Singapore. Voyager's Handbook is a web app that allows a user to keep track of important information about travel requirements for various countries. With Voyager's Handbook, a user can plan trips in a "My Trips" section, and take notes on the requirements for the countries they will be visiting. They can access vetted information entered by site administrators, and also view comments and tips left by other users. Finally, the user also can create a "Wishlist" of countries to keep in mind for future travel plans.

### How to Run
* Access online at: http://3.13.22.174:8080/voyager/#/home

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

### Lessons Learned
* Erik: Learning To trust my instinct and that as a team we will hold each other up and accountable. As a team we worked extremely well together. I need to trust in my abilities and learn to work through the process from start to end.

* Eric: This was a great opportunity to build something from the ground up while collaborating remotely. Communication was key to avoid merge conflicts and wasted effort. We did great as a team by communicating on Slack, Trello, and Zoom. It was also great to get some more experience in Angular, along with the by-now-familiar back-end technologies.

* Chelsey: Designing with the end user cases in mind is key to making a functional application and also endless testing.

* Thomas:
Ensure the front-end is catering to the needs of the back-end, and not visa-versa.

## API
### AdviceType

| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|
| GET | `countries/{cid}/adviceTypes` | void | `List<AdviceType>` | Gets all AdviceTypes for a given Country |
| GET | `countries/{cid}/adviceTypes/{atid}` | void | `AdviceType` | Get an AdviceType by Country ID and advice type ID |
| POST | `api/countries/{cid}/adviceTypes` | `AdviceType`, `Principal` | `AdviceType` | Create AdviceType for a given Country |
| PUT | `api/countries/{cid}/adviceTypes/{atid}` | `AdviceType`, `Principal` | `AdviceType` | Edit an AdviceType for a given Country |
| DELETE | `api/countries/{cid}/adviceTypes/{atid}` | `Principal` | void | Delete AdviceType by Country ID and AdviceType ID |


### Auth

| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|
| GET | `authenticate` | `Principal` | `Principal` | Authenticates a User |
| POST | `register` | `User` | `User` | Registers a new User |


### Comment

| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|
| GET | `countries/{countryId}/comments` | void | `List<Comment>` | Get all enabled comments for a country |
| GET | `countries/{countryId}/comments/all` | void | `List<Comment>` | Get all comments for a country (including disabled) |
| GET | `countries/{countryId}/comments/disabled` | void | `List<Comment>` | Gets all disabled comments for a country |
| GET | `countries/{countryId}/comments/{cid}` | `Principal` | `Comment` | Get comment by country and comment ID |
| POST | `api/countries/{countryId}/comments` | `Principal`, `Comment` | `Comment` | Create a comment for a given country |
| PUT | `api/countries/{countryId}/comments/{commentId}` | `Comment`, `Principal` | Edits a comment |
| DELETE | `api/countries/{countryId}/comments/{commentId}` | `Principal` | `boolean` | Deletes comment by ID |


### Country

| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|
| GET | `countries` | void | `List<Country>` | Gets all countries |
| GET | `countries/search/{keyword}` | void | `List<Country>` | Search for country by keyword |
| GET | `countries/{cid}` | void | `Country` | Get a country by ID |
| POST | `api/countries` | `Country`, `Principal` | `Country` | Creates a new country |
| PUT | `api/countries/{cid}` | `Country`, `Principal` | `Country` | Edits a country |
| DELETE | `api/countries/{cid}` | `Principal` | void | Delete a country by ID |


#### Picture

| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|
| GET | `countries/{cid}/pictures` | void | `List<Picture>` | Get all pictures for a given country |
| GET | `countries/{cid}/pictures/{pid}` | void | `Picture` | Get a picture by picture ID and country ID |
| POST | `api/countries/{cid}/pictures` | `Picture`, `Principal` | `Picture` | Create new picture for a given country |
| PUT | `api/countries/{cid}/pictures/{pid}` | `Picture`, `Principal` | `Picture` | Edit a picture |
| DELETE | `api/countries/{cid}/pictures/{pid}` | `Principal` | void | Deletes a picture by country ID and picture ID |


#### Trip

| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|
| GET | `api/trips` | `Principal` | `List<Trip>` | Gets all trips associated with a given user |
| GET | `api/trips/{id}` | void | `Trip` | Gets a trip by ID |
| POST | `api/trips` | `Trip`, `Principal` | `Trip` | Creates a new trip |
| PUT | `api/trips/{id}` | `Trip`, `Principal` | `Trip` | Edits a given trip |
| DELETE | `api/trips/{id}` | `Principal` | void | Deletes a given trip |


#### User
| HTTP Method | Resource URI | Request Body | Returns | Functionality |
|-------------|--------------|--------------|---------|--------|
| GET | `api/users` |`Principal` | `List<User>` | Gets all users |
| GET | `users/search/{username}` | `Principal` | `User` | Gets a User by username |
| GET | `api/users/{uid}` | `Principal` | `User` | Gets a User by ID |
| POST | `api/users` | `Principal` | `User` | Creates a new user |
| PUT | `api/users/{uid}` | `User`, `Principal` | `User` | Edit a User |
| DELETE | `api/users/{uid}` | `Principal` | void | Deletes a User by ID |
