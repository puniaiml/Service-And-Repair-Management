-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 25, 2024 at 06:10 AM
-- Server version: 8.2.0
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `srm`
--

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `dept_Id` int NOT NULL AUTO_INCREMENT,
  `dname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dloc` varchar(20) NOT NULL,
  PRIMARY KEY (`dept_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_Id`, `dname`, `dloc`) VALUES
(1, 'AIML', 'LIBRARY BUILDING'),
(2, 'CSE', 'CSE BLOCK'),
(3, 'ISE', 'ISE BLOCK'),
(4, 'EEE', 'EEE BLOCK'),
(5, 'MECHANICAL', 'OB BLOCK');

--
-- Triggers `department`
--
DROP TRIGGER IF EXISTS `tgr_dname`;
DELIMITER $$
CREATE TRIGGER `tgr_dname` BEFORE INSERT ON `department` FOR EACH ROW IF NEW.dname IS NULL THEN 
        SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Warning: Department name can not be empty';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `Item_Id` int NOT NULL AUTO_INCREMENT,
  `Item_Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DOM` date NOT NULL,
  `Category_Id` int NOT NULL,
  `uid` int DEFAULT NULL,
  `dept_id` int DEFAULT NULL,
  PRIMARY KEY (`Item_Id`),
  KEY `uid` (`uid`),
  KEY `item_ibfk_2` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`Item_Id`, `Item_Name`, `Description`, `DOM`, `Category_Id`, `uid`, `dept_id`) VALUES
