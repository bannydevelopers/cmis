-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 21, 2023 at 06:49 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

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
  `Activities_id` int NOT NULL,
  `name` varchar(15) NOT NULL,
  `duration` int NOT NULL,
  `description` varchar(150) NOT NULL,
  `status` varchar(10) NOT NULL,
  `Project_id` int NOT NULL,
  `staff_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `activities_resource`
--

CREATE TABLE `activities_resource` (
  `Activities_resource_id` int NOT NULL,
  `unit` int NOT NULL,
  `quantity` int NOT NULL,
  `Activity_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `bank_id` int NOT NULL,
  `bank_name` text NOT NULL,
  `bank_logo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `business_partiner`
--

CREATE TABLE `business_partiner` (
  `Business_partiner_id` int NOT NULL,
  `name` varchar(15) NOT NULL,
  `phone_number` int NOT NULL,
  `details` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `Customer_id` int NOT NULL,
  `name` varchar(15) NOT NULL,
  `phone_number` int NOT NULL,
  `physical_adress` varchar(15) NOT NULL,
  `tin_number` int NOT NULL,
  `VRN_number` varchar(15) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `debts`
--

CREATE TABLE `debts` (
  `debts_id` int NOT NULL,
  `date` int NOT NULL,
  `description` varchar(150) NOT NULL,
  `amount` int NOT NULL,
  `party_type` enum('business_partner','customer','supplier','staff') NOT NULL,
  `dept_type` enum('loan','lend') NOT NULL,
  `party_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_note`
--

CREATE TABLE `delivery_note` (
  `Delivery_note_id` int NOT NULL,
  `delivery_number` int NOT NULL,
  `file` varchar(45) NOT NULL,
  `Customer_id` int NOT NULL,
  `Purchase_order_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `designation`
--

