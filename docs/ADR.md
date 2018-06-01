# Architecture Decision Record

### 2018-05-28 - Framework to be used

* Context: Select a framework to build a music API, primary options are Rails, Grape or Rails with Grape

* Decision: Grape as Rack App, without Rails

* Consequences:

  * Lose some cool tools that Rails brings out of the box, that can need to be added to the project.
  * Remove the unnecessary Rails' gems and structure that is not needed.
  * Take advantage of Grape that is built to work with APIs, and has a complete set of facilities.

### 2018-05-28 - Database Type and ORM to be used

* Context: First decide about using a relational or non-relational database, after that decide which ORM and will be used. Players here are PostgreSQL, MySQL, and MongoDB. And ORM ActiveRecord, Sequel, and MongoId.

* Decision: Use a Relational database: PostgreSQL and ActiveRecord gem as ORM.

* Consequences:

  * The many to many relations fits better to a relational database
  * Sequel and ActiveRecord provides similar model functionalities. AR wins here, only because it is the most used in Ruby programming.

### 2018-05-28 - Database Models Design

* Context: Define the Entities and its Relations that will support the requirements.

* Decision: Identify Entities and Relations between them, but do not implement until were necessary.

![Models](models.png)

* Consequences:

  * The main element here is the **Song**, that permit duplicates on *name*, but not on *version*, could belong to a **Band** and/or an **Album** or not, but should have at least one **Musician** or many.
  * **Musician** & **Band** fit well to a STI: **Artist**
  * The missing actor here is the **User** that's the owner of the **PlayList**

### 2018-05-28 - Application breakdown, files and folders

* Context: Define folder structure and load criteria for the entire application.

* Decision: The app root will have two main folders: `api` for all `Grape::API` classes, and `app` for models and services. The `api` folder will have one sub-folder for each resource and within it, a file for each endpoint.

* Consequences:

  * Each endpoint of the API will have its own isolated file.
  * Perhaps this decision leads to some duplication, but it will not be a problem compared with the cleanliness that it will provide.

### 2018-05-29 - Code load strategy

* Context: Define code load strategy, for gems, app, and specs code. In production, the impact is minimal because of the code is loaded only on restarts. In development with a server on, we want to reload the code each time it is changed. In the test environment, it's critical, because of the load time of the gems and code is added to the test runtime, even if it is loading unnecessary gems and code.

* Decision: Load only the needed code for the task that we have in hands, adding `require: false` for optional gems and doing an explicit require when they are needed, requiring by default the base of the app and load the components needed in each part of the code. For test split the `spec_helper` depending on the gems needed: base, db, request.

* Consequences:

  * When app grows tests still would be fast.
  * We need to pay attention to the needed stuff for each piece of code.


### 2018-06-01 - Name for the namespace that holds main classes used in endpoints (actual: services)

* Context: Actual name **service** is very vague, we need to be explicit that we hold business rules in this folder.

* Decision: Rename the service folder as **use_cases**.

* Consequences:

  * It's clear that this will be the entire point of each action, and the business rules should be held in its files.
  * Currently, exists a class **CreateArtist** used by endpoints of **Band::Create** and **Musician::Create**, this does not represent an use case and should be refactored.
