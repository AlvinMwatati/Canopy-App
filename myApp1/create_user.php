<?php
require_once 'connection.php';

// Retrieve input data
$Fname = $_GET["Fname"];
$Uname = $_GET["Uname"];
$Email = $_GET["Email"];
$Phone = $_GET["Phone"];
$Password = $_GET["Password"];

// Hash the password securely
$hashedPassword = password_hash($Password, PASSWORD_DEFAULT);

// Response array
$response = ['success' => 0, 'message' => 'Failed to register user.'];

// Insert into database
if ($stmt = $con->prepare("INSERT INTO registration (Fname, Uname, Email, Phone, Password) VALUES (?, ?, ?, ?, ?)")) {
    $stmt->bind_param("sssss", $Fname, $Uname, $Email, $Phone, $hashedPassword);

    if ($stmt->execute()) {
        $response['success'] = 1;
        $response['message'] = 'User registered successfully.';
    } else {
        $response['message'] = 'Error: ' . $stmt->error;
    }

    $stmt->close();
} else {
    $response['message'] = 'Error preparing statement: ' . $con->error;
}

// Return JSON response
echo json_encode($response);

// Close connection
$con->close();
?>
