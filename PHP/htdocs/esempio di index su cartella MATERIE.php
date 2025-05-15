<?php
$host = 'localhost';
$user = 'root';
$password = '';
$dbname = 'scuola';
$conn = new mysqli($host, $user, $password, $dbname);
if ($conn->connect_error) {
    die("Connessione fallita: " . $conn->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $materie = [];

    if (isset($_GET['materiaId'])) {
        $materiaId = $conn->real_escape_string($_GET['materiaId']);
        $sql = "SELECT * FROM Materia WHERE Codice = '$materiaId'";
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $disciplina = [];
            $resDisc = $conn->query("SELECT * FROM Disciplina WHERE Codice = '" . $row["CodiceDisciplina"] . "'");
            if ($resDisc->num_rows > 0) {
                $discRow = $resDisc->fetch_assoc();
                $disciplina = [
                    "denominazione" => $discRow["Denominazione"],
                    "anno" => $discRow["Anno"],
                    "isPartial" => true,
                    "link" => "http://localhost/discipline/" . $discRow["Codice"]
                ];
            }

            $insegnamenti = [];
            $resIns = $conn->query("SELECT * FROM Insegnamento WHERE CodiceMateria = '$materiaId'");
            while ($i = $resIns->fetch_assoc()) {
                $insegnamenti[] = [
                    "annoScolastico" => $i["AnnoScolastico"],
                    "isPartial" => true,
                    "link" => "http://localhost/insegnamenti/{$i["CodiceDocente"]}/{$i["CodiceMateria"]}/{$i["CodiceClasse"]}/{$i["AnnoScolastico"]}"
                ];
            }

            $materia = [
                "denominazione" => $row["Denominazione"],
                "disciplina" => $disciplina,
                "insegnamenti" => $insegnamenti,
                "link" => "http://localhost/materie/" . $row["Codice"]
            ];

            header('Content-Type: application/json');
            echo json_encode($materia, JSON_PRETTY_PRINT);
        } else {
            http_response_code(404);
            echo json_encode(["errore" => "Materia non trovata"]);
        }
    } else {
        $sql = "SELECT * FROM Materia";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $disciplina = [];
                $resDisc = $conn->query("SELECT * FROM Disciplina WHERE Codice = '" . $row["CodiceDisciplina"] . "'");
                if ($resDisc->num_rows > 0) {
                    $discRow = $resDisc->fetch_assoc();
                    $disciplina = [
                        "denominazione" => $discRow["Denominazione"],
                        "anno" => $discRow["Anno"],
                        "isPartial" => true,
                        "link" => "http://localhost/discipline/" . $discRow["Codice"]
                    ];
                }

                $insegnamenti = [];
                $resIns = $conn->query("SELECT * FROM Insegnamento WHERE CodiceMateria = '" . $row["Codice"] . "'");
                while ($i = $resIns->fetch_assoc()) {
                    $insegnamenti[] = [
                        "annoScolastico" => $i["AnnoScolastico"],
                        "isPartial" => true,
                        "link" => "http://localhost/insegnamenti/{$i["CodiceDocente"]}/{$i["CodiceMateria"]}/{$i["CodiceClasse"]}/{$i["AnnoScolastico"]}"
                    ];
                }

                $materie[] = [
                    "denominazione" => $row["Denominazione"],
                    "disciplina" => $disciplina,
                    "insegnamenti" => $insegnamenti,
                    "link" => "http://localhost/materie/" . $row["Codice"]
                ];
            }
        }

        header('Content-Type: application/json');
        echo json_encode($materie, JSON_PRETTY_PRINT);
    }
}

elseif ($method === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $denom = $conn->real_escape_string($data['denominazione']);
    $disciplina = $conn->real_escape_string($data['codiceDisciplina']);

    $res = $conn->query("SELECT Codice FROM Materia ORDER BY Codice DESC LIMIT 1");
    $last = $res->fetch_assoc()["Codice"];
    $num = intval(substr($last, 1)) + 1;
    $newCod = "M" . str_pad($num, 3, "0", STR_PAD_LEFT);

    $sql = "INSERT INTO Materia (Codice, Denominazione, CodiceDisciplina)
            VALUES ('$newCod', '$denom', '$disciplina')";
    if ($conn->query($sql)) {
        http_response_code(201);
        echo json_encode(["link" => "http://localhost/materie/$newCod"]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => $conn->error]);
    }
}

elseif ($method === 'PUT') {
    if (!isset($_GET['materiaId'])) {
        http_response_code(400);
        echo json_encode(["errore" => "Parametro materiaId mancante"]);
        exit;
    }

    $materiaId = $conn->real_escape_string($_GET['materiaId']);
    $data = json_decode(file_get_contents("php://input"), true);

    $denom = $conn->real_escape_string($data['denominazione']);
    $disciplina = $conn->real_escape_string($data['codiceDisciplina']);

    $sql = "UPDATE Materia
            SET Denominazione = '$denom', CodiceDisciplina = '$disciplina'
            WHERE Codice = '$materiaId'";
    if ($conn->query($sql)) {
        http_response_code(200);
        echo json_encode(["messaggio" => "Materia aggiornata", "link" => "http://localhost/materie/$materiaId"]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => $conn->error]);
    }
}

elseif ($method === 'DELETE') {
    if (!isset($_GET['materiaId'])) {
        http_response_code(400);
        echo json_encode(["errore" => "Parametro materiaId mancante"]);
        exit;
    }

    $materiaId = $conn->real_escape_string($_GET['materiaId']);

    // Prima verifica se esiste
    $check = $conn->query("SELECT Codice FROM Materia WHERE Codice = '$materiaId'");
    if ($check->num_rows === 0) {
        http_response_code(404);
        echo json_encode(["errore" => "Materia non trovata"]);
        exit;
    }

    // Elimina
    $sql = "DELETE FROM Materia WHERE Codice = '$materiaId'";
    if ($conn->query($sql)) {
        http_response_code(204); // No content
    } else {
        http_response_code(500);
        echo json_encode(["error" => $conn->error]);
    }
}

$conn->close();
?>
