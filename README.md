# MyFlix
An iOS app for movie discovery using [TMDB's](https://www.themoviedb.org/) APIs. MyFlix is structured using MVVM architecture.

## Features 🚀
- Discover popular, trending, top rated and upcoming movies in `MoviesView`
- View details about each movie including title, overview, release year and IMDB rating in `MovieDetailsView`
- These movie details are animated 😉
- View similar movies (if available) for a movie in `MovieDetailsView`
- Add movies to your watchlist from `MovieDetailsView` and see them in `WatchListView`. This data is saved using Core Data.
- Search for movies in `SearchView`
- Views for loading and error states across the app with retry options

## Getting Started 🏗️

To build and run this app successfully, you need to take the following steps after cloning the project:

- Open the project in Xcode
- Create a `Secrets.plist` file
- Create a free [TMDB](https://www.themoviedb.org/signup) account
- Once logged in to TMBD, click on your avatar in the top right section
    - Click on `Settings`
    - Click on `API` in the sidebar by the left
    - Copy the API Read Access Token
- Back to Xcode
    - Open the `Secrets.plist` created in the first step
    - Add a key `ACCESS_TOKEN`
    - Paste the access token you copied as the value of this key
- You're all set 🎉🎉🎉

## Demo 🎥👾

## Screenshots 📷
<p float="left">
<img src="https://raw.githubusercontent.com/Crazelu/myflix/main/screenshots/loading.png"  width="32.5%"> 
<img src="https://raw.githubusercontent.com/Crazelu/myflix/main/screenshots/home.png"  width="32.5%"> 
<img src="https://raw.githubusercontent.com/Crazelu/myflix/main/screenshots/details.png"  width="32.5%"> 
</p>
<p float="left">
<img src="https://raw.githubusercontent.com/Crazelu/myflix/main/screenshots/watchlist.png"  width="32.5%"> 
<img src="https://raw.githubusercontent.com/Crazelu/myflix/main/screenshots/search.png"  width="32.5%">
</p> 