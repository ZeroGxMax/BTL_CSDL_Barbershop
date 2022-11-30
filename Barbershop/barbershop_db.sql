-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 30, 2022 at 06:49 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barbershop`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `drop_all_tables` ()   BEGIN
    DECLARE _done INT DEFAULT FALSE;
    DECLARE _tableName VARCHAR(255);
    DECLARE _cursor CURSOR FOR
        SELECT table_name 
        FROM information_schema.TABLES
        WHERE table_schema = SCHEMA();
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _done = TRUE;

    SET FOREIGN_KEY_CHECKS = 0;

    OPEN _cursor;

    REPEAT FETCH _cursor INTO _tableName;

    IF NOT _done THEN
        SET @stmt_sql = CONCAT('DROP TABLE ', _tableName);
        PREPARE stmt1 FROM @stmt_sql;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
    END IF;

    UNTIL _done END REPEAT;

    CLOSE _cursor;
    SET FOREIGN_KEY_CHECKS = 1;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(5) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `customer_id` int(5) NOT NULL,
  `employee_id` int(2) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time_expected` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `canceled` tinyint(1) NOT NULL DEFAULT 0,
  `cancellation_reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `date_created`, `customer_id`, `employee_id`, `start_time`, `end_time_expected`, `canceled`, `cancellation_reason`) VALUES
(1, '2022-12-03 16:34:00', 2, 4, '2022-12-06 12:00:00', '2022-12-06 12:25:00', 0, NULL),
(2, '2022-12-18 13:29:00', 6, 3, '2022-12-21 10:36:00', '2022-12-21 10:46:00', 0, NULL),
(3, '2022-12-13 02:23:00', 1, 2, '2022-12-14 05:01:00', '2022-12-14 05:46:00', 0, NULL),
(4, '2022-12-04 21:33:00', 11, 4, '2022-12-07 23:51:00', '2022-12-08 00:26:00', 0, NULL),
(5, '2022-11-09 15:42:00', 5, 2, '2022-11-12 19:35:00', '2022-11-12 20:05:00', 0, NULL),
(6, '2022-11-02 22:48:00', 12, 1, '2022-11-05 10:35:00', '2022-11-05 11:05:00', 0, NULL),
(7, '2022-11-06 15:11:00', 2, 4, '2022-11-08 22:53:00', '2022-11-08 23:18:00', 0, NULL),
(8, '2022-10-26 03:01:00', 4, 1, '2022-10-28 03:48:00', '2022-10-28 04:13:00', 0, NULL),
(9, '2022-10-28 23:05:00', 4, 3, '2022-10-31 03:40:00', '2022-10-31 04:00:00', 0, NULL),
(10, '2022-11-18 14:24:00', 1, 3, '2022-11-19 19:36:00', '2022-11-19 20:11:00', 0, NULL),
(11, '2022-12-16 17:43:00', 4, 2, '2022-12-20 12:15:00', '2022-12-20 13:00:00', 0, NULL),
(12, '2022-12-11 18:46:00', 12, 4, '2022-12-13 23:00:00', '2022-12-13 23:30:00', 0, NULL),
(13, '2022-11-16 05:40:00', 12, 1, '2022-11-19 15:02:00', '2022-11-19 15:47:00', 0, NULL),
(14, '2022-10-21 23:53:00', 7, 3, '2022-10-23 08:03:00', '2022-10-23 08:33:00', 0, NULL),
(15, '2022-11-24 08:39:00', 2, 4, '2022-11-27 06:22:00', '2022-11-27 06:42:00', 0, NULL),
(16, '2022-11-22 01:47:00', 7, 1, '2022-11-25 00:32:00', '2022-11-25 01:17:00', 0, NULL),
(17, '2022-12-02 15:12:00', 2, 1, '2022-12-04 03:03:00', '2022-12-04 03:28:00', 0, NULL),
(18, '2022-11-01 14:00:00', 1, 1, '2022-11-05 02:27:00', '2022-11-05 02:37:00', 0, NULL),
(19, '2022-12-15 14:07:00', 9, 4, '2022-12-17 10:54:00', '2022-12-17 11:14:00', 0, NULL),
(20, '2022-12-19 12:56:00', 11, 4, '2022-12-20 04:42:00', '2022-12-20 05:07:00', 0, NULL),
(21, '2022-11-18 23:22:00', 4, 1, '2022-11-22 16:13:00', '2022-11-22 16:23:00', 0, NULL),
(22, '2022-11-13 13:36:00', 1, 2, '2022-11-13 23:21:00', '2022-11-13 23:46:00', 0, NULL),
(23, '2022-11-03 11:01:29', 3, 4, '2022-11-06 11:24:00', '2022-11-06 11:59:00', 0, NULL),
(24, '2022-10-24 22:33:49', 11, 4, '2022-10-27 02:00:00', '2022-10-27 02:35:00', 0, NULL),
(25, '2022-11-30 08:20:29', 4, 1, '2022-12-04 12:36:00', '2022-12-04 13:01:00', 0, NULL),
(26, '2022-12-09 01:08:57', 3, 3, '2022-12-12 21:56:00', '2022-12-12 22:16:00', 0, NULL),
(27, '2022-11-08 16:47:50', 1, 1, '2022-11-11 18:50:00', '2022-11-11 19:25:00', 0, NULL),
(28, '2022-12-12 16:36:55', 2, 2, '2022-12-13 10:32:00', '2022-12-13 11:17:00', 0, NULL),
(29, '2022-10-28 18:41:57', 9, 4, '2022-10-31 19:05:00', '2022-10-31 19:15:00', 0, NULL),
(30, '2022-12-07 12:03:52', 10, 3, '2022-12-09 08:53:00', '2022-12-09 09:03:00', 0, NULL),
(31, '2022-12-13 08:56:49', 2, 2, '2022-12-16 16:17:00', '2022-12-16 16:37:00', 0, NULL),
(32, '2022-11-23 11:39:09', 3, 1, '2022-11-24 20:11:00', '2022-11-24 20:41:00', 0, NULL),
(33, '2022-12-18 17:46:45', 11, 4, '2022-12-20 19:00:00', '2022-12-20 19:00:00', 0, NULL),
(34, '2022-11-03 23:29:04', 6, 1, '2022-11-06 14:46:00', '2022-11-06 15:16:00', 0, NULL),
(35, '2022-12-13 15:43:46', 9, 3, '2022-12-14 17:59:00', '2022-12-14 18:34:00', 0, NULL),
(36, '2022-10-31 02:16:44', 7, 3, '2022-10-31 22:09:00', '2022-10-31 22:44:00', 0, NULL),
(37, '2022-11-24 05:36:18', 7, 4, '2022-11-26 00:03:00', '2022-11-26 00:33:00', 0, NULL),
(38, '2022-11-29 10:16:24', 8, 2, '2022-12-02 20:23:00', '2022-12-02 20:58:00', 0, NULL),
(39, '2022-11-20 06:36:56', 7, 3, '2022-11-23 09:02:00', '2022-11-23 09:27:00', 0, NULL),
(40, '2022-12-08 04:18:01', 5, 4, '2022-12-11 10:40:00', '2022-12-11 11:15:00', 0, NULL),
(41, '2022-10-27 23:16:31', 12, 1, '2022-10-27 14:37:00', '2022-10-27 14:47:00', 0, NULL),
(42, '2022-11-09 15:28:14', 12, 4, '2022-11-11 11:27:00', '2022-11-11 11:47:00', 0, NULL),
(43, '2022-10-25 14:19:55', 7, 3, '2022-10-27 02:05:00', '2022-10-27 02:30:00', 0, NULL),
(44, '2022-10-23 08:02:36', 11, 4, '2022-10-25 17:21:00', '2022-10-25 17:36:00', 0, NULL),
(45, '2022-10-29 03:10:30', 7, 2, '2022-10-31 00:07:00', '2022-10-31 00:32:00', 0, NULL),
(46, '2022-11-15 01:45:10', 6, 2, '2022-11-15 16:59:00', '2022-11-15 17:09:00', 0, NULL),
(47, '2022-11-03 03:49:05', 9, 3, '2022-11-04 16:58:00', '2022-11-04 17:18:00', 0, NULL),
(48, '2022-12-14 08:06:20', 10, 3, '2022-12-15 19:59:00', '2022-12-15 20:09:00', 0, NULL),
(49, '2022-12-07 14:49:04', 2, 2, '2022-12-10 19:04:00', '2022-12-10 19:29:00', 0, NULL),
(50, '2022-11-05 09:01:21', 6, 1, '2022-11-08 02:44:00', '2022-11-08 03:09:00', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `barber_admin`
--

CREATE TABLE `barber_admin` (
  `admin_id` int(5) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `barber_admin`
--

INSERT INTO `barber_admin` (`admin_id`, `username`, `email`, `full_name`, `password`) VALUES
(1, 'admin', 'damquan1804@gmail.com', 'Zero', 'f7c3bc1d808e04732adf679965ccc34ca7ae3441');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(5) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `phone_number` varchar(30) NOT NULL,
  `customer_email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `phone_number`, `customer_email`) VALUES
