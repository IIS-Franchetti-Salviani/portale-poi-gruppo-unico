<?php
header('Content-Type: application/json');

$host = "localhost";
$user = "root";
$password = "";
$database = "db_edicole_votive_5c";

// Connessione DB
$conn = new mysqli($host, $user, $password, $database);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(['errore' => 'Connessione al database fallita: ' . $conn->connect_error]);
    exit;
}

// Metodo HTTP
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    // GET con parametro ?codice=...
    if (!isset($_GET['codice'])) {
        http_response_code(400);
        echo json_encode(['errore' => 'Parametro "codice" mancante.']);
        exit;
    }

    $codice = intval($_GET['codice']);
    $stmt = $conn->prepare("SELECT * FROM indicazioni WHERE ind_id = ?");
    $stmt->bind_param("i", $codice);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        echo json_encode($result->fetch_assoc());
    } else {
        http_response_code(404);
        echo json_encode(['errore' => 'Indicazione non trovata.']);
    }

    $stmt->close();

} elseif ($method === 'POST') {
    // POST per inserimento
    $input = json_decode(file_get_contents("php://input"), true);

    if (!isset($input['ind_id'], $input['ind_timestamp'], $input['ind_testo'])) {
        http_response_code(400);
        echo json_encode(['errore' => 'Campi richiesti: ind_id, ind_timestamp, ind_testo']);
        exit;
    }

    $ind_id = intval($input['ind_id']);
    $ind_timestamp = $input['ind_timestamp'];
    $ind_testo = $input['ind_testo'];
    $ind_per_iti_id = isset($input['ind_per_iti_id']) ? intval($input['ind_per_iti_id']) : null;
    $ind_per_gru_id = isset($input['ind_per_gru_id']) ? intval($input['ind_per_gru_id']) : null;

    $stmt = $conn->prepare("INSERT INTO indicazioni (ind_id, ind_timestamp, ind_testo, ind_per_iti_id, ind_per_gru_id)
                            VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("issii", $ind_id, $ind_timestamp, $ind_testo, $ind_per_iti_id, $ind_per_gru_id);

    if ($stmt->execute()) {
        http_response_code(201);
        echo json_encode(['successo' => 'Indicazione inserita con successo.']);
    } else {
        http_response_code(500);
        echo json_encode(['errore' => 'Errore durante l\'inserimento: ' . $stmt->error]);
    }

    $stmt->close();

} else {
    // Metodo non supportato
    http_response_code(405);
    echo json_encode(['errore' => 'Metodo HTTP non supportato.']);
}

$conn->close();
?>
