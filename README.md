<div align="center">
<h1><a href="https://expert-class-backend.herokuapp.com/" target="_blank">Expert Class API</a></h1>
</div>

<div align="center">
    <img src="https://img.shields.io/badge/Microverse-blueviolet">
    <img src="https://img.shields.io/badge/Academic-blue">
    <img src="https://img.shields.io/badge/Ruby_on_Rails-darkred">
    <img src="https://img.shields.io/badge/PostgreSQL-skyblue">
    <img src="https://img.shields.io/badge/Rspec-yellow">
    <img src="https://img.shields.io/badge/Rswag-green">
    <img src="https://img.shields.io/badge/Factory_Bot-red">
    <img src="https://img.shields.io/badge/Cloudinary-purple">
    <img src="https://img.shields.io/badge/Heroku-violet">
</div>

<br>

<p align="center">This RESTFUL API works as the backend for a React web app. We host the API in Heroku. All images are hosted in Cloudinary.</p>

<br>

<div align="center"><img width="100%" alt="app screenshot mobile" src="./.github/images/Screenshot_main.png">
<img width="45%" alt="app screenshot mobile" src="./.github/images/Screenshot_register.png">
<img width="45%" alt="app screenshot mobile" src="./.github/images/Screenshot_remove.png">
<img width="30%" alt="app screenshot mobile" src="./.github/images/Screenshot_main_mobile.png">
<img width="30%" alt="app screenshot mobile" src="./.github/images/Screenshot_nav_mobile.png">
</div>

<br>

## About
Expert Class API is the backend for a ***fully responsive*** web app that I built with a team of 4 members. The front end of the app is handled separately by another app. The [repo for the front-end is here](https://github.com/StarSheriff2/expert-class-frontend). The API documentation of this project was generated with the <strong>'rswag'</strong> gem. We built request and integration tests.  We use cross-site session cookies to handle user authentication. We use PostgreSQL as the database and Cloudinary to store all images in the cloud.

### API Documentation
We used Rswag to generate all the API documentation directly from our tests. You will find all the endpoints necessary to use our API here:
[Documentation](https://expert-class-backend.herokuapp.com/api-docs)

### Features:
- authenticate user
- create new user
- create and delete a class
- show all classes
- show all reserved classes
- reserve a class

### Front-end React app
- The front-end associated with this app is [here](https://expert-class-frontend-v2.netlify.app).

- The Github repo of the front-end is [here](https://github.com/StarSheriff2/expert-class-frontend).

### Live Demo

Deployed to Heroku: [Live Demo](https://expert-class-backend.herokuapp.com/)

### Video Presentation

...coming soon

### Built With
- Ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) \[arm64-darwin20\]
- Rails 6.1.4.1
- PostgreSQL 14
- Cloudinary (for image storing)
- Rspec (testing)
- Faker gem
- Factory bot
- Heroku

### Project Management

We used an agile methodology to manage all the tasks in this project. This project's tasks are described in [this kanban board](https://github.com/StarSheriff2/expert-class/projects/1).

We used GitHub's built-in Kanban board:
![kanban](https://user-images.githubusercontent.com/61250665/137405588-7fc8d606-5b01-43ca-beae-5c29ae231d2e.png)

## Getting Started

To get a local copy up and running, follow these simple example steps.

### Prerequisites
- Ruby 3.0.2p107
- Rails 6.1.4.1
- PostgreSQL 14
- Cloudinary account

### Get files
1. Open your terminal or command prompt.
2. If you do not have git installed in your system, skip this step and go to step 3; otherwise, go to the directory where you want to copy the project files and clone it by copying this text into your command prompt/terminal:
```
  git clone git@github.com:StarSheriff2/expert-class.git
```
<br>Now go to the ***"Install Dependencies"*** section.

3. Download the program files by clicking on the green button that says “**Code**” on the upper right side of the project frame.
4. You will see a dropdown menu. Click on “**Download ZIP**.”
5. Go to the directory where you downloaded the **ZIP file** and open it. Extract its contents to any directory you want in your system.

### Install Dependencies
1. If you are not in your system terminal/command prompt already, please open it and go to the directory where you cloned the remote repository or extracted the project files.
2. While in the project root directory, type
    ```
    bundle install
    ```
This command will install all the necessary gems in your system.

#### Cloudinary Setup
> You will need a Cloudinary account to be able to deploy this app locally. If you already have one, copy your YML file into the config folder; otherwise, create a new account by going to Cloudinary and sign up for a free account: [https://cloudinary.com/](https://cloudinary.com/).

Once you have your new Cloudinary account set up, follow these steps:
1. Login with your new account
2. Go to your Cloudinary dashboard
3. Look for the YML file and click on it to download it
![cloudinary_yml_file](./other/README_images/cloudinary_setup_img.png)
4. Copy this file into your config folder

### Database Setup

1. Edit the `"database.yml"` file in your `"config"` folder:
    - Change the `username` and `password` under ***`default: &default`*** to your PostgreSQL local credentials or just delete lines 23 and 24 altogether
1. Now, in your terminal, type <code>bin/rails db:setup</code> to create your local databases, load the schema, and initialize with the seed data.

You are all set now!
## Usage

1. In your terminal, run <code>bin/rails server</code> while inside the root directory of the repository files
2. The app allows API calls using curl or your favorite API client, such as Postman, HTTPPie or VS Code's Thunder Client. Here's a link to [HTTPIE](https://httpie.io).

**Note:<br>_These command will not stop on its own. To exit, hit "ctrl + c"_**

## Development
### Testing
We created all types of tests for this project:
- Unit / Model tests
- Integration tests
- API request tests

To run all tests, type this into command line:
```
 rspec
```

### Linters
To run ***Rubocop***, go to the root directory of your repository and copy/paste the following command into your terminal:
```
 rubocop .
```

## Authors
👤 **Arturo Alvarez**
- Github: [@StarSheriff2](https://github.com/StarSheriff2)
- Twitter: [@ArturoAlvarezV](https://twitter.com/ArturoAlvarezV)
- Linkedin: [Arturo Alvarez](https://www.linkedin.com/in/arturoalvarezv/)

👤 **Breno Xavier**

- GitHub: [@brenoxav](https://github.com/brenoxav)
- LinkedIn: [Breno Xavier](https://linkedin.com/in/brenoxav)

👤 **Francis Uloko**

- GitHub: [@francisuloko](https://github.com/francisuloko)
- Twitter: [@francisuloko](https://twitter.com/francisuloko)
- LinkedIn: [Francis Uloko](https://linkedin.com/in/francisuloko)

👤 **Mih Julius**

- GitHub: [@Mihndim2020](https://github.com/Mihndim2020)
- Twitter: [@mihndim](https://github.com/mih-julius)
- LinkedIn: [Mih Julius](https://www.linkedin.com/mih-julius)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/StarSheriff2/expert-class/issues).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](https://github.com/StarSheriff2/expert-class/blob/master/LICENSE) licensed.