(1, 'Raffaello', 'Battelle', '164 387 7517', 'rbattelle0@cnet.com'),
(2, 'Aileen', 'Cottier', '417 138 5429', 'acottier1@wikispaces.com'),
(3, 'Roshelle', 'Papps', '159 942 7344', 'rpapps2@yellowbook.com'),
(4, 'Stephie', 'Edmundson', '611 294 6352', 'sedmundson3@google.es'),
(5, 'Albie', 'Delgardillo', '104 673 6085', 'adelgardillo4@comcast.net'),
(6, 'Tanney', 'Sebire', '129 520 0959', 'tsebire5@springer.com'),
(7, 'Stacia', 'Cluley', '523 409 4613', 'scluley6@edublogs.org'),
(8, 'Jsandye', 'Duckers', '506 494 6479', 'jduckers7@smh.com.au'),
(9, 'Codi', 'Gubbins', '997 755 2281', 'cgubbins8@hatena.ne.jp'),
(10, 'Colin', 'Chessman', '469 265 7200', 'cchessman9@squarespace.com'),
(11, 'Ceil', 'Mahoney', '993 814 9496', 'cmahoneya@amazon.co.uk'),
(12, 'Rosco', 'Faulkes', '154 965 0057', 'rfaulkesb@over-blog.com');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(2) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `phone_number` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `first_name`, `last_name`, `phone_number`, `email`) VALUES
(1, 'JC\r\n', 'Tha', '', ''),
(2, 'Johnny\r\n', 'Castellanos', '', ''),
(3, 'Marcus\r\n', 'Harvey', '', ''),
(4, 'JayR\r\n', 'Mallari', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `employees_schedule`
--

CREATE TABLE `employees_schedule` (
  `id` int(5) NOT NULL,
  `employee_id` int(2) NOT NULL,
  `day_id` tinyint(1) NOT NULL,
  `from_hour` time NOT NULL,
  `to_hour` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employees_schedule`
--

INSERT INTO `employees_schedule` (`id`, `employee_id`, `day_id`, `from_hour`, `to_hour`) VALUES
(1, 1, 1, '08:00:00', '18:00:00'),
(2, 1, 2, '08:00:00', '18:00:00'),
(3, 1, 3, '08:00:00', '18:00:00'),
(4, 1, 4, '08:00:00', '18:00:00'),
(5, 1, 5, '08:00:00', '18:00:00'),
(6, 1, 6, '08:00:00', '18:00:00'),
(7, 1, 7, '08:00:00', '18:00:00'),
(8, 2, 1, '09:00:00', '19:00:00'),
(9, 2, 2, '09:00:00', '19:00:00'),
(10, 2, 3, '09:00:00', '19:00:00'),
(11, 2, 4, '09:00:00', '19:00:00'),
(12, 2, 5, '09:00:00', '19:00:00'),
(13, 2, 6, '09:00:00', '19:00:00'),
(14, 2, 7, '09:00:00', '19:00:00'),
(15, 3, 1, '11:00:00', '23:00:00'),
(16, 3, 2, '11:00:00', '23:00:00'),
(17, 3, 3, '11:00:00', '23:00:00'),
(18, 3, 4, '11:00:00', '23:00:00'),
(19, 3, 5, '11:00:00', '23:00:00'),
(20, 3, 6, '11:00:00', '23:00:00'),
(21, 3, 7, '11:00:00', '23:00:00'),
(22, 4, 1, '08:00:00', '22:00:00'),
(23, 4, 2, '08:00:00', '22:00:00'),
(24, 4, 3, '08:00:00', '22:00:00'),
(25, 4, 4, '08:00:00', '22:00:00'),
(26, 4, 5, '08:00:00', '22:00:00'),
(27, 4, 6, '08:00:00', '22:00:00'),
(28, 4, 7, '08:00:00', '22:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE `feedbacks` (
  `feedback_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `comments` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `feedbacks`
--

INSERT INTO `feedbacks` (`feedback_id`, `appointment_id`, `rate`, `comments`) VALUES
(1, 12, 5, NULL),
(2, 22, 5, 'Nondisp commnt fx shaft of r femr, 7thN'),
(3, 18, 5, NULL),
(4, 1, 3, 'Nondisp fx of acromial pro, r shldr, subs for fx w nonunion'),
(5, 13, 4, NULL),
(6, 9, 4, NULL),
(7, 2, 5, NULL),
(8, 11, 1, 'Neoplasm of uncertain behavior of left testis'),
(9, 8, 4, NULL),
(12, 44, 4, NULL),
(16, 45, 2, NULL),
(18, 28, 5, NULL),
(21, 29, 4, NULL),
(29, 35, 4, NULL),
(34, 48, 5, NULL),
(37, 37, 5, NULL),
(38, 39, 4, NULL),
(46, 32, 5, NULL),
(59, 25, 5, NULL),
(61, 27, 2, NULL),
(62, 30, 5, NULL),
(63, 34, 5, NULL),
(67, 17, 5, NULL),
(68, 46, 3, NULL),
(69, 7, 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int(5) NOT NULL,
  `service_name` varchar(50) NOT NULL,
  `service_description` varchar(255) NOT NULL,
  `service_price` decimal(6,2) NOT NULL,
  `service_duration` int(5) NOT NULL,
  `category_id` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `service_name`, `service_description`, `service_price`, `service_duration`, `category_id`) VALUES
(1, 'Hair Cut', 'Barber is a person whose occupation is mainly to cut dress groom style and shave men', '21.00', 20, 1),
(2, 'Hair Styling', 'Barber is a person whose occupation is mainly to cut dress groom style and shave men', '9.00', 15, 1),
(3, 'Hair Triming', 'Barber is a person whose occupation is mainly to cut dress groom style and shave men', '10.00', 10, 1),
(4, 'Clean Shaving', 'Barber is a person whose occupation is mainly to cut dress groom style and shave men', '20.00', 20, 2),
(5, 'Beard Triming', 'Barber is a person whose occupation is mainly to cut dress groom style and shave men', '20.00', 15, 2),
(6, 'Smooth Shave', 'Barber is a person whose occupation is mainly to cut dress groom style and shave men', '15.00', 20, 2),
(7, 'White Facial', 'Barber is a person whose occupation is mainly to cut dress groom style and shave men', '16.00', 15, 3),
(8, 'Face Cleaning', 'Barber is a person whose occupation is mainly to cut dress groom style and shave men', '20.00', 20, 3),
(9, 'Bright Tuning', 'Barber is a person whose occupation is mainly to cut dress groom style and shave men', '14.00', 20, 3);

-- --------------------------------------------------------

--
-- Table structure for table `services_booked`
--

CREATE TABLE `services_booked` (
  `appointment_id` int(5) NOT NULL,
  `service_id` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `services_booked`
--

INSERT INTO `services_booked` (`appointment_id`, `service_id`) VALUES
(1, 1),
(1, 7),
(1, 8),
(2, 1),
(2, 4),
(3, 7),
(4, 8),
(5, 1),
(5, 8),
(5, 9),
(6, 4),
(7, 2),
(8, 4),
(8, 8),
(9, 1),
(9, 3),
(10, 1),
(11, 3),
(11, 9),
(12, 1),
(13, 6),
(14, 5),
(14, 9),
(15, 2),
(15, 3),
(15, 8),
(16, 3),
(16, 8),
(16, 9),
(17, 1),
(18, 6),
(18, 9),
(19, 2),
(19, 5),
(20, 3),
(21, 1),
(21, 2),
(22, 9),
(23, 1),
(23, 5),
(24, 6),
(24, 8),
(25, 3),
(26, 4),
(26, 6),
(27, 1),
(27, 6),
(28, 2),
(29, 9),
(30, 6),
(30, 9),
(31, 1),
(31, 3),
(31, 6),
(31, 9),
(32, 4),
(33, 4),
(34, 2),
(34, 6),
(34, 7),
(35, 3),
(35, 6),
(35, 9),
(36, 2),
(36, 4),
(36, 5),
(37, 3),
(38, 2),
(38, 4),
(38, 7),
(39, 6),
(40, 3),
(40, 9),
(41, 2),
(41, 4),
(42, 9),
(43, 5),
(44, 1),
(45, 5),
(46, 1),
(46, 2),
(46, 6),
(47, 3),
(48, 1),
(48, 8),
(49, 2),
(49, 4),
(50, 4),
(50, 7),
(50, 8);

-- --------------------------------------------------------

--
-- Table structure for table `service_categories`
--

CREATE TABLE `service_categories` (
  `category_id` int(2) NOT NULL,
  `category_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `service_categories`
--

INSERT INTO `service_categories` (`category_id`, `category_name`) VALUES
(1, 'Haircutting'),
(2, 'Shaving'),
(3, 'Face Masking');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `FK_customer_appointment` (`customer_id`),
  ADD KEY `FK_employee_appointment` (`employee_id`);

--
-- Indexes for table `barber_admin`
--
ALTER TABLE `barber_admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`,`email`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `customer_email` (`customer_email`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`);

--
-- Indexes for table `employees_schedule`
--
ALTER TABLE `employees_schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_emp` (`employee_id`);

--
-- Indexes for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`feedback_id`),
  ADD UNIQUE KEY `appointment_id` (`appointment_id`),
  ADD KEY `reviews_appointment_id_fk` (`appointment_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`),
  ADD KEY `FK_service_category` (`category_id`);

--
-- Indexes for table `services_booked`
--
ALTER TABLE `services_booked`
  ADD PRIMARY KEY (`appointment_id`,`service_id`),
  ADD KEY `FK_SB_service` (`service_id`);

--
-- Indexes for table `service_categories`
--
ALTER TABLE `service_categories`
  ADD PRIMARY KEY (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `barber_admin`
--
ALTER TABLE `barber_admin`
  MODIFY `admin_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employees_schedule`
--
ALTER TABLE `employees_schedule`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `service_categories`
--
ALTER TABLE `service_categories`
  MODIFY `category_id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `FK_customer_appointment` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_employee_appointment` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `employees_schedule`
--
ALTER TABLE `employees_schedule`
  ADD CONSTRAINT `FK_emp` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD CONSTRAINT `reviews_appointment_id_fk` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`) ON UPDATE CASCADE;

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `FK_service_category` FOREIGN KEY (`category_id`) REFERENCES `service_categories` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `services_booked`
--
ALTER TABLE `services_booked`
  ADD CONSTRAINT `FK_SB_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_SB_service` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
