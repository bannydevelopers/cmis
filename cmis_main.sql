-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2023 at 05:51 PM
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
-- Database: `cmis_main`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `Activities_id` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `duration` int(11) NOT NULL,
  `description` varchar(150) NOT NULL,
  `status` varchar(10) NOT NULL,
  `Project_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `activities_resource`
--

CREATE TABLE `activities_resource` (
  `Activities_resource_id` int(11) NOT NULL,
  `unit` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `Activity_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `bank_id` int(11) NOT NULL,
  `bank_name` text NOT NULL,
  `bank_logo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_partiner`
--

CREATE TABLE `business_partiner` (
  `Business_partiner_id` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `phone_number` int(11) NOT NULL,
  `details` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `Customer_id` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `phone_number` int(11) NOT NULL,
  `physical_adress` varchar(15) NOT NULL,
  `tin_number` int(11) NOT NULL,
  `VRN_number` varchar(15) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `debts`
--

CREATE TABLE `debts` (
  `debts_id` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `description` varchar(150) NOT NULL,
  `amount` int(11) NOT NULL,
  `party_type` enum('business_partner','customer','supplier','staff') NOT NULL,
  `dept_type` enum('loan','lend') NOT NULL,
  `party_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_note`
--

CREATE TABLE `delivery_note` (
  `Delivery_note_id` int(11) NOT NULL,
  `delivery_number` int(11) NOT NULL,
  `file` varchar(45) NOT NULL,
  `Customer_id` int(11) NOT NULL,
  `Purchase_order_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `designation`
--

CREATE TABLE `designation` (
  `designation_id` int(11) NOT NULL,
  `designation_name` varchar(60) NOT NULL,
  `designation_detail` text DEFAULT NULL,
  `created_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `designation`
--

INSERT INTO `designation` (`designation_id`, `designation_name`, `designation_detail`, `created_time`) VALUES
(1, 'Managing director', '', '2023-04-19 13:48:20'),
(2, 'HOD Finance and accounting', '', '2023-04-19 13:49:30'),
(3, 'HOD Administration', '', '2023-04-19 13:50:29'),
(4, 'HOD Technical services', '', '2023-04-19 13:51:12'),
(5, 'HOD Sales and marketing', '', '2023-04-19 13:51:41'),
(6, 'Accountant', '', '2023-04-19 13:52:17'),
(7, 'Finance manager', '', '2023-04-19 13:52:44'),
(8, 'Cashier', '', '2023-04-19 13:52:59'),
(9, 'Administrator', '', '2023-04-19 13:53:28'),
(10, 'HR Manager', '', '2023-04-19 13:53:55'),
(11, 'HR Officer', '', '2023-04-19 13:54:16'),
(12, 'Technical manager', '', '2023-04-19 13:54:39'),
(13, 'Technical supervisor', '', '2023-04-19 13:55:09'),
(14, 'Technicians', '', '2023-04-19 13:55:36'),
(15, 'ARTISAN', '', '2023-04-19 13:55:52'),
(16, 'Developers', '', '2023-04-19 13:56:08'),
(17, 'Sales manager', '', '2023-04-19 13:56:31'),
(18, 'Marketing manager', '', '2023-04-19 13:56:50'),
(19, 'Sales and marketing manager', '', '2023-04-19 13:57:33'),
(20, 'Sales officer', '', '2023-04-19 13:57:53'),
(21, 'Marketing officer', '', '2023-04-19 13:58:20');

-- --------------------------------------------------------

--
-- Table structure for table `designation_role`
--

CREATE TABLE `designation_role` (
  `dr_id` int(11) NOT NULL,
  `designation_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `designation_role`
--

INSERT INTO `designation_role` (`dr_id`, `designation_id`, `role_id`) VALUES
(1, 1, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `Expenses_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `number_item` int(11) NOT NULL,
  `description` varchar(150) NOT NULL,
  `amount` int(11) NOT NULL,
  `purchased_by` int(11) NOT NULL,
  `approved_by` int(11) NOT NULL,
  `approval_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `Invoice_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `type` enum('profoma','tax') NOT NULL,
  `ref_number` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `expire_date` date NOT NULL,
  `Customer_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_item`
--

CREATE TABLE `invoice_item` (
  `Invoice_item_id` int(11) NOT NULL,
  `offer_amount` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `Product_id` int(11) NOT NULL,
  `Invoice_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leave_application`
--

CREATE TABLE `leave_application` (
  `leave_application_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `leave_description` varchar(150) NOT NULL,
  `approval` varchar(10) NOT NULL,
  `remark` varchar(45) NOT NULL,
  `leave_start_date` datetime NOT NULL,
  `leave_end_date` datetime DEFAULT NULL,
  `response_date` datetime DEFAULT NULL,
  `application_date` datetime NOT NULL,
  `responsibility_asignee` int(11) NOT NULL,
  `asignee_response_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leave_list`
--

CREATE TABLE `leave_list` (
  `leave_id` int(10) NOT NULL,
  `leave_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leave_schedule`
--

CREATE TABLE `leave_schedule` (
  `leave_schedule_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `staff_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll`
--

CREATE TABLE `payroll` (
  `payroll_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `working_hours` datetime NOT NULL,
  `payment_amount` int(11) NOT NULL,
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `permission_id` int(11) NOT NULL,
  `permission_name` text NOT NULL,
  `legend` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `petty_cash_expenses`
--

CREATE TABLE `petty_cash_expenses` (
  `Petty_cash_expenses_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `description` varchar(150) NOT NULL,
  `amount` int(11) NOT NULL,
  `Expenses_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `Product_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(150) NOT NULL,
  `unit` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `buying_price` int(11) NOT NULL,
  `selling_price` int(11) NOT NULL,
  `Supplier_id` int(11) NOT NULL,
  `Store_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `Project_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `starting_date` datetime NOT NULL,
  `ending_date` datetime NOT NULL,
  `description` varchar(150) NOT NULL,
  `burget` int(11) NOT NULL,
  `Staff_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order`
--

CREATE TABLE `purchase_order` (
  `Purchase_order_id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `amount` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `Supplier_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receipt`
--

CREATE TABLE `receipt` (
  `Receipt_id` int(11) NOT NULL,
  `date` varchar(10) NOT NULL,
  `receipt_number` int(11) NOT NULL,
  `Purchase_order_id` int(11) NOT NULL,
  `Invoice_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `Report_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `details` varchar(20) NOT NULL,
  `Activities_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `request_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `description` varchar(150) NOT NULL,
  `requester_id` int(11) NOT NULL,
  `approver_id` int(11) NOT NULL,
  `approval` varchar(10) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `revenue`
--

CREATE TABLE `revenue` (
  `Revenue_id` int(11) NOT NULL,
  `type` varchar(15) NOT NULL,
  `description` varchar(150) NOT NULL,
  `amount` int(11) NOT NULL,
  `Receipt_id` int(11) NOT NULL,
  `Debt_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `name`, `created_time`) VALUES
(1, 'Accounts', '2023-04-18 13:12:23'),
(2, 'Technicians', '2023-04-18 13:12:23'),
(3, 'Root', '2023-04-18 15:09:53'),
(4, 'Administrator', '2023-04-18 15:09:53');

-- --------------------------------------------------------

--
-- Table structure for table `role_permission_list`
--

CREATE TABLE `role_permission_list` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `bank_id` varchar(30) DEFAULT NULL,
  `bank_account_number` text DEFAULT NULL,
  `registration_number` varchar(12) NOT NULL,
  `residence_address` text NOT NULL,
  `designation` int(11) NOT NULL,
  `user_reference` int(11) NOT NULL,
  `date_employed` datetime NOT NULL,
  `employment_length` int(11) NOT NULL,
  `employment_status` enum('active','terminated_by_office','ended','terminated_user') NOT NULL,
  `employment_last_renewal` datetime DEFAULT NULL,
  `employment_termination_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `bank_id`, `bank_account_number`, `registration_number`, `residence_address`, `designation`, `user_reference`, `date_employed`, `employment_length`, `employment_status`, `employment_last_renewal`, `employment_termination_date`) VALUES
(1, NULL, NULL, 'TX89Y', 'Samora avenue,\r\nPosta', 1, 2, '2023-04-18 12:09:21', 2, 'active', NULL, NULL),
(2, NULL, NULL, 'TYG90876', 'Makongo juu, Dar es Salaam', 1, 4, '2023-04-12 00:00:00', 2, 'active', NULL, NULL),
(3, NULL, NULL, 'TYG90876X6', 'Makongo chini, Dar es Salaam', 3, 0, '2023-04-17 00:00:00', 2, 'active', NULL, NULL),
(4, NULL, NULL, 'TYG90876X', 'Makongo chini, Dar es Salaam', 3, 0, '2023-04-17 00:00:00', 2, 'active', NULL, NULL),
(5, NULL, NULL, 'TYG90876X9', 'Makongo chini, Dar es Salaam', 2, 7, '2023-04-17 00:00:00', 2, 'active', NULL, NULL),
(6, NULL, NULL, 'TYG90876U', 'Samora evenue', 1, 8, '2023-04-17 00:00:00', 2, 'active', NULL, NULL),
(7, NULL, NULL, 'Banny14j', 'Makongo juu', 14, 0, '2023-04-11 00:00:00', 2, 'active', NULL, NULL),
(8, NULL, NULL, 'Banny14', 'Makongo juu', 14, 0, '2023-04-11 00:00:00', 2, 'active', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `Store_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `location` varchar(15) NOT NULL,
  `Staff_id` int(11) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `Supplier_id` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `phone_number` int(11) NOT NULL,
  `email` varchar(20) NOT NULL,
  `details` varchar(45) NOT NULL,
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(10) NOT NULL,
  `middle_name` varchar(30) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `system_role` varchar(10) NOT NULL,
  `status` enum('active','inactive','deleted') NOT NULL,
  `phone_number` bigint(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(32) NOT NULL,
  `activation_token` text DEFAULT NULL,
  `created_by` char(20) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `first_name`, `middle_name`, `last_name`, `system_role`, `status`, `phone_number`, `email`, `password`, `activation_token`, `created_by`, `created_time`) VALUES
(1, 'Root', 'Coder', 'User', '2', 'active', 255713824487, 'wizdontz@gmail.com', '734fcec7bede8606e68a4969441882fb', NULL, '0', '2023-04-14 09:43:25'),
(2, 'Abie', 'Coder', 'Msitu', '2', 'active', 255757569016, 'abie@banny.co.tz', '734fcec7bede8606e68a4969441882fb', NULL, '1', '2023-04-14 09:43:25'),
(4, 'Jasper', 'Katunzi', 'Ashomile', '1', 'active', 255757569016, 'adam@banny.co.tz', '40169fdc910b51504066f52fe47d2d5c', NULL, '1', '2023-04-18 19:09:08'),
(7, 'Adam', 'Sikonge', 'Kijabu', '2', 'active', 255757569016, 'adam@banny.co.tz', 'a6acd7215e8c416cb93fdae95a5bfae0', NULL, '1', '2023-04-18 19:46:28'),
(8, 'Banny', 'Jumbo', 'Developer', '1', 'active', 255713824486, 'password@banny.co.tz', '0c4889c5fbfab87158b707b43065f842', NULL, '1', '2023-04-18 19:49:16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`Activities_id`),
  ADD KEY `contain` (`Project_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `activities_resource`
--
ALTER TABLE `activities_resource`
  ADD PRIMARY KEY (`Activities_resource_id`),
  ADD KEY `Activity_id` (`Activity_id`);

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`bank_id`);

--
-- Indexes for table `business_partiner`
--
ALTER TABLE `business_partiner`
  ADD PRIMARY KEY (`Business_partiner_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`Customer_id`);

--
-- Indexes for table `debts`
--
ALTER TABLE `debts`
  ADD PRIMARY KEY (`debts_id`);

--
-- Indexes for table `delivery_note`
--
ALTER TABLE `delivery_note`
  ADD PRIMARY KEY (`Delivery_note_id`),
  ADD KEY `Customer_id` (`Customer_id`),
  ADD KEY `Purchase_order_id` (`Purchase_order_id`);

--
-- Indexes for table `designation`
--
ALTER TABLE `designation`
  ADD PRIMARY KEY (`designation_id`),
  ADD UNIQUE KEY `designation_name` (`designation_name`);

--
-- Indexes for table `designation_role`
--
ALTER TABLE `designation_role`
  ADD PRIMARY KEY (`dr_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`Expenses_id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`Invoice_id`),
  ADD KEY `Customer_id` (`Customer_id`);

--
-- Indexes for table `invoice_item`
--
ALTER TABLE `invoice_item`
  ADD PRIMARY KEY (`Invoice_item_id`),
  ADD KEY `Product_id` (`Product_id`),
  ADD KEY `Invoice_id` (`Invoice_id`);

--
-- Indexes for table `leave_application`
--
ALTER TABLE `leave_application`
  ADD PRIMARY KEY (`leave_application_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `leave_list`
--
ALTER TABLE `leave_list`
  ADD PRIMARY KEY (`leave_id`);

--
-- Indexes for table `leave_schedule`
--
ALTER TABLE `leave_schedule`
  ADD PRIMARY KEY (`leave_schedule_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `payroll`
--
ALTER TABLE `payroll`
  ADD PRIMARY KEY (`payroll_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`permission_id`);

--
-- Indexes for table `petty_cash_expenses`
--
ALTER TABLE `petty_cash_expenses`
  ADD PRIMARY KEY (`Petty_cash_expenses_id`),
  ADD KEY `Expenses_id` (`Expenses_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`Product_id`),
  ADD KEY `Store_id` (`Store_id`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`Project_id`),
  ADD KEY `Staff_id` (`Staff_id`);

--
-- Indexes for table `purchase_order`
--
ALTER TABLE `purchase_order`
  ADD PRIMARY KEY (`Purchase_order_id`),
  ADD KEY `Supplier_id` (`Supplier_id`);

--
-- Indexes for table `receipt`
--
ALTER TABLE `receipt`
  ADD PRIMARY KEY (`Receipt_id`),
  ADD KEY `Purchase_order_id` (`Purchase_order_id`),
  ADD KEY `Invoice_id` (`Invoice_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`Report_id`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`request_id`);

--
-- Indexes for table `revenue`
--
ALTER TABLE `revenue`
  ADD PRIMARY KEY (`Revenue_id`),
  ADD KEY `Receipt_id` (`Receipt_id`),
  ADD KEY `Debt_id` (`Debt_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `role_permission_list`
--
ALTER TABLE `role_permission_list`
  ADD KEY `role_id` (`role_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `registration_number` (`registration_number`,`user_reference`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`Store_id`),
  ADD KEY `Staff_id` (`Staff_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`Supplier_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `Activities_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `activities_resource`
--
ALTER TABLE `activities_resource`
  MODIFY `Activities_resource_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `bank_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `business_partiner`
--
ALTER TABLE `business_partiner`
  MODIFY `Business_partiner_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `Customer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `debts`
--
ALTER TABLE `debts`
  MODIFY `debts_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_note`
--
ALTER TABLE `delivery_note`
  MODIFY `Delivery_note_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `designation`
--
ALTER TABLE `designation`
  MODIFY `designation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `designation_role`
--
ALTER TABLE `designation_role`
  MODIFY `dr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `Expenses_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `Invoice_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_item`
--
ALTER TABLE `invoice_item`
  MODIFY `Invoice_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leave_application`
--
ALTER TABLE `leave_application`
  MODIFY `leave_application_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leave_list`
--
ALTER TABLE `leave_list`
  MODIFY `leave_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leave_schedule`
--
ALTER TABLE `leave_schedule`
  MODIFY `leave_schedule_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll`
--
ALTER TABLE `payroll`
  MODIFY `payroll_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `petty_cash_expenses`
--
ALTER TABLE `petty_cash_expenses`
  MODIFY `Petty_cash_expenses_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `Product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `Project_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_order`
--
ALTER TABLE `purchase_order`
  MODIFY `Purchase_order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `receipt`
--
ALTER TABLE `receipt`
  MODIFY `Receipt_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `Report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `revenue`
--
ALTER TABLE `revenue`
  MODIFY `Revenue_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `store`
--
ALTER TABLE `store`
  MODIFY `Store_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `Supplier_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  ADD CONSTRAINT `contain` FOREIGN KEY (`Project_id`) REFERENCES `project` (`Project_id`);

--
-- Constraints for table `activities_resource`
--
ALTER TABLE `activities_resource`
  ADD CONSTRAINT `activities_resource_ibfk_1` FOREIGN KEY (`Activity_id`) REFERENCES `activities` (`Activities_id`);

--
-- Constraints for table `delivery_note`
--
ALTER TABLE `delivery_note`
  ADD CONSTRAINT `delivery_note_ibfk_1` FOREIGN KEY (`Customer_id`) REFERENCES `customer` (`Customer_id`),
  ADD CONSTRAINT `delivery_note_ibfk_2` FOREIGN KEY (`Purchase_order_id`) REFERENCES `purchase_order` (`Purchase_order_id`);

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`Customer_id`) REFERENCES `customer` (`Customer_id`);

--
-- Constraints for table `invoice_item`
--
ALTER TABLE `invoice_item`
  ADD CONSTRAINT `invoice_item_ibfk_1` FOREIGN KEY (`Product_id`) REFERENCES `product` (`Product_id`),
  ADD CONSTRAINT `invoice_item_ibfk_2` FOREIGN KEY (`Invoice_id`) REFERENCES `invoice` (`Invoice_id`);

--
-- Constraints for table `leave_application`
--
ALTER TABLE `leave_application`
  ADD CONSTRAINT `leave_application_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

--
-- Constraints for table `leave_schedule`
--
ALTER TABLE `leave_schedule`
  ADD CONSTRAINT `leave_schedule_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

--
-- Constraints for table `payroll`
--
ALTER TABLE `payroll`
  ADD CONSTRAINT `payroll_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

--
-- Constraints for table `petty_cash_expenses`
--
ALTER TABLE `petty_cash_expenses`
  ADD CONSTRAINT `petty_cash_expenses_ibfk_1` FOREIGN KEY (`Expenses_id`) REFERENCES `expenses` (`Expenses_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`Store_id`) REFERENCES `store` (`Store_id`);

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `project_ibfk_1` FOREIGN KEY (`Staff_id`) REFERENCES `staff` (`staff_id`);

--
-- Constraints for table `purchase_order`
--
ALTER TABLE `purchase_order`
  ADD CONSTRAINT `purchase_order_ibfk_1` FOREIGN KEY (`Supplier_id`) REFERENCES `supplier` (`Supplier_id`);

--
-- Constraints for table `receipt`
--
ALTER TABLE `receipt`
  ADD CONSTRAINT `receipt_ibfk_1` FOREIGN KEY (`Purchase_order_id`) REFERENCES `purchase_order` (`Purchase_order_id`),
  ADD CONSTRAINT `receipt_ibfk_2` FOREIGN KEY (`Invoice_id`) REFERENCES `invoice` (`Invoice_id`);

--
-- Constraints for table `revenue`
--
ALTER TABLE `revenue`
  ADD CONSTRAINT `revenue_ibfk_1` FOREIGN KEY (`Receipt_id`) REFERENCES `receipt` (`Receipt_id`),
  ADD CONSTRAINT `revenue_ibfk_2` FOREIGN KEY (`Debt_id`) REFERENCES `debts` (`debts_id`);

--
-- Constraints for table `role_permission_list`
--
ALTER TABLE `role_permission_list`
  ADD CONSTRAINT `role_permission_list_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  ADD CONSTRAINT `role_permission_list_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`);

--
-- Constraints for table `store`
--
ALTER TABLE `store`
  ADD CONSTRAINT `store_ibfk_1` FOREIGN KEY (`Staff_id`) REFERENCES `staff` (`staff_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
