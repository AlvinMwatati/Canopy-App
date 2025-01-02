<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

require_once 'connection.php';

// Retrieve input data
$email = $_GET['email'] ?? null;
$Uname = $_GET['Uname'] ?? null;
$password = $_GET['password'] ?? null;

$response = [
    'code' => 0,
    'message' => 'Invalid email/username or password.'
];

// Validate inputs
if (($email || $Uname) && $password) {
    // Use prepared statement to prevent SQL injection
    $stmt = $con->prepare("SELECT * FROM registration WHERE (Email = ? OR Uname = ?) AND Password = ?");
    $stmt->bind_param("sss", $email, $Uname, $password);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        $response['code'] = 1;
        $response['message'] = 'Login successful.';
        $response['userdetails'] = $user;
    }
    $stmt->close();
} else {
    $response['message'] = 'Missing email/username or password.';
}

// Return response as JSON
echo json_encode($response);

// Close database connection
$con->close();
?>
