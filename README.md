# Logo-Quiz-App
This repository contains a simple Android/iOS game implementation of a Logo Quiz. The game presents logos from a JSON file and challenges the player to guess the correct name associated with each logo.
This project is a simple iOS game that displays logos one by one and challenges players to match the logo with its correct name. The game is aimed at testing players' knowledge of various logos and brands.

# Functionality Overview
Logo Display and Input Matching:

Logos are fetched from a JSON file (logo.txt) which contains image URLs and correct names.
Each logo is displayed along with jumbled letters from which players select to form the correct name.
# Game Mechanics:

Players input their answer by arranging jumbled letters.
Correct answers earn points, and incorrect answers prompt a retry.
Scores are tracked and displayed to the player.
App State and Handling:

The app manages states such as game play, pause/resume functionality, and score tracking.
A countdown timer adds urgency to the game, rewarding faster responses with higher scores.
Code Structure and Modularity
ViewModel (LogoViewModel):

Manages the business logic for loading logos, images, and handling game mechanics.
Uses protocols (LogoViewModelDelegate) for delegation and modular communication.
View Controller (LogoQuizViewController):

Handles UI interactions and updates based on ViewModel callbacks.
Implements UI components like UIImageView for logo display and UIStackView for letter selection.
Data Handling:

JSON decoding (LogoLoader) to parse logo data from logo.txt.
Image loading (ImageLoader) asynchronously fetches logo images for display.
Extendability and Abstraction
# Easy Modification:
Adding new features (e.g., levels, hints) can be achieved by extending ViewModel functionalities without altering core logic extensively.
UI changes are isolated within the ViewController, ensuring flexibility in design updates.
Enhancements and Future Considerations
# Additional Features:
Implement multiple levels with increasing difficulty.
Introduce hints or lifelines to assist players.
Include a leaderboard to track high scores across players.
