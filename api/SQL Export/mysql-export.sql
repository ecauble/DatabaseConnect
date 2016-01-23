SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `mydbms`
--

-- --------------------------------------------------------

--
-- Table structure for table `Registered_Devices`
--

CREATE TABLE `Registered_Devices` (
  `user_id` int(11) NOT NULL,
  `device_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_mysql500_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`user_name`, `password`, `first_name`, `last_name`, `user_id`) VALUES
('user1', '912ec803b2ce49e4a541068d495ab570', NULL, NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Registered_Devices`
--
ALTER TABLE `Registered_Devices`
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_name` (`user_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Registered_Devices`
--
ALTER TABLE `Registered_Devices`
  ADD CONSTRAINT `registered_devices_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);
