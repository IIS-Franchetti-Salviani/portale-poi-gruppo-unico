<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Configurazione database (funzionante)
$host = 'localhost';
$port = 3306;
$dbname = 'db_edicole_votive_5c';
$username = 'root';
$password = '';

try {
    $dsn = "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8";
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'error' => 'Errore di connessione al database',
        'details' => $e->getMessage()
    ]);
    exit();
}

$method = $_SERVER['REQUEST_METHOD'];

// Gestione richieste GET
if ($method == 'GET') {
    try {
        $stmt = $pdo->query("SELECT iti_id, iti_durata, iti_velocita, iti_lunghezza FROM itinerari ORDER BY iti_id");
        $itinerari = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        echo json_encode([
            'success' => true,
            'data' => $itinerari,
            'count' => count($itinerari)
        ]);
        
    } catch(PDOException $e) {
        http_response_code(500);
        echo json_encode([
            'error' => 'Errore nel recupero degli itinerari',
            'details' => $e->getMessage()
        ]);
    }
}

// Gestione altri metodi HTTP
else {
    http_response_code(405);
    echo json_encode(['error' => 'Metodo non consentito']);
}
?>