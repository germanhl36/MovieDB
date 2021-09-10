# App
## Overview

Most of us want relax on the sofa and enjoy a movie with friends and family. For this project, an application will be built to allow users to discover the most popular movies that are on the billboard.

## Description

Create an iOS app that shows a list of movies with the next especifications

**Your app must:**
- Present to the user in the form of a grid movie posters at the beginning.
- Allow the user to change their classification order through a configuration:
    * The order must be by most popular or higher audience
- Allow the user to click on a movie poster and transition to a details screen with additional information such as
    * Original title
    * Miniature image of the poster
    * Synopsis (general view taken from the API)
    * User rating or rating (API)
    * Release date
- Allow at least support for two languages (English and Spanish)
- The app **must** use native controls and icons

## Requirements

* You must use swift
* Your app must work in the latest version of Android and iOS  
* Images should be cache internally
* It’s allowed to use external libraries (is possible to use for example **Picasso** and/or **Volley**)

## Implementation

To fetch popular movies, you will use the API from themoviedb.org.
* If you don’t already have an account, you will need to [create one](https://developers.themoviedb.org/3/getting-started/introduction) in order to request an API Key.
* In your request for a key, state that your usage will be for educational/non-commercial use. You will also need to provide some personal information to complete the request. Once you submit your request, you should receive your key via email shortly after.
* In order to request popular movies you will want to request data from the `/movie/popular` and `/movie/top_rated` endpoints. An API Key is required.
* Once you obtain your key, you append it to your HTTP request as a URL parameter like so:
* `http://api.themoviedb.org/3/movie/popular?api_key`=[YOUR_API_KEY]
* You will extract the movie id from this request. You will need this in subsequent requests.

You will notice that the API response provides a relative path of a movie poster image when requesting metadata for a specific movie.

For example, the return route of the poster for Interstellar is
`/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg`

You will have to add a base path in front of this relative path to build the full URL that you will have to search for the image

It was built using 3 parts:
1. The base URL will look like this: `http://image.tmdb.org/t/p/`.
2. Next, a _size_ is needed, which will be one of the following: `w92`, `w154`, `w185`, `w342`, `w500`, `w780`, or `original`. For most phones the use of `w185` is recommended.
3. And finally the last path returned by the query, in this case `/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg`

The combination of these three parts gives us a final URL of `http://image.tmdb.org/t/p/w185/n/BNZadXqJSdt05SHLqgT0HuC5Gm.jpg`

This is also explained explicitly in the API documentation in [/configuration](https://themoviedb.docs.apiary.io/#reference).

## Extras

* Improve UI/UX for the app
* Handle error scenarios (no connectivity, server errors)
* Loading feedback
* Parallax effect on header scroll
* Transform the action bar in a opaque color during scroll
* Automated tests
* Different layout for tablet or landscape orientation

# Mockups phone

![mockup](mockup_phone_1.png "Mockup")     ![mockup2](mockup_phone_2.png "Mockup Detail")

# Mockup tablet

![mockup_tablet](mockup_tablet.png "Mockup Tablet")

## Submission

Create a github repo and invite the following users:
* cfabela@itexico.com
* AngelItexico
* drmendozaz

Note: Remember that this code will be used to evaluate all the best practices that you use on your projects, please be careful and add proper commits comments to your
submits.
