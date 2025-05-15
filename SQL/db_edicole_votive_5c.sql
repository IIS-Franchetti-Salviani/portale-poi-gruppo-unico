-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 15, 2025 alle 11:06
-- Versione del server: 10.4.27-MariaDB
-- Versione PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_edicole_votive_5c`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `gruppi`
--

CREATE TABLE `gruppi` (
  `gru_codice` int(11) NOT NULL,
  `gru_gui_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `gruppi`
--

INSERT INTO `gruppi` (`gru_codice`, `gru_gui_id`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `guide`
--

CREATE TABLE `guide` (
  `gui_id` int(11) NOT NULL,
  `gui_nome` varchar(100) DEFAULT NULL,
  `gui_cognome` varchar(100) DEFAULT NULL,
  `gui_telefono` varchar(10) DEFAULT NULL,
  `gui_username` varchar(100) DEFAULT NULL,
  `gui_password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `guide`
--

INSERT INTO `guide` (`gui_id`, `gui_nome`, `gui_cognome`, `gui_telefono`, `gui_username`, `gui_password`) VALUES
(1, 'Anna', 'Rossi', '3331234567', 'anna.rossi', 'pwd123'),
(2, 'Marco', 'Verdi', '3349876543', 'marco.verdi', 'pwd456');

-- --------------------------------------------------------

--
-- Struttura della tabella `immagini`
--

CREATE TABLE `immagini` (
  `imm_id` int(11) NOT NULL,
  `imm_url` varchar(255) NOT NULL,
  `imm_desc` varchar(2000) NOT NULL,
  `imm_poi_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `immagini`
--

INSERT INTO `immagini` (`imm_id`, `imm_url`, `imm_desc`, `imm_poi_id`) VALUES
(1, 'https://esempio.it/edicola1.jpg', 'Immagine dell\'edicola del Soccorso', 1),
(2, 'https://esempio.it/edicola2.jpg', 'San Francesco in preghiera', 2),
(3, 'https://esempio.it/edicola3.jpg', 'Affresco restaurato Madonna delle Grazie', 3);

-- --------------------------------------------------------

--
-- Struttura della tabella `indicazioni`
--

CREATE TABLE `indicazioni` (
  `ind_id` int(11) NOT NULL,
  `ind_timestamp` date DEFAULT NULL,
  `ind_testo` varchar(500) DEFAULT NULL,
  `ind_per_iti_id` int(11) DEFAULT NULL,
  `ind_per_gru_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `indicazioni`
--

INSERT INTO `indicazioni` (`ind_id`, `ind_timestamp`, `ind_testo`, `ind_per_iti_id`, `ind_per_gru_id`) VALUES
(1, '2025-05-15', 'Tenere la destra al bivio dopo l’olivo secolare', 1, 1),
(2, '2025-05-15', 'Fermarsi 5 minuti per spiegazione storico-artistica', 2, 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `itinerari`
--

CREATE TABLE `itinerari` (
  `iti_id` int(11) NOT NULL,
  `iti_durata` time NOT NULL,
  `iti_velocita` double NOT NULL,
  `iti_lunghezza` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `itinerari`
--

INSERT INTO `itinerari` (`iti_id`, `iti_durata`, `iti_velocita`, `iti_lunghezza`) VALUES
(1, '01:30:00', 4.5, 6.8),
(2, '02:00:00', 3.8, 7.5);

-- --------------------------------------------------------

--
-- Struttura della tabella `percorre`
--

CREATE TABLE `percorre` (
  `per_iti_id` int(11) NOT NULL,
  `per_gru_id` int(11) NOT NULL,
  `per_data_partenza` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `percorre`
--

INSERT INTO `percorre` (`per_iti_id`, `per_gru_id`, `per_data_partenza`) VALUES
(1, 1, '2025-05-15 09:00:00'),
(2, 2, '2025-05-15 10:30:00');

-- --------------------------------------------------------

--
-- Struttura della tabella `poi`
--

CREATE TABLE `poi` (
  `poi_id` int(11) NOT NULL,
  `poi_nome` varchar(255) NOT NULL,
  `poi_desc` varchar(2000) NOT NULL,
  `poi_longitudine` decimal(9,6) DEFAULT NULL,
  `poi_latitudine` decimal(9,6) DEFAULT NULL,
  `poi_indirizzo` varchar(255) DEFAULT NULL,
  `poi_tip_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `poi`
--

INSERT INTO `poi` (`poi_id`, `poi_nome`, `poi_desc`, `poi_longitudine`, `poi_latitudine`, `poi_indirizzo`, `poi_tip_id`) VALUES
(1, 'Edicola votiva Madonna del Soccorso', 'Piccola edicola con affresco mariano del XVIII secolo', '12.387600', '43.112100', 'Via del Soccorso, Perugia', 1),
(2, 'Edicola votiva di San Francesco', 'Raffigura San Francesco in preghiera lungo il sentiero francescano', '12.620500', '43.070800', 'Via degli Eremiti, Assisi', 1),
(3, 'Edicola votiva della Madonna delle Grazie', 'Affresco restaurato con cornice in pietra, datato 1852', '12.240300', '42.930500', 'Località Fontivegge, Terni', 1),
(4, 'Edicola votiva di Sant\'Antonio', 'Iconografia popolare con ceri sempre accesi, amata dalla comunità', '12.550000', '42.884000', 'Strada Provinciale 451, Spello', 1),
(5, 'Edicola votiva della Vergine Addolorata', 'Edicola immersa nella campagna umbra, costruita nel 1901', '12.503200', '42.763900', 'Via Madonna Addolorata, Bevagna', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `sonopresenti`
--

CREATE TABLE `sonopresenti` (
  `sop_poi_id` int(11) NOT NULL,
  `sop_iti_id` int(11) NOT NULL,
  `sop_progressivo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `sonopresenti`
--

INSERT INTO `sonopresenti` (`sop_poi_id`, `sop_iti_id`, `sop_progressivo`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `tipologie`
--

CREATE TABLE `tipologie` (
  `tip_id` int(11) NOT NULL,
  `tip_desc` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `tipologie`
--

INSERT INTO `tipologie` (`tip_id`, `tip_desc`) VALUES
(1, 'Edicola votiva'),
(2, 'Chiesa'),
(3, 'Monumento storico');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `gruppi`
--
ALTER TABLE `gruppi`
  ADD PRIMARY KEY (`gru_codice`),
  ADD KEY `gru_gui_id` (`gru_gui_id`);

--
-- Indici per le tabelle `guide`
--
ALTER TABLE `guide`
  ADD PRIMARY KEY (`gui_id`);

--
-- Indici per le tabelle `immagini`
--
ALTER TABLE `immagini`
  ADD PRIMARY KEY (`imm_id`),
  ADD KEY `imm_poi_id` (`imm_poi_id`);

--
-- Indici per le tabelle `indicazioni`
--
ALTER TABLE `indicazioni`
  ADD PRIMARY KEY (`ind_id`),
  ADD KEY `ind_per_iti_id` (`ind_per_iti_id`,`ind_per_gru_id`);

--
-- Indici per le tabelle `itinerari`
--
ALTER TABLE `itinerari`
  ADD PRIMARY KEY (`iti_id`);

--
-- Indici per le tabelle `percorre`
--
ALTER TABLE `percorre`
  ADD PRIMARY KEY (`per_iti_id`,`per_gru_id`),
  ADD KEY `per_gru_id` (`per_gru_id`);

--
-- Indici per le tabelle `poi`
--
ALTER TABLE `poi`
  ADD PRIMARY KEY (`poi_id`),
  ADD KEY `poi_tip_id` (`poi_tip_id`);

--
-- Indici per le tabelle `sonopresenti`
--
ALTER TABLE `sonopresenti`
  ADD PRIMARY KEY (`sop_poi_id`,`sop_iti_id`,`sop_progressivo`),
  ADD KEY `sop_iti_id` (`sop_iti_id`);

--
-- Indici per le tabelle `tipologie`
--
ALTER TABLE `tipologie`
  ADD PRIMARY KEY (`tip_id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `guide`
--
ALTER TABLE `guide`
  MODIFY `gui_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `immagini`
--
ALTER TABLE `immagini`
  MODIFY `imm_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `indicazioni`
--
ALTER TABLE `indicazioni`
  MODIFY `ind_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `itinerari`
--
ALTER TABLE `itinerari`
  MODIFY `iti_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `poi`
--
ALTER TABLE `poi`
  MODIFY `poi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT per la tabella `tipologie`
--
ALTER TABLE `tipologie`
  MODIFY `tip_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `gruppi`
--
ALTER TABLE `gruppi`
  ADD CONSTRAINT `fk_gruppo_guida` FOREIGN KEY (`gru_gui_id`) REFERENCES `guide` (`gui_id`);

--
-- Limiti per la tabella `immagini`
--
ALTER TABLE `immagini`
  ADD CONSTRAINT `fk_immagini_poi` FOREIGN KEY (`imm_poi_id`) REFERENCES `poi` (`poi_id`);

--
-- Limiti per la tabella `indicazioni`
--
ALTER TABLE `indicazioni`
  ADD CONSTRAINT `indicazioni_ibfk_1` FOREIGN KEY (`ind_per_iti_id`,`ind_per_gru_id`) REFERENCES `percorre` (`per_iti_id`, `per_gru_id`);

--
-- Limiti per la tabella `percorre`
--
ALTER TABLE `percorre`
  ADD CONSTRAINT `percorre_ibfk_1` FOREIGN KEY (`per_iti_id`) REFERENCES `itinerari` (`iti_id`),
  ADD CONSTRAINT `percorre_ibfk_2` FOREIGN KEY (`per_gru_id`) REFERENCES `gruppi` (`gru_codice`);

--
-- Limiti per la tabella `poi`
--
ALTER TABLE `poi`
  ADD CONSTRAINT `fk_poi_tipologia` FOREIGN KEY (`poi_tip_id`) REFERENCES `tipologie` (`tip_id`);

--
-- Limiti per la tabella `sonopresenti`
--
ALTER TABLE `sonopresenti`
  ADD CONSTRAINT `fk_sonopresenti_itinerario` FOREIGN KEY (`sop_iti_id`) REFERENCES `itinerari` (`iti_id`),
  ADD CONSTRAINT `fk_sonopresenti_poi` FOREIGN KEY (`sop_poi_id`) REFERENCES `poi` (`poi_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
