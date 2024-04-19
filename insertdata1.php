<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "flutterelc";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname,3306);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
// Check if all required fields are present in the request
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['username'], $_POST['password'])) {
    // Include your database connection code here
    
    // Escape user inputs for security
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
   
    // SQL query to insert data into the database
    $query = "INSERT INTO record (username, password) VALUES ('$username', '$password')";

    // Execute the query
    $results = mysqli_query($conn, $query);

    // Check if the query was successful
    if ($results) {
        echo "User added successfully";
    } else {
        echo "Error: " . mysqli_error($conn);
    }
} else {
    // If any required field is missing, generate an error message
    echo "Error: Required fields are missing in the request";
}
?>


