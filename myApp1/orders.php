<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require 'connection.php';

// Retrieve POST data
$product_id = $_GET["product_id"];   // Correct variable name for product_id
$amount = $_GET["amount"];            // Correct variable name for amount
$user_email = $_GET["user_email"];          // Correct variable name for user_id

// Initialize the response flag
$flag = ['success' => 0];  // Default response to failure

// Validate inputs
if (empty($product_id) || empty($amount) || empty($user_email)) {
    $flag['error'] = 'Missing required fields';
} else {
    // Generate a unique order ID (for example, ORD- followed by an increment)
    $order_id = uniqid('ORD-');  // Unique order ID

    // SQL query to insert the order into the database
    $query = "INSERT INTO orders (order_id, product_id, amount, user_email, created_at) 
              VALUES ('$order_id', '$product_id', '$amount', '$user_email', NOW())";
    
    // Execute the query
    if (mysqli_query($con, $query)) {
        $flag['success'] = 1;  // If successful, return success
    } else {
        $flag['error'] = 'Failed to create order: ' . mysqli_error($con);
    }
}

// Return the response as JSON
echo json_encode($flag);

// Close the database connection
mysqli_close($con);
?>
