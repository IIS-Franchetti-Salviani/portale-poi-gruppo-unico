<?php
$host = 'localhost';
$user = 'root';
$password = '';
$dbname = 'db_edicole_votive_5c';

$conn = new mysqli($host, $user, $password, $dbname);
if ($conn->connect_error) {
    die("Connessione fallita: " . $conn->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    header('Content-Type: application/json');

    // Se viene passato un parametro poi_id, restituisci solo quel POI
    if (isset($_GET['poi_id'])) {
        $id = $conn->real_escape_string($_GET['poi_id']);
        $sql = "SELECT * FROM poi WHERE poi_id = '$id'";
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            $poi = $result->fetch_assoc();

            // Recupera descrizione tipologia
            $tipologia = [];
            $resTip = $conn->query("SELECT * FROM tipologie WHERE tip_id = '" . $poi["poi_tip_id"] . "'");
            if ($resTip->num_rows > 0) {
                $tip = $resTip->fetch_assoc();
                $tipologia = [
                    "descrizione" => $tip["tip_desc"],
                    "isPartial" => true,
                    "link" => "http://localhost/tipologie/" . $tip["tip_id"]
                ];
            }

            $poi["tipologia"] = $tipologia;
            $poi["link"] = "http://localhost/api/poi/" . $poi["poi_id"];

            echo json_encode($poi, JSON_PRETTY_PRINT);
        } else {
            http_response_code(404);
            echo json_encode(["errore" => "POI non trovato"]);
        }
    } else {
        // Altrimenti, restituisci tutti i POI
        $sql = "SELECT * FROM poi";
        $result = $conn->query($sql);
        $pois = [];

        while ($row = $result->fetch_assoc()) {
            $tipologia = [];
            $resTip = $conn->query("SELECT * FROM tipologie WHERE tip_id = '" . $row["poi_tip_id"] . "'");
            if ($resTip->num_rows > 0) {
                $tip = $resTip->fetch_assoc();
                $tipologia = [
                    "descrizione" => $tip["tip_desc"],
                    "isPartial" => true,
                    "link" => "http://localhost/tipologie/" . $tip["tip_id"]
                ];
            }

            $pois[] = [
                "id" => $row["poi_id"],
                "nome" => $row["poi_nome"],
                "descrizione" => $row["poi_desc"],
                "longitudine" => $row["poi_longitudine"],
                "latitudine" => $row["poi_latitudine"],
                "indirizzo" => $row["poi_indirizzo"],
                "tipologia" => $tipologia,
                "link" => "http://localhost/api/poi/" . $row["poi_id"]
            ];
        }

        echo json_encode($pois, JSON_PRETTY_PRINT);
    }
}

$conn->close();
?>
