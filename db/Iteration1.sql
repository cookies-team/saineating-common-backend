-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 03, 2022 at 12:10 AM
-- Server version: 8.0.28-0ubuntu0.20.04.3
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Iteration1`
--

-- --------------------------------------------------------

--
-- Table structure for table `CookingStep`
--

CREATE TABLE `CookingStep` (
  `CookingId` int NOT NULL,
  `Details` varchar(999) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CookingStep`
--

INSERT INTO `CookingStep` (`CookingId`, `Details`) VALUES
(1, 'Step 1\r\nPour stock into a large saucepan, add shredded cabbage and simmer together for 5 minutes.\r\nStep 2\r\nGrind lemongrass, ginger and chilli into a paste, using a mortar and pestle.\r\nStep 3\r\nAdd bok choy, coriander, and sauces into stock along with paste mixture.\r\nStep 4\r\nPlace cooked hokkien noodles into six serving bowls.\r\nStep 5\r\nSlice or shred cooked chicken into 1cm strips.\r\nStep 6\r\nPlace chicken onto noodles and cover with stock and sauce mixture.\r\nStep7\r\nAdd bean sprouts and sliced spring onions to taste.'),
(2, 'Step 1\r\nRinse and drain the chickpeas, dry and put in a food processor\r\nStep 2\r\nFinely grate the lemon zest, then add the cumin, ground coriander, fresh coriander, spring onion and blend to combine until a crumbly dough (not a paste).\r\nStep 3\r\nAdd flour 1 tablespoon at a time and pulse to combine until you can mould the dough into a ball without it sticking to your hands.\r\nStep 4\r\nScoop out rounded tablespoons of mixture and shape into 16 patties\r\nStep 5\r\nPut 1 tablespoon of oil into a non-stick frying pan over medium health and cook half of the falafels, turning once, until golden, approximately 5 minutes per side. Repeat with other half of the falafels using the remaining 1 tablespoon of oil.\r\nStep 6\r\nServe falafels with mixed salad and a wedge of lemon. You may also like to add a dip such as low-fat tzatziki or hommous.'),
(3, 'Step 1\r\nIn a blender, process all ingredients together until thick and creamy\r\nStep 2\r\nPlace in a freezer safe container and freeze for at least four hours.\r\nStep 3\r\nOne scoop per person to serve.');

-- --------------------------------------------------------

--
-- Table structure for table `Ingredient`
--

CREATE TABLE `Ingredient` (
  `IngredientId` int NOT NULL,
  `IngredientName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Ingredient`
--

INSERT INTO `Ingredient` (`IngredientId`, `IngredientName`) VALUES
(1, '1L of chicken stock, no added salt'),
(2, '1 cup finely shredded Chinese cabbage'),
(3, '1 lemongrass stalk'),
(4, '1 tsp ginger'),
(5, '1 small red chilli'),
(6, '1 bunch bok choy, shredded'),
(7, '2 tbs coriander, chopped'),
(8, '1 tsp soy sauce, salt reduced'),
(9, '1 tsp fish sauce'),
(10, '125g hokkien egg noodles, cooked'),
(11, '1 cup skinless cooked chicken'),
(12, '1 cup mung bean sprouts'),
(13, '1 spring onion, sliced'),
(14, '2 x 400g tins chickpeas'),
(15, 'Zest of 1 lemon'),
(16, '3 cloves garlic, minced'),
(17, '3 spring onions, chopped'),
(18, '2 teaspoons cumin'),
(19, '1 teaspoon coriander seeds ground'),
(20, '1 tablespoon sesame seeds'),
(21, '1 bunch fresh coriander'),
(22, '3 tablespoons plain flour'),
(23, '2 tablespoons olive oil'),
(24, '1 cup raw cashews'),
(25, '¾ cup water'),
(26, '¼ cup peanut butter, no added salt or sugar'),
(27, '¼ cup honey (optional)'),
(28, '2 bananas'),
(29, '½ tsp vanilla essence');

-- --------------------------------------------------------

--
-- Table structure for table `Recipe`
--

CREATE TABLE `Recipe` (
  `RecipeId` int NOT NULL,
  `RecipeName` varchar(50) NOT NULL,
  `CookingId` int NOT NULL,
  `TypeId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Recipe`
--

INSERT INTO `Recipe` (`RecipeId`, `RecipeName`, `CookingId`, `TypeId`) VALUES
(1, 'Asian Chicken Noodle Soup', 1, 1),
(2, 'Homemade Falafel', 2, 2),
(3, 'Banana, Cashew and Peanut Butter Ice-cream', 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `RecipeType`
--

CREATE TABLE `RecipeType` (
  `TypeID` int NOT NULL,
  `TypeName` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `RecipeType`
--

INSERT INTO `RecipeType` (`TypeID`, `TypeName`) VALUES
(1, 'Soup'),
(2, 'Lunch'),
(3, 'Dessert');

-- --------------------------------------------------------

--
-- Table structure for table `Recipe_Ingredient`
--

CREATE TABLE `Recipe_Ingredient` (
  `RecipeId` int NOT NULL,
  `IngredientId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Recipe_Ingredient`
--

INSERT INTO `Recipe_Ingredient` (`RecipeId`, `IngredientId`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(2, 19),
(2, 20),
(2, 21),
(2, 22),
(2, 23),
(3, 24),
(3, 25),
(3, 26),
(3, 27),
(3, 28),
(3, 29);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