(11, 'DESK', 'Desk is an essential piece of furniture tailored for the dynamic demands of college life. Whether it\'s intensive study sessions, research projects, or virtual lectures, this desk provides the perfect platform for academic success.', '2020-06-11', 1, NULL, 1),
(12, 'CHAIR', 'The Student Lounge Chair is a versatile seating solution designed to meet the diverse needs of college students. Whether it\'s studying, socializing, or relaxing between classes, this chair provides the perfect blend of comfort and functionality.', '2021-06-19', 1, NULL, 2),
(13, 'COMPUTER DESK', 'The Collegiate Computer Desk is a versatile workstation designed to meet the technological demands of college students. Whether it\'s completing assignments, attending virtual lectures, or conducting research, this desk provides the ideal platform for academic success.', '2021-12-23', 1, NULL, 3),
(14, 'PROJECTOR', 'Projector is a versatile multimedia solution designed to enhance learning experiences in college classrooms, lecture halls, and study lounges. With its advanced features and user-friendly design, this projector is an indispensable tool for students and educators alike.', '2022-09-26', 2, NULL, 4),
(15, 'COMPUTER', 'The Campus Computer is a versatile and powerful computing solution designed to meet the academic and personal needs of college students. Equipped with advanced features and reliable performance, this computer is an indispensable tool for research, assignments, presentations, and more.', '2020-03-19', 2, NULL, 5),
(16, 'CC CAMERA', 'CCTV Camera is a cutting-edge surveillance solution designed to enhance security and safety on college campuses. With its advanced features and reliable performance, this camera provides comprehensive monitoring and protection for students, faculty, staff, and campus property.', '2023-11-14', 2, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `item_category`
--

DROP TABLE IF EXISTS `item_category`;
CREATE TABLE IF NOT EXISTS `item_category` (
  `Category_Id` int NOT NULL AUTO_INCREMENT,
  `Category_Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Category_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `item_category`
--

INSERT INTO `item_category` (`Category_Id`, `Category_Name`, `Description`) VALUES
(1, 'FURNITURES', 'The Campus Comfort Collection presents Furniture, designed specifically to meet the unique needs of college environments. Crafted with durability and student comfort in mind, this piece is a staple for any dormitory or common area.'),
(2, 'ELECTRONICS', 'Introducing the ultimate fusion of comfort and convenience, the Integrated Electronics is a must-have for modern college living. This innovative piece seamlessly integrates essential electronics to enhance the student experience in dormitories or common areas.');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `Item_Id` int NOT NULL,
  `sdes` text NOT NULL,
  `sdate` date NOT NULL,
  `sid` int NOT NULL,
  `service_cost` int DEFAULT NULL,
  PRIMARY KEY (`Item_Id`,`sdate`,`sid`),
  UNIQUE KEY `Item_Id` (`Item_Id`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`Item_Id`, `sdes`, `sdate`, `sid`, `service_cost`) VALUES
(11, 'Completed (Item Service Completed)', '2024-03-09', 4, 699),
(14, 'Working (Item Service On-going)', '2024-03-21', 3, 800),
(15, 'Service Rejected (Item Service Rejected)', '2024-03-15', 2, 0),
(16, 'Working (Item Service On-going)', '2024-03-22', 5, 4000);

-- --------------------------------------------------------

--
-- Table structure for table `service_provider`
--

DROP TABLE IF EXISTS `service_provider`;
CREATE TABLE IF NOT EXISTS `service_provider` (
  `Provider_Id` int NOT NULL AUTO_INCREMENT,
  `Provider_Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Phone` bigint NOT NULL,
  `Email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pwd` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`Provider_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `service_provider`
--

INSERT INTO `service_provider` (`Provider_Id`, `Provider_Name`, `Phone`, `Email`, `pwd`) VALUES
(1, 'provider', 0, 'pro@gmail.com', 'e10adc3949ba59abbe56e057f20f883e'),
(2, 'aaa', 0, 'aa@gmail.com', 'c483f6ce851c9ecd9fb835ff7551737c'),
(3, 'lalu', 9900920025, 'lal@gmail.com', '9cdfb439c7876e703e307864c9167a15'),
(4, 'admin', 9900920025, 'ckr@gmail.com', 'f27f6f1c7c5cbf4e3e192e0a47b85300'),
(5, 'puneeth', 9999999999, '123@gmail.com', 'f27f6f1c7c5cbf4e3e192e0a47b85300'),
(6, 'veeru', 9999999999, 'cutie@gmail.com', 'f27f6f1c7c5cbf4e3e192e0a47b85300'),
(7, 'Provider', 9999999999, 'provider@gmail.com', '9e9f3d70bd8c8957627eada96d967706');

-- --------------------------------------------------------

--
-- Table structure for table `service_request`
--

DROP TABLE IF EXISTS `service_request`;
CREATE TABLE IF NOT EXISTS `service_request` (
  `item_id` int NOT NULL,
  `pdes` text NOT NULL,
  `rdate` date NOT NULL,
  PRIMARY KEY (`item_id`,`rdate`),
  UNIQUE KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `service_request`
--

INSERT INTO `service_request` (`item_id`, `pdes`, `rdate`) VALUES
(11, 'Broken Leg', '2024-09-23'),
(14, 'Color grading problem', '2024-03-07'),
(15, 'HARD DISK PROBLEM', '2024-01-08'),
(16, 'NEW CAMERA INSTALATION', '2024-03-17');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff` (
  `Staff_Id` int NOT NULL AUTO_INCREMENT,
  `Staff_Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Designation` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Phone` bigint NOT NULL,
  `Email` varchar(20) NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Staff_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`Staff_Id`, `Staff_Name`, `Designation`, `Phone`, `Email`, `address`) VALUES
(2, 'Sathwik p', 'Electrician', 9900202018, 'sathwik@gmail.com', 'Tarikere'),
(3, 'Penga', 'Electrician', 9380838017, 'penga@gmail.com', 'Vinoba nagar, Shimoga'),
(4, 'Mona', 'carpenter', 9380226688, 'mona@gmail.com', 'Gandi nagar, Shimoga'),
(5, 'Sona', 'Supporting Staff', 9380226699, 'sona@gmail.com', 'Jayanagar, Shimoga');

-- --------------------------------------------------------

--
-- Table structure for table `userlogin`
--

DROP TABLE IF EXISTS `userlogin`;
CREATE TABLE IF NOT EXISTS `userlogin` (
  `uname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(50) NOT NULL,
  `pwd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `userid` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `userlogin`
--

INSERT INTO `userlogin` (`uname`, `email`, `pwd`, `userid`) VALUES
('veerendra', '999@gmail.com', 'b706835de79a2b4e80506f582af367', 4),
('puneeth', 'abc@gmail.com', '202cb962ac59075b964b07152d234b', 5),
('srujan', 'ss12@gmail.com', '255a20be873cf3ab0647205853592c09', 9),
('veeru', 'v@gmail.com', 'b706835de79a2b4e80506f582af3676a', 13),
('puneeth', 'pu@gmail.com', 'f27f6f1c7c5cbf4e3e192e0a47b85300', 14),
('Sathwik', 'sss@gmail.com', '9f6e6800cfae7749eb6c486619254b9c', 15),
('user', 'user@gmail.com', 'ee11cbb19052e40b07aac0ca060c23ee', 16),
('user1', 'user1@gmail.com', '25d55ad283aa400af464c76d713c07ad', 17);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `userlogin` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `item_ibfk_2` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `service`
--
ALTER TABLE `service`
  ADD CONSTRAINT `service_ibfk_1` FOREIGN KEY (`Item_Id`) REFERENCES `item` (`Item_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `service_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `staff` (`Staff_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `service_request`
--
ALTER TABLE `service_request`
  ADD CONSTRAINT `service_request_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`Item_Id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
