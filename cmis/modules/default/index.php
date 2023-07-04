<?php 

    $activity = "SELECT COUNT(activity_id) FROM activities WHERE activity_status = 'pending'";
    $activity = $db->query($activity);
    $activityCount = $activity->fetchColumn();
    
    $leave = "SELECT COUNT(leave_application_id) FROM leave_application WHERE leave_application_status = 'pending'";
    $leave = $db->query($leave);
    $leaveCount = $leave->fetchColumn();

    $staff = "SELECT COUNT(staff_id) FROM staff";
    $staff = $db->query($staff);
    $staffCount = $staff->fetchColumn();

    $customers = "SELECT COUNT(customer_id) FROM customer";
    $customers = $db->query($customers);
    $customerCount = $customers->fetchColumn();

    $project = "SELECT COUNT(project_id) FROM project";
    $project = $db->query($project);
    $projectCount = $project->fetchColumn();

    // $expenses = $db->select('expenses','SUM(expenses_amount) AS expenses_amount, expenses_date')
    //                 ->group_by('expenses_date')
    //                 ->order_by('expenses_date', 'desc')
    //                 ->fetchAll();
    // $expensesSum = 0;
    // $expensesAmount = [];
    // $expensesDate = [];
    // foreach($expenses as $expense) {
    //     $expensesSum += $expense['expenses_amount'];
    //     array_push($expensesAmount, $expense['expenses_amount']);
    //     $bad_date = DateTime::createFromFormat('Y-m-d H:i:s e', $expense['expenses_date'].' EDT');
    //     $nice_date = $bad_date->format('Y M j');
    //     array_push($expensesDate, $nice_date);
    // }

    // $apartments = $db->select('apartment_category','category_name, COUNT(apartment_id) as apartCount')
    //             ->join('apartments','apartments.apartment_category=apartment_category.category_id')
    //             ->group_by('category_id')
    //             ->order_by('category_id','asc')
    //             ->fetchAll();
    $invoice = $db->select('invoice','SUM(invoice_amount) as invoiceSum')
                ->where(['invoice_type'=>'tax'])
                // ->join('orders','orders.apartment_category=apartment_category.category_id', 'left')
                // ->group_by('apartment_category.category_id')
                // ->order_by('category_id','asc')
                ->fetchAll();
    // $revenueSum = 0;
    // $aparCategories = [];
    // $occupiedApartments = [];
    // $freeApartments = [];
    // foreach($orders as $key => $order) {
    //     $revenueSum += $order['ordersSum'];
    //     array_push($aparCategories, $order['category_name']);
    //     if($apartments[$key]['apartCount'] < $order['ordersCount']) {
    //         array_push($freeApartments, 0);
    //     }else {
    //         array_push($freeApartments, $apartments[$key]['apartCount'] - $order['ordersCount']);
    //     }
    //     array_push($occupiedApartments, $order['ordersCount']);
    // }

    $data = [
        'activityCount' => $activityCount, 
        'staffCount' => $staffCount, 
        'customerCount' => $customerCount,
        'projectCount' => $projectCount,
        'leaveCount' => $leaveCount,
        // 'expensesSum' => $expensesSum,
        'revenueSum' => $invoice,
        // 'expensesAmount' => json_encode($expensesAmount),
        // 'expensesDate' => json_encode($expensesDate),
        // 'aparCategories' => json_encode($aparCategories), 
        // 'occupiedApartments' => json_encode($occupiedApartments),
        // 'freeApartments' => json_encode($freeApartments),
        'currency'=>$storage->system_config->system_currency
    ];
echo helper::find_template('home', $data);