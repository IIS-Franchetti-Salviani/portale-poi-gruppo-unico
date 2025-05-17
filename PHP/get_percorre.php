<?php
// Imposta l'header per restituire JSON
header("Content-Type: application/json");

// Parametri di connessione al database
$host = 'localhost';
$user = 'root';
$password = '';
$database = 'prova';

// Connessione al database
$conn = new mysqli($host, $user, $password, $database);

// Verifica connessione
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["errore" => "Connessione fallita: " . $conn->connect_error]);
    exit;
}

// URL base per costruire i link HATEOAS
$baseUrl = "http://" . $_SERVER['HTTP_HOST'] . dirname($_SERVER['PHP_SELF']);

// Query principale
$sql = "SELECT per_iti_id, per_gru_id, per_data_partenza FROM percorre";
$result = $conn->query($sql);

$percorre = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        // Link alle risorse collegate
        $row["_links"] = [
            "itinerario" => [
                "href" => "$baseUrl/get_itinerario.php?id={$row['per_iti_id']}"
            ],
            "gruppo" => [
                "href" => "$baseUrl/get_gruppo.php?id={$row['per_gru_id']}"
            ]
        ];

        $percorre[] = $row;
    }

    echo json_encode($percorre, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
} else {
    echo json_encode([], JSON_PRETTY_PRINT);
}

$conn->close();
?>
