-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 14, 2023 at 12:36 PM
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
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `bank_id` int NOT NULL,
  `bank_name` text NOT NULL,
  `bank_logo` text NOT NULL
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `designation`
--

CREATE TABLE `designation` (
  `designation_id` int NOT NULL,
  `designation_name` text NOT NULL,
  `designation_detail` text NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `Invoice_id` int NOT NULL,
  `date` datetime NOT NULL,
  `type` enum('profoma','tax') NOT NULL,
  `ref_number` int NOT NULL,
  `amount` int NOT NULL,
  `expire_date` date NOT NULL,
  `Customer_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `leave_application`
--

CREATE TABLE `leave_application` (
  `leave_application_id` int NOT NULL,
  `staff_id` int NOT NULL,
  `description` varchar(150) NOT NULL,
  `approval` varchar(10) NOT NULL,
  `remark` varchar(45) NOT NULL,
  `application_date` datetime NOT NULL,
  `response_date` datetime DEFAULT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `leave_schedule`
--

CREATE TABLE `leave_schedule` (
  `leave_schedule_id` int NOT NULL,
  `date` date NOT NULL,
  `staff_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `permission_id` int NOT NULL,
  `permission_name` text NOT NULL,
  `legend` text NOT NULL
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `role_permission_list`
--

CREATE TABLE `role_permission_list` (
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `bank_id` varchar(30) DEFAULT NULL,
  `bank_account_number` text,
  `registration_number` varchar(12) NOT NULL,
  `residence_address` text NOT NULL,
  `designation` int NOT NULL,
  `user_reference` int NOT NULL,
  `date_employed` datetime NOT NULL,
  `employment_length` int NOT NULL,
  `employment_status` enum('active','terminated_by_office','ended','terminated_user') NOT NULL,
  `employment_last_renewal` datetime DEFAULT NULL,
  `employment_termination_date` datetime DEFAULT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `Store_id` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `location` varchar(15) NOT NULL,
  `Staff_id` int NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB;

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
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `first_name` varchar(10) NOT NULL,
  `middle_name` varchar(30) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `system_role` varchar(10) NOT NULL,
  `status` enum('activate','inactivate','delete') NOT NULL,
  `phone_number` bigint NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(32) NOT NULL,
  `created_by` char(20) NOT NULL,
  `created_time` datetime NOT NULL
) ENGINE=InnoDB;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `first_name`, `middle_name`, `last_name`, `system_role`, `status`, `phone_number`, `email`, `password`, `created_by`, `created_time`) VALUES
(1, 'Abie', 'Coder', 'Msitu', '2', 'activate', 255719203040, 'abie@banny.co.tz', 'bb6e6099865758b6a7760c445f03d5af', '0', '2023-04-14 09:43:25');

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
  ADD PRIMARY KEY (`designation_id`);

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
  ADD PRIMARY KEY (`staff_id`);

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
  MODIFY `designation_id` int NOT NULL AUTO_INCREMENT;

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
  MODIFY `permission_id` int NOT NULL AUTO_INCREMENT;

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
  MODIFY `role_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int NOT NULL AUTO_INCREMENT;

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
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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

--
-- Constraints for table `store`
--
ALTER TABLE `store`
  ADD CONSTRAINT `store_ibfk_1` FOREIGN KEY (`Staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
