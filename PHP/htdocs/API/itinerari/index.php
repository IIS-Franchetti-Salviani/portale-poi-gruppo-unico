const data = {
  name: "Mario Rossi",
  email: "mario@example.com"
};

fetch("https://example.com/api/utenti", {
  method: "POST",
  headers: {
    "Content-Type": "application/json"
  },
  body: JSON.stringify(data)
})
  .then(response => {
    if (!response.ok) {
      throw new Error("Errore nella richiesta POST");
    }
    return response.json();
  })
  .then(result => {
    console.log("Risposta dal server:", result);
  })
  .catch(error => {
    console.error("Errore:", error);
  });
