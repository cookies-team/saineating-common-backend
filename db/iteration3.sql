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
-- Database: `iteration3`
--

-- --------------------------------------------------------

--
-- Table structure for table `CookingStep`
--

CREATE TABLE `CookingStep` (
  `CookingId` int NOT NULL,
  `Details` varchar(9999) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CookingTime` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CookingStep`
--

INSERT INTO `CookingStep` (`CookingId`, `Details`, `CookingTime`) VALUES
(1, 'Step 1<br>\r\nPour stock into a large saucepan, add shredded cabbage and simmer together for 5 minutes.<br>\r\nStep 2<br>\r\nGrind lemongrass, ginger and chilli into a paste, using a mortar and pestle.<br>\r\nStep 3<br>\r\nAdd bok choy, coriander, and sauces into stock along with paste mixture.<br>\r\nStep 4<br>\r\nPlace cooked hokkien noodles into six serving bowls.<br>\r\nStep 5<br>\r\nSlice or shred cooked chicken into 1cm strips.<br>\r\nStep 6<br>\r\nPlace chicken onto noodles and cover with stock and sauce mixture.<br>\r\nStep7<br>\r\nAdd bean sprouts and sliced spring onions to taste.', '15min'),
(2, 'Step 1<br>\r\nRinse and drain the chickpeas, dry and put in a food processor.<br>\r\nStep 2<br>\r\nFinely grate the lemon zest, then add the cumin, ground coriander,<br> fresh coriander, spring onion and blend to combine until a crumbly dough (not a paste).<br>\r\nStep 3<br>\r\nAdd flour 1 tablespoon at a time and pulse to combine until you can mould the <br>dough into a ball without it sticking to your hands.<br>\r\nStep 4<br>\r\nScoop out rounded tablespoons of mixture and shape into 16 patties.<br>\r\nStep 5<br>\r\nPut 1 tablespoon of oil into a non-stick frying pan over medium health and cook <br>half of the falafels, turning once, until golden, approximately 5 minutes per side. <br>Repeat with other half of the falafels using the remaining 1 tablespoon of oil.<br>\r\nStep 6<br>\r\nServe falafels with mixed salad and a wedge of lemon. <br>You may also like to add a dip such as low-fat tzatziki or hommous.', '20min'),
(3, 'Step 1<br>\r\nIn a blender, process all ingredients together until thick and creamy<br>\r\nStep 2<br>\r\nPlace in a freezer safe container and freeze for at least four hours.<br>\r\nStep 3<br>\r\nOne scoop per person to serve.', '4hrs'),
(4, 'Step 1<br>\r\nPreheat oven to 200C (180C fan-forced). Whisk half the oil, miso paste, honey, soy and <br>coriander seeds in a small bowl Rub the marinade over the beef and season with pepper.<br>\r\nStep 2<br>\r\nPlace the beef on a rack in a roasting dish. Add 3/4 cup water to the roasting dish (add more <br>throughout the cooking process if needed). Roast for 40 minutes for rare, 50 minutes for <br>medium and 60 minutes for well done. Cover the roast with foil if overbrowning. For <br>ease and accuracy use a meat thermometer.<br>\r\nStep 3<br>\r\nRemove the beef, reserving pan juices, and cover loosely with foil and allow it to rest for 20 <br>minutes before carving.<br>\r\nStep 4<br>\r\nMeanwhile, place the potatoes in another roasting dish, and crush with a potato masher or <br>back of a fork. Drizzle with remaining olive oil and cumin. Season and toss to coat <br>potatoes. Place in the oven with beef for last 30 minutes, turning potatoes occasionally, <br>until golden.<br>\r\nStep 5<br>\r\nTo make the gravy, place the reserved pan juices in a frying pan over medium-high heat. <br>Add the stock, mirin and whisk in the miso paste. Boil until the mixture is reduced to a <br>thin sauce like consistency. Pour in the juices from the rested beef roast. Whisk in the <br>butter.<br>\r\nStep 6<br>\r\nServe beef roast with the potatoes, miso gravy, sugar snaps and corn.', '1hr15min'),
(5, 'Step 1<br>\r\nPlace bag of potatoes into microwave, as per packet instructions and microwave for 6 to 8 minutes,<br> or until tender. Set aside covered with foil to keep warm. <br>Drizzle with a little oil and season with salt and pepper, to serve.<br>\r\nStep 2<br>\r\nMeanwhile, brush steaks with 1 tablespoon oil and season with salt and pepper.<br> Heat a large non-stick frying pan over medium heat. <br>Add steaks and cook for <br>3 to 4 minutes each side or until cooked to your liking. Transfer to a plate and cover with foil.<br>\r\nStep 3<br>\r\nIncrease temperature to medium-high. Add onion and mushrooms and cook for 4 to 5 <br>minutes or until golden. Add Worcestershire sauce, sour cream and 1/3 cup water. <br>Bring to the boil and remove from the heat. Season with salt and pepper.<br> Serve steaks topped with mushroom sauce, baby potatoes sprinkled with parsley, and baby rocket on the side.', '15min'),
(6, 'Step 1<br>\r\nPut the kettle on. While the kettle boils, empty the 3 sachets of miso soup into a large saucepan.<br> Add the stock, ginger and 500ml (2 cups) tap water. Cover. Bring to boil over high heat.<br> Add the edamame and cook for 2 minutes or until just tender.<br>\r\nStep 2<br>\r\nWhile the stock mixture comes to the boil, fill a large stockpot one-quarter of the way with tap water. <br>Cover. Pour the water from the kettle into the stockpot. Cover and bring back to the boil.<br> Add the noodles and cook for 2 minutes or until just tender. Drain.<br>\r\nStep 3<br>\r\nThinly slice the chicken breast. Divide the noodles among serving bowls. <br>Ladle the soup mixture over the noodles.<br> Top with the sliced chicken and sprinkle with sesame seeds and chilli.', '10min'),
(7, 'Step 1<br>\r\nPlace the noodles in a heatproof bowl. Pour over boiling water from a jug. <br>Set aside, stirring occasionally for 9 minutes to soak and soften.<br>\r\nStep 2<br>\r\nMeanwhile, heat the oil in a wok over high heat. Chop the tofu. Add to the wok. <br>Cook, stirring often, for 5 minutes or until golden.<br>\r\nStep 3<br>\r\nWhile the tofu is cooking, combine the tamarind, sugar, lime juice and soy sauce in a small jug.<br> Stir to dissolve the sugar. Set aside.<br>\r\nStep 4<br>\r\nPush the tofu to one side of the wok. Add the garlic to the empty space. Cook for 30 seconds.<br> Add the vegetable stir-fry. Toss to combine. Push the mixture to one side and add the eggs. <br>Stir fry for 1 minute or until combined.<br>\r\nStep 5<br>\r\nDrain the noodles and add to the wok with the sauce. Cook for 1 minute to coat.<br>\r\nStep 6<br>\r\nServe with peanuts, bean sprouts, coriander and lime wedges.\r\n', '10min'),
(8, 'Step 1<br>\r\nPreheat jaffle maker.<br>\r\nStep 2<br>\r\nMeanwhile, spread butter over 1 side of each slice of bread. Turn bread over. Spread bread with tomato paste. <br>\r\nStep 3<br>\r\nPlace 1 slice of bread, buttered-side down, in each hole of jaffle maker. <br>Top with salami, red pepper, olives and cheese. <br>Sandwich with remaining bread slices, buttered-side up. Sprinkle with oregano. Close lid.<br> Cook for 4 minutes or until golden and cheese is melted.', '15min'),
(9, 'Step 1<br>\r\nDust beef in flour, shaking off excess. Heat oil in a large heavy-based saucepan over high heat. <br>Cook beef for 3 minutes each side or until browned. Transfer to a bowl.<br>\r\nStep 2<br>\r\nReduce heat to medium. Add onion to pan. Cook, stirring, for 3 minutes or until starting to brown.<br> Add ginger, garlic, lemongrass, cinnamon and ground coriander.<br> Cook, stirring, for 1 minute or until fragrant. Add stock, kecap manis, tamarind and 1 cup water. Bring to a simmer.<br>\r\nStep 3<br>\r\nReturn beef to pan. Reduce heat to medium-low. Cover. Cook for 1 hour 30 minutes, turning beef halfway through. <br>Remove lid. Cook for a further 30 minutes or until beef is tender.\r\nStep 4<br>\r\nUsing tongs, transfer beef to a bowl. Cover to keep warm. Increase heat to medium. <br>Cook sauce for a further 5 minutes or until thickened. Return beef to pan, turning to coat in sauce.\r\nStep 5<br>\r\nMeanwhile, place sesame seeds and pepitas in a small frying pan over medium-high heat.<br> Cook, stirring for 3 minutes or until toasted. Add brown sugar. <br>Cook, stirring for 1 to 2 minutes or until sugar is caramelised. <br>Transfer to a plate lined with baking paper to cool completely. Break up into small pieces.<br>\r\nStep 6\r\nHeat rice and quinoa mix following to packet directions. <br>Combine salad mix and noodles in a bowl. <br>Divide beef, rice mix, salad mixture, cucumber, carrot, pepita mixture, <br>fresh coriander and chilli among serving bowls.<br> Squeeze over lime to serve.', '2hr25min'),
(10, 'Step 1<br>\r\nCoarsely mash the beans in a bowl. Stir in chilli and juice. Season.<br>\r\nStep 2<br>\r\nSpread bean mixture over wrap. Top with the spinach, tomato, avocado and basil. Serve with lemon wedge, if using.', '10min'),
(11, 'Step 1<br>\r\nLightly spray a small non-stick frying pan with olive oil.<br> Crack egg into pan and cook for 2 minutes or until cooked to your liking.<br>\r\nStep 2<br>\r\nSpread relish over base of sandwich thin. <br>Top with spinach, tomato, avocado and egg. <br>Season and top with sandwich thin lid.', '5min'),
(12, 'Step 1<br>\r\nPreheat oven to 180°C. Grease 8 holes of a 1/3-cup (80ml) non-stick muffin pan.<br>\r\nStep 2<br>\r\nHeat a non-stick frying pan over high heat. Add bacon and mushroom. <br>Cook, stirring, for 2 mins or until light golden. Add the broccoli and cook, stirring, for 1 min or until just tender.<br>\r\nStep 3<br>\r\nDivide bacon mixture and spinach evenly among prepared holes. <br>Whisk eggs, milk and cheddar in a jug. Season. Pour egg mixture over bacon mixture.<br>\r\nStep 4<br>\r\nBake for 15-20 mins or until just set. Set aside to cool slightly before serving. ', '30min');

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
(1, 'chicken stock, no added salt'),
(2, 'Chinese cabbage, shredded'),
(3, 'lemongrass stalk'),
(4, 'ginger'),
(5, 'small red chilli'),
(6, 'bok choy, shredded'),
(7, 'coriander, chopped'),
(8, 'soy sauce, salt reduced'),
(9, 'fish sauce'),
(10, 'hokkien egg noodles, cooked'),
(11, 'skinless chicken, cooked'),
(12, 'mung bean sprouts'),
(13, 'spring onion, sliced'),
(14, 'tins chickpeas'),
(15, 'zest of lemon'),
(16, 'cloves garlic, minced'),
(17, 'spring onions, chopped'),
(18, 'cumin'),
(19, 'coriander seeds ground'),
(20, 'sesame seeds'),
(21, 'coriander'),
(22, 'plain flour'),
(23, 'olive oil'),
(24, 'raw cashews'),
(25, 'water'),
(26, 'peanut butter, no added salt or sugar'),
(27, 'honey'),
(28, 'bananas'),
(29, 'vanilla essence'),
(30, 'beef rump roast, fat trimmed'),
(31, 'miso paste'),
(32, 'chat potatoes par-boiled'),
(33, 'rich beef stock'),
(34, 'mirin'),
(35, 'butter'),
(36, 'beef rump steak'),
(37, 'baby potatoes'),
(38, 'brown onion'),
(39, 'button mushrooms'),
(40, 'worcestershire sauce'),
(41, 'sour cream'),
(42, 'packet S&B Japanese instant Aka Miso Soup'),
(43, 'Massel vegetable liquid stock'),
(44, 'piece ginger, peeled, cut into matchsticks'),
(45, 'podded frozen edamame'),
(46, 'ramen noodle cake'),
(47, 'barbecued chicken breast'),
(48, 'dried pad Thai noodles'),
(49, 'peanut oil'),
(50, 'pkt firm tofu'),
(51, 'tamarind puree'),
(52, 'brown sugar'),
(53, 'fresh lime juice plus wedges'),
(54, 'garlic cloves'),
(55, 'pkt simply stir-fry vegetable superfoods'),
(56, 'egg'),
(57, 'white bread'),
(58, 'roasted red pepper strips'),
(59, 'small pitted kalamata olives'),
(60, 'grated mozzarella'),
(61, 'beef osso buco'),
(62, 'piece fresh ginger, finely grated'),
(63, 'lemongrass paste'),
(64, 'cinnamon stick'),
(65, 'beef stock'),
(66, 'kecap manis'),
(67, 'tamarind paste'),
(68, 'pepitas'),
(69, 'Coles microwave brown rice and quinoa mix'),
(70, 'bag Coles 4-leaf salad mix'),
(71, 'fried noodles'),
(72, 'can black beans (rinsed drained)'),
(73, 'lemon juice'),
(74, 'wholegrain wrap'),
(75, 'baby spinach'),
(76, 'roma tomato'),
(77, 'avocado'),
(78, 'fresh basil leaf'),
(79, 'tomato relish'),
(80, 'wholemeal sandwich thin'),
(81, 'bacon rasher'),
(82, 'cup mushrooms'),
(83, 'broccoli, chopped'),
(84, 'milk'),
(85, 'grated light tasty cheddar');

-- --------------------------------------------------------

--
-- Table structure for table `Recipe`
--

CREATE TABLE `Recipe` (
  `RecipeId` int NOT NULL,
  `RecipeName` varchar(50) NOT NULL,
  `CookingId` int NOT NULL,
  `MinAge` int NOT NULL,
  `CalorieLevel` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Recipe`
--

INSERT INTO `Recipe` (`RecipeId`, `RecipeName`, `CookingId`, `MinAge`, `CalorieLevel`) VALUES
(1, 'Asian chicken noodle soup', 1, 5, 0),
(2, 'Homemade falafel', 2, 10, 0),
(3, 'Banana, cashew and peanut Butter Ice-cream', 3, 10, 0),
(4, 'Miso rump roast with gravy and crushed potatoes', 4, 5, 40),
(5, 'Rump steak with mushroom sauce and baby potatoes', 5, 10, 20),
(6, 'Japanese chicken ramen', 6, 10, 40),
(7, 'Vegetarian pad Thai', 7, 10, 100),
(8, 'Pizza Jaffles', 8, 8, 10),
(9, 'Sticky soy beef winter bliss bowl', 9, 5, 50),
(10, 'Ultimate vegan breakfast wrap', 10, 10, 10),
(11, 'Healthy breakfast burger', 11, 5, 10),
(12, 'Bacon and egg breakfast mufins', 12, 10, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Recipe_Ingredient`
--

CREATE TABLE `Recipe_Ingredient` (
  `RecipeId` int NOT NULL,
  `IngredientId` int NOT NULL,
  `Amount` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Recipe_Ingredient`
--

INSERT INTO `Recipe_Ingredient` (`RecipeId`, `IngredientId`, `Amount`) VALUES
(1, 1, '1L'),
(1, 2, '1cup'),
(1, 3, '1'),
(1, 4, '1 tbsp'),
(1, 5, '1'),
(1, 6, '1 bunch'),
(1, 7, '1 tbsp'),
(1, 8, '1 tbsp'),
(1, 9, '1 tbsp'),
(1, 10, '125g'),
(1, 11, '1cup'),
(1, 12, '1cup'),
(1, 13, '1'),
(2, 14, '800g'),
(2, 15, '1'),
(2, 16, '3'),
(2, 17, '3'),
(2, 18, '2 tbsp'),
(2, 19, '1 tbsp'),
(2, 20, '1 tbsp'),
(2, 21, '1 bunch'),
(2, 22, '3 tbsp'),
(2, 23, '2 tbsp'),
(3, 24, '1 cup'),
(3, 25, '3/4 cup'),
(3, 26, '1/4 cup'),
(3, 27, '1/4 cup'),
(3, 28, '2'),
(3, 29, '1/2 tbsp'),
(4, 30, '250g'),
(4, 23, '1/2 tbsp'),
(4, 31, '1 1/2 tbsp'),
(4, 27, '1/4 tbsp'),
(4, 8, '1/4 tbsp'),
(4, 19, '1/4 tbsp'),
(4, 32, '115g'),
(4, 18, '1/4 tbsp'),
(4, 33, '1 cup'),
(4, 34, '1/4 tbsp'),
(4, 35, '8g'),
(5, 36, '150g'),
(5, 37, '125g'),
(5, 23, '3/4 tbsp'),
(5, 38, '1/4'),
(5, 39, '50g'),
(5, 40, '1/2 tbsp'),
(5, 41, '1/3 cup'),
(6, 42, '8g'),
(6, 43, '90ml'),
(6, 44, '3cm'),
(6, 45, '35g'),
(6, 46, '90g'),
(6, 47, '2'),
(6, 20, '5g'),
(7, 48, '35g'),
(7, 49, '1/2 tbsp'),
(7, 50, '75g'),
(7, 51, '15ml'),
(7, 52, '10g'),
(7, 53, '1/2 tbsp'),
(7, 8, '1/4 tbsp'),
(7, 54, '1/2'),
(7, 55, '60g'),
(7, 56, '2'),
(8, 35, '10g'),
(8, 57, '50g'),
(8, 58, '1/4 cup'),
(8, 59, '4'),
(8, 60, '1/3 cup'),
(9, 61, '300g'),
(9, 22, '1/4 cup'),
(9, 49, '1/4 tbsp'),
(9, 38, '1/4'),
(9, 62, '1cm'),
(9, 54, '1/2'),
(9, 63, '1/4'),
(9, 64, '1/4'),
(9, 21, '1/2'),
(9, 65, '1/4 cup'),
(9, 66, '1/3 cup'),
(9, 20, '1/4 tbsp'),
(9, 67, '300g'),
(9, 68, '1/4 cup'),
(9, 52, '1/4 tbsp'),
(9, 69, '125g'),
(9, 70, '30g'),
(9, 71, '25g'),
(10, 72, '125g'),
(10, 73, '2 tbsp'),
(10, 74, '40g'),
(10, 75, '20g'),
(10, 76, '1'),
(10, 77, '1/4'),
(10, 78, '2 tbsp'),
(11, 56, '1'),
(11, 79, '2 tbsp'),
(11, 80, '40g'),
(11, 75, '20g'),
(11, 76, '1'),
(11, 77, '1/4'),
(12, 81, '2'),
(12, 82, '50g'),
(12, 83, '1 cup'),
(12, 75, '20g'),
(12, 56, '8'),
(12, 84, '1/4 cup'),
(12, 85, '1/2 cup');

-- --------------------------------------------------------

--
-- Table structure for table `Recipe_Type`
--

CREATE TABLE `Recipe_Type` (
  `RecipeId` int NOT NULL,
  `TypeId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Recipe_Type`
--

INSERT INTO `Recipe_Type` (`RecipeId`, `TypeId`) VALUES
(1, 8),
(2, 2),
(3, 9),
(4, 3),
(4, 4),
(5, 3),
(5, 4),
(6, 2),
(6, 6),
(7, 2),
(7, 7),
(8, 2),
(8, 5),
(9, 2),
(9, 4),
(10, 1),
(10, 7),
(11, 1),
(11, 7),
(12, 1),
(12, 5);

-- --------------------------------------------------------

--
-- Table structure for table `Restaurant`
--

CREATE TABLE `Restaurant` (
  `RestID` int NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Address` varchar(90) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `RestTypeId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Restaurant`
--

INSERT INTO `Restaurant` (`RestID`, `Name`, `Address`, `latitude`, `longitude`, `RestTypeId`) VALUES
(1, 'Sushi Hub M City', 'M/2107 Dandenong Rd, Clayton VIC 3168', -37.921347, 145.140109, 1),
(2, 'Monash University Clayton Campus', '21 Chancellors Walk, Clayton VIC 3800', -37.911837, 145.133061, 2),
(3, 'Ramen & Dumpling House Clayton', '176 Clayton Rd, Clayton VIC 3168', -37.914405, 145.121845, 3),
(4, 'Kin &Gin (Zeros Bento)', '14 Bellerive Ave, Mount Waverley VIC 3149', -37.898739, 145.124172, 4),
(5, 'Eton Restaurant', '1459A Centre Rd, Clayton VIC 3168', -37.929488, 145.128425, 5),
(6, 'Pho Hung Vuong Clayton', '346A Clayton Rd, Clayton VIC 3168', -37.927867, 145.119422, 6),
(7, 'Kentavros Greek & Mediterranean Cuisine', '275 Huntingdale Rd, Oakleigh VIC 3166', -37.909272, 145.103619, 7),
(8, 'Health Express', '96 Springvale Rd & Ferntree Gully Rd, Glen Waverley VIC 3150', -37.903907, 145.162752, 8),
(9, 'Proud Peacock Restaurant', '28 Hamilton Pl, Mount Waverley VIC 3149', -37.875845, 145.128715, 6),
(10, 'Kitchen Bar Cafe', '9/11 Miles St, Mulgrave VIC 3170', -37.922979, 145.151185, 4);

-- --------------------------------------------------------

--
-- Table structure for table `RestType`
--

CREATE TABLE `RestType` (
  `RestTypeId` int NOT NULL,
  `RestTypeName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `RestType`
--

INSERT INTO `RestType` (`RestTypeId`, `RestTypeName`) VALUES
(1, 'Japanese Cuisine'),
(2, 'Mexican Food'),
(3, 'Chinese Restaurant'),
(4, 'Café'),
(5, 'Indian Food'),
(6, 'Vietnamese Food'),
(7, 'Greek Cuisine'),
(8, 'Salad');

-- --------------------------------------------------------

--
-- Table structure for table `Type`
--

CREATE TABLE `Type` (
  `TypeId` int NOT NULL,
  `TypeName` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Type`
--

INSERT INTO `Type` (`TypeId`, `TypeName`) VALUES
(1, 'Breakfast'),
(2, 'Lunch'),
(3, 'Dinner'),
(4, 'Beef'),
(5, 'Pork'),
(6, 'Chicken'),
(7, 'Vegetarian'),
(8, 'Soup'),
(9, 'Dessert');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CookingStep`
--
ALTER TABLE `CookingStep`
  ADD PRIMARY KEY (`CookingId`);

--
-- Indexes for table `Ingredient`
--
ALTER TABLE `Ingredient`
  ADD PRIMARY KEY (`IngredientId`);

--
-- Indexes for table `Recipe`
--
ALTER TABLE `Recipe`
  ADD PRIMARY KEY (`RecipeId`);

--
-- Indexes for table `Restaurant`
--
ALTER TABLE `Restaurant`
  ADD PRIMARY KEY (`RestID`);

--
-- Indexes for table `RestType`
--
ALTER TABLE `RestType`
  ADD PRIMARY KEY (`RestTypeId`);

--
-- Indexes for table `Type`
--
ALTER TABLE `Type`
  ADD PRIMARY KEY (`TypeId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
