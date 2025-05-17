<?php
include_once ('../../db/db.php');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
        $fileTmpPath = $_FILES['image']['tmp_name'];
        $fileName = $_FILES['image']['name'];
        $uploadDir = 'uploads/';
        $dest_path = $uploadDir . $fileName;

        if (move_uploaded_file($fileTmpPath, $dest_path)) {
            http_response_code(201);
            echo json_encode(["message" => "Immagine caricata", "link" => "http://localhost/project-root/api/immagini/uploads/$fileName"]);
        } else {
            http_response_code(500);
            echo json_encode(["error" => "Errore nel caricamento dell'immagine"]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["error" => "Nessun file inviato o errore nel caricamento"]);
    }
}
?>
