-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 24, 2022 at 03:13 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `sno` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `msg` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`sno`, `name`, `phone`, `msg`, `date`, `email`) VALUES
(1, NULL, NULL, NULL, '0000-00-00 00:00:00', NULL),
(20, 'Pranav Kumar', '08920551623', 'Hello there', '2022-09-19 00:10:50', 'pra.nan786@gmail.com'),
(21, NULL, NULL, NULL, '2022-09-19 00:13:02', NULL),
(22, 'Pranav Kumar', '08920551623', 'Hello there', '2022-09-19 00:13:07', 'pra.nan786@gmail.com'),
(23, 'Anurag Shekhar', '08920551623', 'Hellp', '2022-09-19 00:13:31', 'pra.nan786@gmail.com'),
(24, 'survivor', '08920551623', 'I can do', '2022-09-19 00:35:17', 'pra.nan786@gmail.com'),
(25, 'survivor', '08920551623', 'I can do', '2022-09-19 00:36:12', 'pra.nan786@gmail.com'),
(37, 'Pranav Kumar', '08920551623', 'Lets c', '2022-09-19 12:19:34', 'pranavkumar.cs19@bmsce.ac.in'),
(38, 'Pranav Kumar', '08920551623', 'Lets c', '2022-09-19 12:22:21', 'toxicsurviper@gmail.com'),
(39, 'Pranav Kumar', '08920551623', 'Lets c', '2022-09-19 12:23:54', 'pra786@gmail.com'),
(40, 'Pranav Kumar', '08920551623', 'Lets c', '2022-09-19 12:24:48', 'pra786@gmail.com'),
(41, NULL, NULL, NULL, '2022-09-24 18:25:59', NULL),
(42, NULL, NULL, NULL, '2022-09-24 18:26:05', NULL),
(43, NULL, NULL, NULL, '2022-09-24 18:26:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `sno` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `content` varchar(800) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `slug` varchar(25) NOT NULL,
  `img_file` varchar(25) NOT NULL,
  `tagline` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`sno`, `title`, `content`, `date`, `slug`, `img_file`, `tagline`) VALUES
(1, 'Let\'s Learn About BrainChip', 'ssdasd', '2022-09-23', 'first-post', 'assets/img/post-bg.jpg', 'Growing Field'),
(2, 'This is second post', 'Blazing Strike features a four-button system with six normal attacks: light, medium and heavy punches and kicks, as well as three defense moves: block, guard and parry', '2022-09-21', 'second-post', 'assets/img/post-bg.jpg', 'coolest post ever'),
(3, 'Hikaru Nakamura', 'Hikaru Nakamura is a Japanese-American chess grandmaster and online streamer. A chess prodigy, at the age of 15 he became the youngest American up to that time to earn the title of Grandmaster. Nakamura is a five-time U.S. Chess Champion.', '2022-09-23', 'third-post', '', 'Chess Player\r\n'),
(4, 'Magnus Carlsen', 'Sven Magnus Øen Carlsen is a Norwegian chess grandmaster who is the reigning five-time World Chess Champion. He is also a three-time World Rapid Chess Champion and five-time World Blitz Chess Champion.', '0000-00-00', 'chess-grandmaster', '', 'World Chess Grandmaster\r\n'),
(5, 'Errichto', 'Kamil Debowski, or “Errichto”, is a competitive programmer and a teacher. He participated in math contests through school, then switched to programming and became a finalist of the biggest international contests. He is the author of 300+ problems (Codeforces, Topcoder, Codechef, etc.)', '0000-00-00', 'coding_grandmaster', '', 'Coding GrandMaster'),
(6, 'Foreign Minister', 'Subrahmanyam Jaishankar is an Indian diplomat and politician serving as the Minister of External Affairs of the Government of India since 30 May 2019. He is a member of the Bharatiya Janata Party and a Member of Parliament in the Rajya Sabha since 5 July 2019, representing Gujarat', '0000-00-00', 'external-affairs', '', 'Foreign Minister'),
(9, 'sdasd', 'asdnsnskd', '2022-09-23', 'asndkn', 'askdnk', 'nansdlk'),
(10, 'sdfns', 'jqkdsjflksd', '2022-09-23', 'jdslkdjf', 'jfskdljfk', 'jskdfj');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
