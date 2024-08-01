# MovieApp

## Overview

MovieApp is an iOS application that allows users to browse, search, and favorite movies using the OMDb API. The app includes features such as a splash screen, movie list, detail screen, search functionality, and favorites management.

## Setup

1. Clone the repository:
2. Open the project in Xcode:
3. Install dependencies (if any).
4. Replace the placeholder API key in `APIService.swift` with your OMDb API key.
5. Run the application on the simulator or a physical device.

## Features

- Splash screen with app logo.
- List of movies fetched from the OMDb API.
- Movie detail screen with detailed information.
- Search functionality to filter movies by title.
- Ability to mark movies as favorites.
- UserDefaults used to save favorite movies.

## Assumptions

- The OMDb API is reliable and provides accurate data.
- The API key provided has sufficient access limits for testing and usage.
- The app will run on iOS 13.0 or later.

## Potential Improvements

- Add pagination support for movie list.
- Implement image caching for better performance.
- Add support for offline access and caching.
- Improve UI/UX with more animations and custom design.

## License

This project is licensed under the MIT License.