CREATE TABLE `designation` (
  `designation_id` int NOT NULL,
  `designation_name` varchar(60) CHARACTER SET utf8mb4 COLLATE  NOT NULL,
  `designation_detail` text,
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

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
  `dr_id` int NOT NULL,
  `designation_id` int NOT NULL,
  `role_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

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
  `Expenses_id` int NOT NULL,
  `date` datetime NOT NULL,
  `number_item` int NOT NULL,
  `description` varchar(150) NOT NULL,
  `amount` int NOT NULL,
  `purchased_by` int NOT NULL,
  `approved_by` int NOT NULL,
  `approval_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `Invoice_id` int NOT NULL,
  `date` datetime NOT NULL,
  `type` enum('profoma','tax') CHARACTER SET utf8mb4 COLLATE  NOT NULL,
  `ref_number` int NOT NULL,
  `amount` int NOT NULL,
  `expire_date` date NOT NULL,
  `Customer_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_item`
--

CREATE TABLE `invoice_item` (
  `Invoice_item_id` int NOT NULL,
  `offer_amount` int NOT NULL,
  `quantity` int NOT NULL,
  `Product_id` int NOT NULL,
  `Invoice_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `leave_application`
--

CREATE TABLE `leave_application` (
  `leave_application_id` int NOT NULL,
  `staff_id` int NOT NULL,
  `leave_description` varchar(150) CHARACTER SET utf8mb4 COLLATE  NOT NULL,
  `approval` varchar(10) NOT NULL,
  `remark` varchar(45) NOT NULL,
  `leave_start_date` datetime NOT NULL,
  `leave_end_date` datetime DEFAULT NULL,
  `response_date` datetime DEFAULT NULL,
  `application_date` datetime NOT NULL,
  `responsibility_asignee` int NOT NULL,
  `asignee_response_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `leave_schedule`
--

CREATE TABLE `leave_schedule` (
  `leave_schedule_id` int NOT NULL,
  `date` date NOT NULL,
  `staff_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `payroll`
--

CREATE TABLE `payroll` (
  `payroll_id` int NOT NULL,
  `staff_id` int NOT NULL,
  `month` int NOT NULL,
  `working_hours` datetime NOT NULL,
  `payment_amount` int NOT NULL,
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `permission_id` int NOT NULL,
  `permission_name` text NOT NULL,
  `legend` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`permission_id`, `permission_name`, `legend`) VALUES
(1, 'can_add_business_partner', 'Accounts'),
(2, 'can_edit_business_partner', 'Accounts'),
(3, 'can_delete_business_partner', 'Accounts'),
(4, 'can_view_business_partner', 'Accounts'),
(5, 'can_add_banks', 'Accounts'),
(6, 'can_edit_banks', 'Accounts'),
(7, 'can_delete_banks', 'Accounts'),
(8, 'can_view_banks', 'Accounts'),
(9, 'can_approve_banks', 'Accounts'),
(10, 'can_add_debts', 'Accounts'),
(11, 'can_edit_debts', 'Accounts'),
(12, 'can_delete_debts', 'Accounts'),
(13, 'can_view_debts', 'Accounts'),
(14, 'can_clear_debts', 'Accounts'),
(15, 'can_add_expenses', 'Accounts'),
(16, 'can_edit_expenses', 'Accounts'),
(17, 'can_delete_expenses', 'Accounts'),
(18, 'can_view_expenses', 'Accounts'),
(19, 'can_add_payroll', 'Accounts'),
(20, 'can_edit_payroll', 'Accounts'),
(21, 'can_delete_payroll', 'Accounts'),
(22, 'can_view_payroll', 'Accounts'),
(23, 'can_add_revenues', 'Accounts'),
(24, 'can_edit_revenues', 'Accounts'),
(25, 'can_delete_revenues', 'Accounts'),
(26, 'can_view_revenues', 'Accounts'),
(27, 'can_add_salary', 'Accounts'),
(28, 'can_edit_salary', 'Accounts'),
(29, 'can_delete_salary', 'Accounts'),
(30, 'can_view_salary', 'Accounts'),
(31, 'can_view_staff', 'HR'),
(32, 'can_add_designation', 'HR'),
(33, 'can_delete_designation', 'HR'),
(34, 'can_add_staff', 'HR'),
(35, 'can_edit_staff', 'HR'),
(36, 'can_delete_staff', 'HR'),
(37, 'can_add_leave', 'HR'),
(38, 'can_edit_leave', 'HR'),
(39, 'can_delete_leave', 'HR'),
(40, 'can_view_leave', 'HR'),
(41, 'can_approve_leave', 'HR'),
(42, 'can_add_contracts', 'HR'),
(43, 'can_edit_contracts', 'HR'),
(44, 'can_delete_contracts', 'HR'),
(45, 'can_view_contracts', 'HR'),
(46, 'can_add_staff', 'HR'),
(47, 'can_edit_staff', 'HR'),
(48, 'can_delete_staff', 'HR'),
(49, 'can_view_staff', 'HR'),
(50, 'can_add_leave', 'HR'),
(51, 'can_edit_leave', 'HR'),
(52, 'can_delete_leave', 'HR'),
(53, 'can_view_leave', 'HR'),
(54, 'can_approve_leave', 'HR'),
(55, 'can_add_contracts', 'HR'),
(56, 'can_edit_contracts', 'HR'),
(57, 'can_delete_contracts', 'HR'),
(58, 'can_view_contracts', 'HR'),
(59, 'can_add_designation', 'HR'),
(60, 'can_delete_designation', 'HR'),
(61, 'can_add_customers', 'Sales'),
(62, 'can_edit_customers', 'Sales'),
(63, 'can_delete_customers', 'Sales'),
(64, 'can_view_customers', 'Sales'),
(65, 'can_add_invoice', 'Sales'),
(66, 'can_edit_invoice', 'Sales'),
(67, 'can_delete_invoice', 'Sales'),
(68, 'can_view_invoice', 'Sales'),
(69, 'can_add_products', 'Sales'),
(70, 'can_edit_products', 'Sales'),
(71, 'can_delete_products', 'Sales'),
(72, 'can_view_products', 'Sales'),
(73, 'can_add_suppliers', 'Sales'),
(74, 'can_edit_suppliers', 'Sales'),
(75, 'can_delete_suppliers', 'Sales'),
(76, 'can_view_suppliers', 'Sales'),
(77, 'can_add_purchase_order', 'Sales'),
(78, 'can_edit_purchase_order', 'Sales'),
(79, 'can_delete_purchase_order', 'Sales'),
(80, 'can_view_purchase_order', 'Sales'),
(81, 'can_add_system_backup', 'Settings'),
(82, 'can_delete_system_backup', 'Settings'),
(83, 'can_view_system_backup', 'Settings'),
(84, 'can_edit_system_backup', 'Settings'),
(85, 'can_add_payment_gateway', 'Settings'),
(86, 'can_edit_payment_gateway', 'Settings'),
(87, 'can_delete_payment_gateway', 'Settings'),
(88, 'can_view_system_backup', 'Settings'),
(89, 'can_add_system_configuration', 'Settings'),
(90, 'can_edit_system_configuration', 'Settings'),
(91, 'can_delete_system_configuration', 'Settings'),
(92, 'can_add_products', 'Store'),
(93, 'can_edit_products', 'Store'),
(94, 'can_delete_products', 'Store'),
(95, 'can_view_products', 'Store'),
(96, 'can_add_tools', 'Store'),
(97, 'can_edit_tools', 'Store'),
(98, 'can_delete_tools', 'Store'),
(99, 'can_view_tools', 'Store'),
(100, 'can_add_stores', 'Store'),
(101, 'can_edit_stores', 'Store'),
(102, 'can_view_stores', 'Store'),
(103, 'can_add_projects', 'Projects'),
(104, 'can_edit_projects', 'Projects'),
(105, 'can_delete_projects', 'Projects'),
(106, 'can_view_projects', 'Projects'),
(107, 'can_add_activities', 'Projects'),
(108, 'can_edit_activities', 'Projects'),
(109, 'can_delete_activities', 'Projects'),
(110, 'can_add_resources', 'Projects'),
(111, 'can_edit_resources', 'Projects'),
(112, 'can_delete_resources', 'Projects'),
(113, 'can_add_project_report', 'Projects'),
(114, 'can_edit_project_report', 'Projects'),
(115, 'can_delete_project_report', 'Projects'),
(116, 'can_view_project_report', 'Projects');

-- --------------------------------------------------------

--
-- Table structure for table `petty_cash_expenses`
--

CREATE TABLE `petty_cash_expenses` (
  `Petty_cash_expenses_id` int NOT NULL,
  `date` date NOT NULL,
  `description` varchar(150) NOT NULL,
  `amount` int NOT NULL,
  `Expenses_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `Product_id` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(150) NOT NULL,
  `unit` int NOT NULL,
  `quantity` int NOT NULL,
  `buying_price` int NOT NULL,
  `selling_price` int NOT NULL,
  `Supplier_id` int NOT NULL,
  `Store_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `Project_id` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `starting_date` datetime NOT NULL,
  `ending_date` datetime NOT NULL,
  `description` varchar(150) NOT NULL,
  `burget` int NOT NULL,
  `Staff_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order`
--

CREATE TABLE `purchase_order` (
  `Purchase_order_id` int NOT NULL,
  `type` varchar(20) NOT NULL,
  `amount` int NOT NULL,
  `total` int NOT NULL,
  `Supplier_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `receipt`
--

CREATE TABLE `receipt` (
  `Receipt_id` int NOT NULL,
  `date` varchar(10) NOT NULL,
  `receipt_number` int NOT NULL,
  `Purchase_order_id` int NOT NULL,
  `Invoice_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `Report_id` int NOT NULL,
  `date` date NOT NULL,
  `details` varchar(20) NOT NULL,
  `Activities_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `request_id` int NOT NULL,
  `date` date NOT NULL,
  `description` varchar(150) NOT NULL,
  `requester_id` int NOT NULL,
  `approver_id` int NOT NULL,
  `approval` varchar(10) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `revenue`
--

CREATE TABLE `revenue` (
  `Revenue_id` int NOT NULL,
  `type` varchar(15) NOT NULL,
  `description` varchar(150) NOT NULL,
  `amount` int NOT NULL,
  `Receipt_id` int NOT NULL,
  `Debt_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

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
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

--
-- Dumping data for table `role_permission_list`
--

INSERT INTO `role_permission_list` (`role_id`, `permission_id`, `created_time`) VALUES
(1, 1, '2023-04-21 12:36:28'),
(1, 2, '2023-04-21 12:36:28'),
(1, 3, '2023-04-21 12:36:28'),
(1, 4, '2023-04-21 12:36:28'),
(1, 5, '2023-04-21 12:36:28'),
(1, 6, '2023-04-21 12:36:28'),
(1, 7, '2023-04-21 12:36:28'),
(1, 8, '2023-04-21 12:36:28'),
(1, 9, '2023-04-21 12:36:28'),
(1, 10, '2023-04-21 12:36:28'),
(1, 11, '2023-04-21 12:36:28'),
(1, 12, '2023-04-21 12:36:28'),
(1, 13, '2023-04-21 12:36:28'),
(1, 14, '2023-04-21 12:36:28'),
(1, 15, '2023-04-21 12:36:28'),
(1, 16, '2023-04-21 12:36:28'),
(1, 17, '2023-04-21 12:36:28'),
(1, 18, '2023-04-21 12:36:28'),
(1, 19, '2023-04-21 12:36:28'),
(1, 20, '2023-04-21 12:36:28'),
(1, 21, '2023-04-21 12:36:28'),
(1, 22, '2023-04-21 12:36:28'),
(1, 23, '2023-04-21 12:36:28'),
(1, 24, '2023-04-21 12:36:28'),
(1, 25, '2023-04-21 12:36:28'),
(1, 31, '2023-04-21 14:13:09');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `bank_id` varchar(30) CHARACTER SET utf8mb4 COLLATE  DEFAULT NULL,
  `bank_account_number` text,
  `registration_number` varchar(12) CHARACTER SET utf8mb4 COLLATE  NOT NULL,
  `residence_address` text NOT NULL,
  `designation` int NOT NULL,
  `user_reference` int NOT NULL,
  `date_employed` datetime NOT NULL,
  `employment_length` int NOT NULL,
  `employment_status` enum('active','terminated_by_office','ended','terminated_user') NOT NULL,
  `employment_last_renewal` datetime DEFAULT NULL,
  `employment_termination_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

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
  `Store_id` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `location` varchar(15) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `Supplier_id` int NOT NULL,
  `name` varchar(15) NOT NULL,
  `phone_number` int NOT NULL,
  `email` varchar(20) NOT NULL,
  `details` varchar(45) NOT NULL,
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `first_name` varchar(10) NOT NULL,
  `middle_name` varchar(30) NOT NULL,
  `last_name` varchar(20) CHARACTER SET utf8mb4 COLLATE  NOT NULL,
  `system_role` varchar(10) NOT NULL,
  `status` enum('active','inactive','deleted') CHARACTER SET utf8mb4 COLLATE  NOT NULL,
  `phone_number` bigint NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(32) NOT NULL,
  `activation_token` text,
  `created_by` char(20) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `first_name`, `middle_name`, `last_name`, `system_role`, `status`, `phone_number`, `email`, `password`, `activation_token`, `created_by`, `created_time`) VALUES
(1, 'Root', 'Coder', 'User', '2', 'active', 255713824487, 'wizdontz@gmail.com', '734fcec7bede8606e68a4969441882fb', NULL, '0', '2023-04-14 09:43:25'),
(2, 'Abie', 'Coder', 'Msitu', '2', 'active', 255757569016, 'abie@banny.co.tz', '734fcec7bede8606e68a4969441882fb', NULL, '1', '2023-04-14 09:43:25'),
(4, 'Jasper', 'Katunzi', 'Ashomile', '1', 'active', 255757569016, 'jasper@banny.co.tz', '734fcec7bede8606e68a4969441882fb', NULL, '1', '2023-04-18 19:09:08'),
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
  ADD PRIMARY KEY (`Store_id`);

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
  MODIFY `Activities_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `activities_resource`
--
ALTER TABLE `activities_resource`
  MODIFY `Activities_resource_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `bank_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `business_partiner`
--
ALTER TABLE `business_partiner`
  MODIFY `Business_partiner_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `Customer_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `debts`
--
ALTER TABLE `debts`
  MODIFY `debts_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_note`
--
ALTER TABLE `delivery_note`
  MODIFY `Delivery_note_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `designation`
--
ALTER TABLE `designation`
  MODIFY `designation_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `designation_role`
--
ALTER TABLE `designation_role`
  MODIFY `dr_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `Expenses_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `Invoice_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_item`
--
ALTER TABLE `invoice_item`
  MODIFY `Invoice_item_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leave_application`
--
ALTER TABLE `leave_application`
  MODIFY `leave_application_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leave_schedule`
--
ALTER TABLE `leave_schedule`
  MODIFY `leave_schedule_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll`
--
ALTER TABLE `payroll`
  MODIFY `payroll_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `permission_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `petty_cash_expenses`
--
ALTER TABLE `petty_cash_expenses`
  MODIFY `Petty_cash_expenses_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `Product_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `Project_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_order`
--
ALTER TABLE `purchase_order`
  MODIFY `Purchase_order_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `receipt`
--
ALTER TABLE `receipt`
  MODIFY `Receipt_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `Report_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `request_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `revenue`
--
ALTER TABLE `revenue`
  MODIFY `Revenue_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `store`
--
ALTER TABLE `store`
  MODIFY `Store_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `Supplier_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `contain` FOREIGN KEY (`Project_id`) REFERENCES `project` (`Project_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `activities_resource`
--
ALTER TABLE `activities_resource`
  ADD CONSTRAINT `activities_resource_ibfk_1` FOREIGN KEY (`Activity_id`) REFERENCES `activities` (`Activities_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `delivery_note`
--
ALTER TABLE `delivery_note`
  ADD CONSTRAINT `delivery_note_ibfk_1` FOREIGN KEY (`Customer_id`) REFERENCES `customer` (`Customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `delivery_note_ibfk_2` FOREIGN KEY (`Purchase_order_id`) REFERENCES `purchase_order` (`Purchase_order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`Customer_id`) REFERENCES `customer` (`Customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `invoice_item`
--
ALTER TABLE `invoice_item`
  ADD CONSTRAINT `invoice_item_ibfk_1` FOREIGN KEY (`Product_id`) REFERENCES `product` (`Product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `invoice_item_ibfk_2` FOREIGN KEY (`Invoice_id`) REFERENCES `invoice` (`Invoice_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `leave_application`
--
ALTER TABLE `leave_application`
  ADD CONSTRAINT `leave_application_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `leave_schedule`
--
ALTER TABLE `leave_schedule`
  ADD CONSTRAINT `leave_schedule_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `payroll`
--
ALTER TABLE `payroll`
  ADD CONSTRAINT `payroll_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `petty_cash_expenses`
--
ALTER TABLE `petty_cash_expenses`
  ADD CONSTRAINT `petty_cash_expenses_ibfk_1` FOREIGN KEY (`Expenses_id`) REFERENCES `expenses` (`Expenses_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`Store_id`) REFERENCES `store` (`Store_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `project_ibfk_1` FOREIGN KEY (`Staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `purchase_order`
--
ALTER TABLE `purchase_order`
  ADD CONSTRAINT `purchase_order_ibfk_1` FOREIGN KEY (`Supplier_id`) REFERENCES `supplier` (`Supplier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `receipt`
--
ALTER TABLE `receipt`
  ADD CONSTRAINT `receipt_ibfk_1` FOREIGN KEY (`Purchase_order_id`) REFERENCES `purchase_order` (`Purchase_order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `receipt_ibfk_2` FOREIGN KEY (`Invoice_id`) REFERENCES `invoice` (`Invoice_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `revenue`
--
ALTER TABLE `revenue`
  ADD CONSTRAINT `revenue_ibfk_1` FOREIGN KEY (`Receipt_id`) REFERENCES `receipt` (`Receipt_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `revenue_ibfk_2` FOREIGN KEY (`Debt_id`) REFERENCES `debts` (`debts_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `role_permission_list`
--
ALTER TABLE `role_permission_list`
  ADD CONSTRAINT `role_permission_list_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `role_permission_list_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
