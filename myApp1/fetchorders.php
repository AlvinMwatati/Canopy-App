<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

require 'connection.php';

$user_email = $_GET['user_email'];
$response = array();

$query = "SELECT * FROM orders WHERE user_email = '$user_email'";
$result = mysqli_query($con, $query);

if (mysqli_num_rows($result) > 0) {
    $response['success'] = 1;
    $response['orders'] = array();

    while ($row = mysqli_fetch_assoc($result)) {
        $order = array();
        $order['order_id'] = $row['order_id'];
        $order['product_id'] = $row['product_id'];
        $order['amount'] = $row['amount'];
        $order['created_at'] = $row['created_at'];
        array_push($response['orders'], $order);
    }
} else {
    $response['success'] = 0;
    $response['message'] = "No orders found.";
}

echo json_encode($response);
mysqli_close($con);
?>
