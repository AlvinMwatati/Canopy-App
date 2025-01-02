<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

require_once 'connection.php';

// Initialize the response array
$response = [
    'success' => false, // Default to failure
    'message' => 'Failed to load tools',
    'tools' => [] // Tools array to be populated
];

// Fetch tools from the database
$sql = "SELECT * FROM tools"; // Modify based on your table structure
$res = mysqli_query($con, $sql);

if ($res && mysqli_num_rows($res) > 0) {
    $tools = [];
    while ($row = mysqli_fetch_assoc($res)) {
        $tools[] = $row;
    }
    $response['success'] = true;
    $response['message'] = 'Successfully loaded tools';
    $response['tools'] = $tools;
} else {
    $response['message'] = 'No tools found';
}

// Close the database connection
mysqli_close($con);

// Output the response as JSON
echo json_encode($response);
?>
