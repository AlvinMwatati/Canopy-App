<?php
require 'connection.php';

// Debugging to check input
if (isset($_GET["loginInput"]) && isset($_GET["Password"])) {
    $loginInput = $_GET["loginInput"];
    $Password = $_GET["Password"];
    $hashedPassword=password_hash($Password, PASSWORD_DEFAULT)

    $flag = ['success' => 0, 'message' => ''];

    // Prepared statement
    if ($stmt = $con->prepare("SELECT Password FROM registration WHERE Uname = ? OR Email = ?")) {
        $stmt->bind_param("ss", $loginInput, $loginInput);
        $stmt->execute();
        $stmt->store_result();

        if ($stmt->num_rows > 0) {
            $stmt->bind_result($hashedPassword);
            $stmt->fetch();

            if (password_verify($Password, $hashedPassword)) {
                $flag['success'] = 1;
                $flag['message'] = "Login successful!";
            } else {
                $flag['message'] = "Invalid password.";
            }
        } else {
            $flag['message'] = "User not found.";
        }
        $stmt->close();
    } else {
        $flag['message'] = "Error preparing statement: " . $con->error;
    }

    echo json_encode($flag);
} else {
    echo json_encode([
        'success' => 0,
        'message' => 'Required fields are missing.'
    ]);
}

$con->close();
?>
