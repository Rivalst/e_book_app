# e_book_app

## Getting Started

Hello! 👋 This app provides you with a world of books.

The books are fetched from the open-source API:
- [Open Library](https://openlibrary.org/developers/api)

The design is inspired by Behance:
- [E-Book App Case Study by Lazar Filipovic](https://www.behance.net/gallery/171074413/E-Book-App-Case-Study)

# App consists of:

- Authentication
    - On Boarding page
    - Log In page
    - Sign Up page
- Home
    - Suggested
    - Popular
    - Top Authors
- Discover
    - Search
    - Categories
    - Popular
- Library
    - Your Books
    - Your lists
    - In the plans
    - Finished
- Profile
    - Language
    - Info
    - Help Center
    - Profile chang

## ============== PROVIDE FOR AUTHENTICATION ==============

This section covers the authentication part of the app, including the main pages such as 
[Log In], [Sign Up], and [On boarding].

- [On boarding]
  When the user first opens the app, they will see the [on boarding] page. 
  This is a 'Welcome' page where the user can choose the next step: 
  [Log In] or [Sign Up]. 
  The logic for this page controls and checks if the user is authenticated.
  [lib/controller/bloc/app/app_bloc/...]

- [Log in]
  This page is a part of the authentication process. 
  It contains two text fields for the user to input their email and password. 
  The logic in this page handles the authentication process.
  [lib/controller/cubit/login/...]

- [Sign up]
  This page is also a part of the authentication process. 
  It contains text fields for the user to provide their email, name, password, and confirm password.
  The logic in this page manages the user registration process.
  [lib/controller/cubit/signup/...]
        
    
