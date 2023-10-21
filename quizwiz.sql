-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 21, 2023 at 06:40 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quizwiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image_url`) VALUES
(1, 'General Knowledge', 'images/general knowledge.png'),
(2, 'Science', 'images/Frame_10.png'),
(3, 'History', 'images/history.png'),
(4, 'Geography', 'images/geography.png'),
(5, 'Literature', 'images/literature.png'),
(6, 'Movies', 'images/movies.png'),
(7, 'Music', 'images/music.png'),
(8, 'Sports', 'images/sports.png'),
(9, 'Food and Cuisine', 'images/food.png'),
(10, 'Technology', 'images/technology.png'),
(11, 'Art and Culture', 'images/art.png'),
(12, 'Nature and Wildlife', 'images/nature.png'),
(13, 'Pop Culture', NULL),
(14, 'Politics', NULL),
(15, 'Celebrities', NULL),
(16, 'Mythology', NULL),
(17, 'Religion', NULL),
(18, 'Language and Linguistics', NULL),
(19, 'Mathematics', 'images/mathematics.png'),
(20, 'Fun', 'images/Frame_9.png'),
(21, 'Puzzle', 'images/Frame_8.png'),
(22, 'Animals', 'images/animals.png');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_question`
--

CREATE TABLE `quiz_question` (
  `id` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `question` varchar(255) NOT NULL,
  `option_a` varchar(100) NOT NULL,
  `option_b` varchar(100) NOT NULL,
  `option_c` varchar(100) NOT NULL,
  `option_d` varchar(100) NOT NULL,
  `correct_option` varchar(1) NOT NULL,
  `hint` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_question`
--

INSERT INTO `quiz_question` (`id`, `category`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_option`, `hint`) VALUES
(1, 'General Knowledge', 'What is the capital of France?', 'London', 'Berlin', 'Madrid', 'Paris', 'D', 'Eiffel Tower City'),
(2, 'General Knowledge', 'Who wrote the famous play \"Hamlet\"?', 'Charles Dickens', 'William Shakespeare', 'Jane Austen', 'Mark Twain', 'B', 'Romeo & Juliet Playwright'),
(3, 'General Knowledge', 'What is the largest mammal on Earth?', 'Elephant', 'Giraffe', 'Blue Whale', 'Lion', 'C', 'Largest Marine Mammal'),
(4, 'General Knowledge', 'Which gas is most abundant in Earth\'s atmosphere?', 'Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen', 'C', 'Not what you breathe in'),
(5, 'General Knowledge', 'What is the currency of Japan?', 'Won', 'Ringgit', 'Yen', 'Baht', 'C', ' Symbolized by \'¥'),
(6, 'Science', 'What is the chemical symbol for gold?', 'Go', 'Gl', 'Au', 'Ag', 'C', 'Gold on the periodic table'),
(7, 'Science', 'Which planet is known as the \"Red Planet\"?', 'Venus', 'Earth', 'Mars', 'Jupiter', 'C', '4 letter name'),
(8, 'Science', 'Who is known for the theory of general relativity?', 'Isaac Newton', 'Albert Einstein', 'Stephen Hawking', 'Galileo Galilei', 'B', 'Theory of relativity'),
(9, 'Science', 'What is the process by which green plants make their own food using sunlight?', 'Photosynthesis', 'Respiration', 'Digestion', 'Fermentation', 'A', 'Plants\' energy conversion'),
(10, 'Science', 'What is the smallest planet in our solar system?', 'Earth', 'Mars', 'Jupiter', 'Mercury', 'D', 'Swift planet'),
(11, 'History', 'Who was the first President of the United States?', 'Thomas Jefferson', 'Benjamin Franklin', 'George Washington', 'John Adams', 'C', 'GW initials'),
(12, 'History', 'In which year did Christopher Columbus discover the Americas?', '1492', '1510', '1525', '1550', 'A', 'Columbus\' voyage'),
(13, 'History', 'Who was the first woman to fly solo across the Atlantic Ocean?', 'Amelia Earhart', 'Bessie Coleman', 'Harriet Quimby', 'Jacqueline Cochran', 'A', 'Aviation pioneer'),
(14, 'History', 'Which famous explorer is credited with circumnavigating the Earth?', 'Christopher Columbus', 'Vasco da Gama', 'Ferdinand Magellan', 'James Cook', 'C', 'Circumnavigation pioneer'),
(15, 'History', 'What year marked the end of World War I?', '1917', '1918', '1919', '1920', 'B', 'End of World War I'),
(16, 'Geography', 'Which river is the longest in the world?', 'Nile', 'Amazon', 'Mississippi', 'Yangtze', 'A', 'for letter word'),
(17, 'Geography', 'What is the largest desert in the world?', 'Sahara', 'Gobi', 'Kalahari', 'Arabian', 'A', 'Vast desert'),
(18, 'Geography', 'What is the tallest mountain in the world?', 'Mount Kilimanjaro', 'Mount McKinley', 'Mount Everest', 'Mount Fuji', 'C', 'Earth\'s highest peak'),
(19, 'Geography', 'In which continent can you find the Amazon Rainforest?', 'Africa', 'Asia', 'South America', 'North America', 'C', 'Amazon rainforest'),
(20, 'Geography', 'Which country is both a continent and an island?', 'Australia', 'Greenland', 'Madagascar', 'Borneo', 'A', 'Down Under'),
(21, 'Literature', 'Who wrote the novel \"Pride and Prejudice?\"', 'Jane Austen', 'Charles Dickens', 'Emily Brontë', 'F. Scott Fitzgerald', 'A', 'Regency novelist'),
(22, 'Literature', 'What is the first book in J.K. Rowling\'s \"Harry Potter\" series?', '\"Harry Potter and the Goblet of Fire\"', '\"Harry Potter and the Order of the Phoenix\"', '\"Harry Potter and the Sorcerer\'s Stone\"', '\"Harry Potter and the Deathly Hallows\"', 'C', 'Wizardry\'s beginning'),
(23, 'Literature', 'Who wrote the play \"Romeo and Juliet?\"', 'Charles Dickens', 'William Shakespeare', 'Jane Austen', 'Mark Twain', 'B', 'Bard of Avon'),
(24, 'Literature', 'What is the famous fantasy novel by J.R.R. Tolkien?', '\"The Hobbit\"', '\"The Silmarillion\"', '\"The Lord of the Rings\"', '\"The Chronicles of Narnia\"', 'C', 'Epic fantasy trilogy'),
(25, 'Literature', 'Who is the author of the \"Game of Thrones\" series?', 'J.K. Rowling', 'George R.R. Martin', 'Stephen King', 'J.R.R. Tolkien', 'B', 'Game of Thrones author'),
(26, 'Movies', 'Which movie features a young lion named Simba?', '\"Aladdin\"', '\"The Lion King\"', '\"Mulan\"', '\"Beauty and the Beast\"', 'B', 'Simba\'s Journey'),
(27, 'Movies', 'Who played the character of Jack Dawson in the movie \"Titanic?\"', 'Brad Pitt', 'Johnny Depp', 'Leonardo DiCaprio', 'Tom Hanks', 'C', 'Oscar-winning actor'),
(28, 'Movies', 'What film is known for the quote, \"Here\'s looking at you, kid\"?', '\"Gone with the Wind\"', '\"Casablanca\"', '\"The Godfather\"', '\"Citizen Kane\"', 'B', 'Bogart and Bergman'),
(29, 'Movies', 'Who directed the \"Star Wars\" film series?', 'J.J. Abrams', 'Steven Spielberg', 'George Lucas', 'James Cameron', 'C', 'Star Wars creator'),
(30, 'Movies', 'What is the highest-grossing animated film of all time?', '\"Shrek\"', '\"Frozen II\"', '\"The Lion King\"', '\"Toy Story 4\"', 'C', 'Simba\'s journey'),
(31, 'Music', 'Who is known as the \"King of Pop?\"', 'Prince', 'Elvis Presley', 'Michael Jackson', 'Justin Timberlake', 'C', 'owner best-selling album of all time'),
(32, 'Music', 'Which British rock band is famous for the album \"The Dark Side of the Moon?\"', 'The Rolling Stones', 'The Beatles', 'Pink Floyd', 'Led Zeppelin', 'C', 'Progressive rock legends'),
(33, 'Music', 'Who released the album \"Lemonade\" in 2016?', 'Beyoncé', 'Rihanna', 'Lady Gaga', 'Taylor Swift', 'A', 'Queen of pop'),
(34, 'Music', 'What is the best-selling album of all time?', '\"Led Zeppelin IV\"', '\"Thriller\" by Michael Jackson', '\"The Dark Side of the Moon\" by Pink Floyd', '\"Abbey Road\" by The Beatles', 'B', 'king of pop'),
(35, 'Music', 'Who is known for the hit song \"Shape of You?\"', 'Bruno Mars', 'Ed Sheeran', 'Sam Smith', 'Adele', 'B', 'white Singer-songwriter'),
(36, 'Sports', 'In which sport does the term \"slam dunk\" originate?', 'Soccer', 'Basketball', 'Tennis', 'Golf', 'B', 'Hoops and dribbles'),
(37, 'Sports', 'Which country won the FIFA World Cup in 2018?', 'Germany', 'Brazil', 'France', 'Argentina', 'C', 'Eiffel Tower home'),
(38, 'Sports', 'Who holds the record for the most Olympic gold medals in history?', 'Usain Bolt', 'Michael Phelps', 'Simone Biles', 'Carl Lewis', 'B', 'Olympic swimming legend'),
(39, 'Sports', 'How many players are there on a standard soccer team?', '9', '10', '11', '12', 'C', 'double one'),
(40, 'Sports', 'Which country is famous for its strong tradition in sumo wrestling?', 'Japan', 'Russia', 'United States', 'China', 'A', 'Land of the rising sun'),
(41, 'Food and Cuisine', 'What is the main ingredient in traditional Japanese miso soup?', 'Tofu', 'Seaweed', 'Miso paste', 'Rice', 'C', 'Savory soybean seasoning'),
(42, 'Food and Cuisine', 'Which cuisine is known for dishes like tacos, burritos, and enchiladas?', 'Italian', 'Chinese', 'Mexican', 'Indian', 'C', 'Vibrant cuisine'),
(43, 'Food and Cuisine', 'What is the national dish of Spain, consisting of saffron-flavored rice and various ingredients like seafood and vegetables?', 'Sushi', 'Paella', 'Kimchi', 'Curry', 'B', 'Spanish rice dish'),
(44, 'Food and Cuisine', 'What vegetable is the main ingredient in hummus?', 'Chickpeas', 'Eggplant', 'Tomato', 'Spinach', 'A', 'Protein-packed legumes'),
(45, 'Food and Cuisine', 'What type of pasta is shaped like small rice grains and is often used in soups?', 'Fettuccine', 'Orzo', 'Penne', 'Rigatoni', 'B', 'Rice-shaped pasta'),
(46, 'Technology', 'What company is known for its iPhone and MacBook products?', 'Google', 'Samsung', 'Apple', 'Microsoft', 'C', 'Tech and Fruit'),
(47, 'Technology', 'Who co-founded Microsoft alongside Bill Gates?', 'Steve Jobs', 'Mark Zuckerberg', 'Paul Allen', 'Larry Page', 'C', 'Microsoft co-founder'),
(48, 'Technology', 'What does the abbreviation \"URL\" stand for?', 'Universal Record Locator', 'Universal Resource Locator', 'Uniform Resource Link', 'Universal Reference Link', 'B', 'Web address'),
(49, 'Technology', 'Which social media platform is known for its character limit on posts?', 'Facebook', 'Instagram', 'Twitter', 'LinkedIn', 'C', 'newly X'),
(50, 'Technology', 'What technology is used to store data in a distributed ledger, often associated with cryptocurrencies?', 'Blockchain', 'Cloud Computing', 'Artificial Intelligence', 'Virtual Reality', 'A', 'Decentralized ledger'),
(51, 'Art and Culture', 'Who painted the Mona Lisa?', 'Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Michelangelo', 'C', 'Renaissance genius'),
(52, 'Art and Culture', 'Which dance style originated in the Caribbean and is known for its vibrant and rhythmic movements?', 'Ballet', 'Salsa', 'Hip-Hop', 'Ballroom', 'B', 'Dance and sauce'),
(53, 'Art and Culture', 'Who is known for creating the \"Campbell\"s Soup Cans\" artwork?', 'Jackson Pollock', 'Andy Warhol', 'Georgia O\"Keeffe', 'Frida Kahlo', 'B', 'Pop art pioneer'),
(54, 'Art and Culture', 'What is the traditional Japanese tea ceremony called?', 'Sushi Ceremony', 'Ramen Ceremony', 'Ikebana Ceremony', 'Chanoyu', 'D', 'Japanese tea ceremony'),
(55, 'Art and Culture', 'In which country did the art movement known as the Renaissance originate?', 'Spain', 'France', 'Italy', 'Germany', 'C', 'Boot-shaped country'),
(56, 'Nature and Wildlife', 'What is the largest species of shark?', 'Hammerhead Shark', 'Great White Shark', 'Whale Shark', 'Tiger Shark', 'C', 'Gentle giant of the sea'),
(57, 'Nature and Wildlife', 'Which animal is known as the \"king of the jungle?\"', 'Elephant', 'Leopard', 'Lion', 'Gorilla', 'C', 'king of the jungle'),
(58, 'Nature and Wildlife', 'What is the national bird of the United States?', 'Bald Eagle', 'Turkey', 'Pigeon', 'Blue Jay', 'A', 'bald'),
(59, 'Nature and Wildlife', 'What is the largest species of penguin?', 'Emperor Penguin', 'King Penguin', 'Adélie Penguin', 'Little Blue Penguin', 'A', 'Tallest penguin species'),
(60, 'Nature and Wildlife', 'Which species of bear is native to China and known for being a symbol of conservation efforts?', 'Polar Bear', 'Grizzly Bear', 'Giant Panda', 'Brown Bear', 'C', 'Black and white bear'),
(61, 'Pop Culture', 'What animated film features a character named Elsa who has magical ice powers?', 'Tangled', 'Moana', 'Frozen', 'Cinderella', 'C', NULL),
(62, 'Pop Culture', 'Which TV series is set in the fictional Seven Kingdoms of Westeros?', 'The Walking Dead', 'Breaking Bad', 'Game of Thrones', 'Stranger Things', 'C', NULL),
(63, 'Pop Culture', 'Who played the character of Jack Dawson in the movie \"Titanic\"?', 'Brad Pitt', 'Johnny Depp', 'Leonardo DiCaprio', 'Tom Hanks', 'C', NULL),
(64, 'Pop Culture', 'What is the name of the wizarding school in the \"Harry Potter\" series?', 'Spellbound Academy', 'Witchcraft and Wizardry School', 'Hogwarts School of Witchcraft and Wizardry', 'Magic Academy', 'C', NULL),
(65, 'Pop Culture', 'Who is known as the \"Queen of Pop\"?', 'Lady Gaga', 'Britney Spears', 'Madonna', 'Beyoncé', 'C', NULL),
(66, 'Politics', 'Who is the current President of the United States (as of 2023)?', 'Barack Obama', 'Joe Biden', 'Donald Trump', 'George Bush', 'B', NULL),
(67, 'Politics', 'What is the capital of Russia?', 'St. Petersburg', 'Moscow', 'Kiev', 'Warsaw', 'B', NULL),
(68, 'Politics', 'Who was the first female Prime Minister of the United Kingdom?', 'Angela Merkel', 'Theresa May', 'Margaret Thatcher', 'Queen Elizabeth II', 'C', NULL),
(69, 'Politics', 'Where is the United Nations headquarters located?', 'New York City', 'Geneva', 'London', 'Paris', 'A', NULL),
(70, 'Politics', 'Which country is known as the Land of the Rising Sun?', 'China', 'South Korea', 'Japan', 'Vietnam', 'C', NULL),
(71, 'Celebrities', 'Who is known for her role as Katniss Everdeen in \"The Hunger Games\" film series?', 'Emma Watson', 'Jennifer Lawrence', 'Scarlett Johansson', 'Anne Hathaway', 'B', NULL),
(72, 'Celebrities', 'Which actor is famous for his role as Iron Man in the Marvel Cinematic Universe?', 'Chris Evans', 'Chris Hemsworth', 'Robert Downey Jr.', 'Mark Ruffalo', 'C', NULL),
(73, 'Celebrities', 'Who is known for her role as Hermione Granger in the \"Harry Potter\" film series?', 'Emma Stone', 'Emma Roberts', 'Emma Watson', 'Emma Thompson', 'C', NULL),
(74, 'Celebrities', 'Who is a famous American talk show host known for \"The Oprah Winfrey Show\"?', 'Ellen DeGeneres', 'Wendy Williams', 'Oprah Winfrey', 'Tyra Banks', 'C', NULL),
(75, 'Celebrities', 'Which actor portrayed Jack Dawson in the movie \"Titanic\"?', 'Brad Pitt', 'Johnny Depp', 'Leonardo DiCaprio', 'Tom Hanks', 'C', NULL),
(76, 'Mythology', 'Who is the king of the Greek gods in ancient mythology?', 'Zeus', 'Poseidon', 'Hades', 'Apollo', 'A', NULL),
(77, 'Mythology', 'What creature is part lion, part goat, and part snake, according to Greek mythology?', 'Minotaur', 'Centaur', 'Chimera', 'Harpy', 'C', NULL),
(78, 'Mythology', 'Who is the Norse god of thunder and lightning?', 'Loki', 'Odin', 'Thor', 'Freyja', 'C', NULL),
(79, 'Mythology', 'Which Egyptian goddess is known as the goddess of love and beauty?', 'Isis', 'Hathor', 'Bastet', 'Nut', 'B', NULL),
(80, 'Mythology', 'Who is the legendary figure known for his quest to find the Holy Grail in Arthurian legend?', 'Lancelot', 'Merlin', 'King Arthur', 'Sir Galahad', 'D', NULL),
(81, 'Religion', 'In which religion is the Quran considered the holy book?', 'Christianity', 'Hinduism', 'Islam', 'Buddhism', 'C', NULL),
(82, 'Religion', 'Who is the founder of Buddhism?', 'Siddhartha Gautama', 'Confucius', 'Jesus Christ', 'Muhammad', 'A', NULL),
(83, 'Religion', 'Which Hindu god is known as the \"Destroyer\"?', 'Brahma', 'Vishnu', 'Shiva', 'Krishna', 'C', NULL),
(84, 'Religion', 'What is the holy text of Judaism?', 'Torah', 'Bible', 'Quran', 'Guru Granth Sahib', 'A', NULL),
(85, 'Religion', 'Who is considered the central figure of Christianity?', 'Moses', 'Abraham', 'Jesus Christ', 'Paul the Apostle', 'C', NULL),
(86, 'Language and Linguistics', 'How many letters are in the English alphabet?', '20', '24', '26', '28', 'C', 'Letters in the English alphabet'),
(87, 'Language and Linguistics', 'What is the study of the origin and history of words?', 'Syntax', 'Grammar', 'Etymology', 'Semiotics', 'C', 'word origins'),
(88, 'Language and Linguistics', 'What is the term for a word or phrase that is spelled the same forward and backward?', 'Acronym', 'Palindrome', 'Homonym', 'Oxymoron', 'B', 'Same forwards and backwards'),
(89, 'Language and Linguistics', 'Which language is the most widely spoken in the world?', 'English', 'Spanish', 'Mandarin Chinese', 'Arabic', 'C', 'Most spoken language'),
(90, 'Language and Linguistics', 'What is the study of the meaning of words and phrases?', 'Syntax', 'Phonetics', 'Semantics', 'Pragmatics', 'C', 'Meaning in language'),
(101, 'Fun', 'What is the largest planet in our solar system?', 'Earth', 'Mars', 'Jupiter', 'Saturn', 'C', 'Giant gas planet'),
(102, 'Fun', 'What is the chemical symbol for water?', 'H2O', 'CO2', 'O2', 'NaCl', 'A', 'contains hydrogen'),
(103, 'Fun', 'What is the primary color of the sun?', 'Red', 'Yellow', 'Blue', 'Green', 'B', 'Color of sunshine'),
(104, 'Fun', 'What is the name of the fictional wizarding school in the \"Harry Potter\" series?', 'Hogwarts', 'Witchcraft and Wizardry School', 'Merlin\'s Academy', 'Sorcerer\'s Institute', 'A', 'School of witchcraft and wizardry'),
(105, 'Fun', 'How many continents are there on Earth?', '5', '6', '7', '8', 'B', 'Half a dozen'),
(106, 'Puzzle', 'What puzzle consists of nine squares, each containing nine smaller squares?', 'Crossword', 'Jigsaw Puzzle', 'Sudoku', 'Rubik\'s Cube', 'B', 'Interlocking pieces'),
(107, 'Puzzle', 'What board game involves moving pieces diagonally and jumping over opponents\' pieces?', 'Chess', 'Checkers', 'Scrabble', 'Monopoly', 'B', 'Board game with red and black pieces'),
(108, 'Puzzle', 'What puzzle involves connecting a series of numbered dots to form a picture?', 'Crossword', 'Jigsaw Puzzle', 'Connect the Dots', 'Sudoku', 'C', 'Kids\' drawing game'),
(109, 'Puzzle', 'What puzzle challenges you to arrange shapes to fill a defined area without overlapping?', 'Jigsaw Puzzle', 'Tangram', 'Rubik\'s Cube', 'Maze', 'B', 'Chinese Puzzle game'),
(110, 'Puzzle', 'What puzzle involves filling a grid with numbers, making sure that no row or column repeats the same number?', 'Crossword', 'Jigsaw Puzzle', 'Connect the Dots', 'Sudoku', 'D', 'Number Puzzle'),
(111, 'Animals', 'What is the largest species of big cat in the world?', 'Lion', 'Cheetah', 'Tiger', 'Leopard', 'C', 'Striped big cat'),
(112, 'Animals', 'What bird is known for its impressive courtship dance and vibrant plumage?', 'Pigeon', 'Peacock', 'Penguin', 'Parrot', 'B', 'Colorful feathers'),
(113, 'Animals', 'Which sea creature is famous for its eight long tentacles and beak-like mouth?', 'Octopus', 'Squid', 'Jellyfish', 'Starfish', 'A', 'eight arms'),
(114, 'Animals', 'What is the world\'s smallest mammal?', 'Bumblebee Bat', 'Shrew', 'Hamster', 'Squirrel', 'A', 'World\'s smallest bat'),
(115, 'Animals', 'What is the national bird of the United States?', 'Bald Eagle', 'Turkey', 'Pigeon', 'Blue Jay', 'A', 'no hair'),
(116, 'Mathematics', 'What is the value of π (pi) to two decimal places?', '3.14', '2.71', '3.16', '3.00', 'A', 'Pi\'s first digits'),
(117, 'Mathematics', 'What is the square root of 144?', '12', '14', '10', '16', 'A', 'a dozen'),
(118, 'Mathematics', 'What is the mathematical constant denoted as \"e\"?', 'Euler\'s Number', 'Exponent', 'Even Number', 'Epsilon', 'A', 'Approximately 2.718'),
(119, 'Mathematics', 'In geometry, how many degrees are in a right angle?', '60', '90', '120', '180', 'B', '1/4 of a circumference'),
(120, 'Mathematics', 'What is the term for a three-sided polygon?', 'Octagon', 'Square', 'Triangle', 'Pentagon', 'C', 'three angles');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `full_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(60) NOT NULL,
  `reset_password_token` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `full_name`, `email`, `password`, `reset_password_token`) VALUES
(1, 'Cozy', 'First User', 'cozyamy@gmail.com', '$2b$12$QcL7Qo5bRAlwnQvqKSROH.kK4QDfvJ5A5Ljgm3ZTkGfA8eSLFmVnG', NULL),
(2, 'firstuser', 'Trial Test', 'trialuser@gmail.com', '$2b$12$kt.GeJTU9CZ5PPeu4RvyNuXp7X8RRsrjR24z6SlCG4O5sxBRJunJK', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_scores`
--

CREATE TABLE `user_scores` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_scores`
--

INSERT INTO `user_scores` (`id`, `user_id`, `score`, `category`, `timestamp`) VALUES
(1, 1, 3, 'Puzzle', '2023-10-21 15:22:42'),
(2, 2, 1, 'Puzzle', '2023-10-21 15:29:35');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_question`
--
ALTER TABLE `quiz_question`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username_unique` (`username`),
  ADD UNIQUE KEY `email_unique` (`email`),
  ADD UNIQUE KEY `reset_password_token_unique` (`reset_password_token`);

--
-- Indexes for table `user_scores`
--
ALTER TABLE `user_scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `quiz_question`
--
ALTER TABLE `quiz_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_scores`
--
ALTER TABLE `user_scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_scores`
--
ALTER TABLE `user_scores`
  ADD CONSTRAINT `user_scores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
