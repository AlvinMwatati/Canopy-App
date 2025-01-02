<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");
require 'connection.php';

$order_id = $_GET['order_id'];

$response = array();

if (empty($order_id)) {
    $response['success'] = 0;
    $response['message'] = "Order ID is required.";
} else {
    $query = "DELETE FROM orders WHERE order_id = '$order_id'";
    if (mysqli_query($con, $query)) {
        $response['success'] = 1;
        $response['message'] = "Order deleted successfully!";
    } else {
        $response['success'] = 0;
        $response['message'] = "Failed to delete order.";
    }
}

echo json_encode($response);
mysqli_close($con);
?>
