<?php
// Impostazioni di connessione al database
$host = 'localhost';   // Host del database
$dbname = 'nome_del_tuo_database'; // Nome del database
$username = 'tuo_username'; // Nome utente del database
$password = 'tua_password'; // Password del database

// Connessione al database
try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Errore di connessione: " . $e->getMessage();
    exit;
}

// Impostazione dell'header per restituire il formato JSON
header('Content-Type: application/json');

// Esegui una query per recuperare i dati dalla tabella "percorre"
$query = 'SELECT * FROM percorre';
$stmt = $pdo->prepare($query);
$stmt->execute();

// Recupera i risultati
$percorre_data = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Restituisci i dati in formato JSON
echo json_encode($percorre_data);
?>
