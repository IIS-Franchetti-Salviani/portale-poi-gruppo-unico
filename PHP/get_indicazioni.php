<?php
// Header per output JSON
header("Content-Type: application/json");

// Connessione al database
$host = 'localhost';
$user = 'root';        // Sostituisci con il tuo utente
$password = '';       // Sostituisci con la tua password
$database = 'prova';  // Sostituisci con il tuo database

$conn = new mysqli($host, $user, $password, $database);

// Verifica connessione
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["errore" => "Connessione fallita: " . $conn->connect_error]);
    exit;
}

// Base URL per i link HATEOAS
$baseUrl = "http://" . $_SERVER['HTTP_HOST'] . dirname($_SERVER['PHP_SELF']);

// Query per i dati della tabella indicazioni
$sql = "SELECT ind_id, ind_timestamp, ind_testo, ind_per_iti_id, ind_per_gru_id FROM indicazioni";
$result = $conn->query($sql);

$indicazioni = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        // Aggiunge link alle risorse correlate
        $row["_links"] = [
            "itinerario" => [
                "href" => "$baseUrl/get_itinerario.php?id={$row['ind_per_iti_id']}"
            ],
            "gruppo" => [
                "href" => "$baseUrl/get_gruppo.php?id={$row['ind_per_gru_id']}"
            ]
        ];

        $indicazioni[] = $row;
    }

    echo json_encode($indicazioni, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
} else {
    echo json_encode([], JSON_PRETTY_PRINT);
}

$conn->close();
?>
