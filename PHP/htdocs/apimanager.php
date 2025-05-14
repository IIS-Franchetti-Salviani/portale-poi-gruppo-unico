<?php
// URI richiesta
$requestURI = $_SERVER['REQUEST_URI'];
$scriptName = $_SERVER['SCRIPT_NAME'];

// Estrai il path, escludendo query string
$path = parse_url($requestURI, PHP_URL_PATH);

// Rimuovi eventuale path base del server (es. /progetto/)
$basePath = dirname($scriptName);
if (strpos($path, $basePath) === 0) {
    $path = substr($path, strlen($basePath));
}

// Normalizza: rimuovi slash iniziali/finali
$path = trim($path, '/');

// Split della URI nei segmenti
$segments = explode('/', $path);

// Se vuota, redireziona alla home (opzionale)
if (empty($segments[0])) {
    header("Location: /index.php");
    exit;
}

// Primo segmento = risorsa (es. "docenti")
$risorsa = $segments[0];
$parametri = [];

// Se presente un secondo segmento ? interpretalo come filtro chiave univoca
if (isset($segments[1])) {
    switch ($risorsa) {
        case 'docenti':
            $parametri['docenteId'] = $segments[1];
            break;
        case 'materie':
            $parametri['materiaId'] = $segments[1];
            break;
        case 'classi':
            $parametri['classeId'] = $segments[1];
            break;
        case 'discipline':
            $parametri['disciplinaId'] = $segments[1];
            break;
        case 'insegnamenti':
            $parametri['insegnamentoId'] = $segments[1]; // oppure struttura combinata se vuoi
            break;
        default:
            break;
    }
}

// Costruzione del file da includere
$folderPath = $_SERVER['DOCUMENT_ROOT'] . '/' . $risorsa;
$filePath = $folderPath . '/index.php';

// Controllo esistenza file
if (file_exists($filePath)) {
    // Costruisco la query string
    $_GET = array_merge($_GET, $parametri);
    include $filePath;
} else {
    http_response_code(404);
    header('Content-Type: text/plain');
    echo "Risorsa non trovata: $risorsa";
}

return;


// Estraiamo solo il percorso (senza query string), rimuovendo slash iniziali/finali
$path = parse_url($requestURI, PHP_URL_PATH);
$path = trim($path, '/');

// Se la path è vuota, impostiamola su 'index.php' (o un tuo file predefinito)
if ($path === '') {
    $path = 'index.php';
}
// Costruiamo il percorso fisico sul server (DOC_ROOT/cartella/sottocartella/index.php)
$fullPath = $_SERVER['DOCUMENT_ROOT'] . '/' . $path;

// Se la cartella esiste, puntiamo al suo file index.php
if (is_dir($fullPath)) {
    $fullPath = rtrim($fullPath, '/') . '/index.php';
}

// Verifichiamo se esiste davvero il file
if (file_exists($fullPath) && is_file($fullPath)) {
    // Includiamo o inoltriamo la richiesta al file trovato
    include $fullPath;
} else {
    // Se il file non esiste, restituiamo un errore 404
    header("HTTP/1.0 404 Not Found");
    echo "La risorsa specificata non esiste: " . htmlspecialchars($requestURI);
}
?>
