<?php
include_once ('../../db/db.php');

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $poi = [];

    if (isset($_GET['poiId'])) {
        // Get singolo POI
        $poiId = $conn->real_escape_string($_GET['poiId']);
        $sql = "SELECT * FROM Poi WHERE Id = '$poiId'";
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $poi = [
                "id" => $row["Id"],
                "denominazione" => $row["Denominazione"],
                "descrizione" => $row["Descrizione"],
                "link" => "http://localhost/project-root/api/poi/index.php?poiId=" . $row["Id"]
            ];

            header('Content-Type: application/json');
            echo json_encode($poi, JSON_PRETTY_PRINT);
        } else {
            http_response_code(404);
            echo json_encode(["errore" => "POI non trovato"]);
        }
    } else {
        // Get tutti i POI
        $sql = "SELECT * FROM Poi";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $poi[] = [
                    "id" => $row["poi_id"],
                    "denominazione" => $row["poi_nome"],
                    "descrizione" => $row["poi_desc"],
					"longitudine" => $row["poi_longitudine"],
					"latitudine" => $row["poi_latitudine"],
					"indirizzo" => $row["poi_indirizzo"],
                    "link" => "http://localhost/project-root/api/poi/index.php?poiId=" . $row["poi_id"]
                ];
            }

            header('Content-Type: application/json');
            echo json_encode($poi, JSON_PRETTY_PRINT);
        } else {
            http_response_code(404);
            echo json_encode(["errore" => "Nessun POI trovato"]);
        }
    }
}

elseif ($method === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $denom = $conn->real_escape_string($data['denominazione']);
    $descrizione = $conn->real_escape_string($data['descrizione']);

    $sql = "INSERT INTO Poi (Denominazione, Descrizione) VALUES ('$denom', '$descrizione')";
    if ($conn->query($sql)) {
        $lastId = $conn->insert_id;
        http_response_code(201);
        echo json_encode(["link" => "http://localhost/project-root/api/poi/index.php?poiId=$lastId"]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => $conn->error]);
    }
}

elseif ($method === 'PUT') {
    if (!isset($_GET['poiId'])) {
        http_response_code(400);
        echo json_encode(["errore" => "Parametro poiId mancante"]);
        exit;
    }

    $poiId = $conn->real_escape_string($_GET['poiId']);
    $data = json_decode(file_get_contents("php://input"), true);

    $denom = $conn->real_escape_string($data['denominazione']);
    $descrizione = $conn->real_escape_string($data['descrizione']);

    $sql = "UPDATE Poi SET Denominazione = '$denom', Descrizione = '$descrizione' WHERE Id = '$poiId'";
    if ($conn->query($sql)) {
        http_response_code(200);
        echo json_encode(["messaggio" => "POI aggiornato", "link" => "http://localhost/project-root/api/poi/index.php?poiId=$poiId"]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => $conn->error]);
    }
}

elseif ($method === 'DELETE') {
    if (!isset($_GET['poiId'])) {
        http_response_code(400);
        echo json_encode(["errore" => "Parametro poiId mancante"]);
        exit;
    }

    $poiId = $conn->real_escape_string($_GET['poiId']);

    // Verifica se esiste
    $check = $conn->query("SELECT Id FROM Poi WHERE Id = '$poiId'");
    if ($check->num_rows === 0) {
        http_response_code(404);
        echo json_encode(["errore" => "POI non trovato"]);
        exit;
    }

    // Elimina
    $sql = "DELETE FROM Poi WHERE Id = '$poiId'";
    if ($conn->query($sql)) {
        http_response_code(204); // No content
    } else {
        http_response_code(500);
        echo json_encode(["error" => $conn->error]);
    }
}

$conn->close();
?>
