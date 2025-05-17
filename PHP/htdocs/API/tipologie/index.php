<?php
include_once ('../../db/db.php');  // Includiamo la connessione al DB

$method = $_SERVER['REQUEST_METHOD'];  // Otteniamo il metodo HTTP

// Metodo GET
if ($method === 'GET') {
    $tipologie = [];

    // Se l'ID della tipologia è passato tramite parametro GET
    if (isset($_GET['tip_id'])) {
        $tipologiaId = $conn->real_escape_string($_GET['tip_id']);
        $sql = "SELECT * FROM Tipologie WHERE tip_id = '$tipologiaId'";
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $tipologia = [
                "codice" => $row["tip_id"],
                "denominazione" => $row["tip_desc"],
                "link" => "http://localhost/project-root/api/tipologie/index.php?tipologiaId=" . $row["tip_id"]
            ];

            header('Content-Type: application/json');
            echo json_encode($tipologia, JSON_PRETTY_PRINT);
        } else {
            http_response_code(404);
            echo json_encode(["errore" => "Tipologia non trovata"]);
        }
    } else {
        // Se non viene passato l'ID, restituiamo tutte le tipologie
        $sql = "SELECT * FROM Tipologia";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $tipologie[] = [
                    "codice" => $row["tip_id"],
                    "denominazione" => $row["tip_desc"],
                    "link" => "http://localhost/project-root/api/tipologie/index.php?tipologiaId=" . $row["tip_id"]
                ];
            }

            header('Content-Type: application/json');
            echo json_encode($tipologie, JSON_PRETTY_PRINT);
        } else {
            http_response_code(404);
            echo json_encode(["errore" => "Nessuna tipologia trovata"]);
        }
    }
}

// Metodo POST (per creare una nuova tipologia)
elseif ($method === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);  // Otteniamo i dati inviati tramite JSON
    $denom = $conn->real_escape_string($data['tip_desc']);  // Sicurezza (evitiamo SQL injection)

    // Generiamo un nuovo codice per la tipologia (es. T001, T002, ...)
    $res = $conn->query("SELECT tip_id FROM Tipologie ORDER BY tip_id DESC LIMIT 1");
    $last = $res->fetch_assoc()["tip_id"];
    $num = intval(substr($last, 1)) + 1;
    $newCod = "T" . str_pad($num, 3, "0", STR_PAD_LEFT);

    $sql = "INSERT INTO Tipologia (tip_id, Denominazione) VALUES ('$newCod', '$denom')";
    if ($conn->query($sql)) {
        $lastId = $conn->insert_id;
        http_response_code(201);  // Creazione avvenuta con successo
        echo json_encode(["link" => "http://localhost/project-root/api/tipologie/index.php?tipologiaId=$newCod"]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => $conn->error]);
    }
}

// Metodo PUT (per aggiornare una tipologia esistente)
elseif ($method === 'PUT') {
    if (!isset($_GET['tip_id'])) {
        http_response_code(400);
        echo json_encode(["errore" => "Parametro tipologiaId mancante"]);
        exit;
    }

    $tipologiaId = $conn->real_escape_string($_GET['tipologiaId']);  // Otteniamo l'ID della tipologia
    $data = json_decode(file_get_contents("php://input"), true);  // Dati inviati con la richiesta PUT

    $denom = $conn->real_escape_string($data['tip_desc']);

    $sql = "UPDATE Tipologie SET tip_desc = '$denom' WHERE tip_id = '$tipologiaId'";
    if ($conn->query($sql)) {
        http_response_code(200);  // Aggiornamento riuscito
        echo json_encode(["messaggio" => "Tipologia aggiornata", "link" => "http://localhost/project-root/api/tipologie/index.php?tipologiaId=$tipologiaId"]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => $conn->error]);
    }
}

// Metodo DELETE (per eliminare una tipologia)
elseif ($method === 'DELETE') {
    if (!isset($_GET['tip_id'])) {
        http_response_code(400);
        echo json_encode(["errore" => "Parametro tipologiaId mancante"]);
        exit;
    }

    $tipologiaId = $conn->real_escape_string($_GET['tipologiaId']);  // Otteniamo l'ID della tipologia da eliminare

    // Verifica se la tipologia esiste
    $check = $conn->query("SELECT Codice FROM Tipologia WHERE tip_id = '$tipologiaId'");
    if ($check->num_rows === 0) {
        http_response_code(404);
        echo json_encode(["errore" => "Tipologia non trovata"]);
        exit;
    }

    // Procediamo con l'eliminazione
    $sql = "DELETE FROM Tipologia WHERE tip_id = '$tipologiaId'";
    if ($conn->query($sql)) {
        http_response_code(204);  // Eliminazione riuscita (No content)
    } else {
        http_response_code(500);
        echo json_encode(["error" => $conn->error]);
    }
}

$conn->close();  // Chiudiamo la connessione al database
?>
