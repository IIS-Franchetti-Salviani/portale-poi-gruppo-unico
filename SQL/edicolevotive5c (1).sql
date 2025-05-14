-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 14, 2025 alle 11:37
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
-- Database: `edicolevotive5c`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `gruppi`
--

CREATE TABLE `gruppi` (
  `GRU_Codice` int(11) NOT NULL,
  `GRU_GUI_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `gruppi`
--

INSERT INTO `gruppi` (`GRU_Codice`, `GRU_GUI_Id`) VALUES
(101, 1),
(102, 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `guide`
--

CREATE TABLE `guide` (
  `GUI_ID` int(11) NOT NULL,
  `GUI_nome` varchar(500) DEFAULT NULL,
  `GUI_cognome` varchar(500) DEFAULT NULL,
  `GUI_telefono` varchar(500) DEFAULT NULL,
  `GUI_username` varchar(500) DEFAULT NULL,
  `GUI_password` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `guide`
--

INSERT INTO `guide` (`GUI_ID`, `GUI_nome`, `GUI_cognome`, `GUI_telefono`, `GUI_username`, `GUI_password`) VALUES
(1, 'Luca', 'Bianchi', '3331112222', 'lbianchi', 'pass123'),
(2, 'Giulia', 'Rossi', '3333334444', 'grossi', 'pass456');

-- --------------------------------------------------------

--
-- Struttura della tabella `immagini`
--

CREATE TABLE `immagini` (
  `IMM_ID` int(11) NOT NULL,
  `IMM_Url` varchar(500) DEFAULT NULL,
  `IMM_Desc` varchar(500) DEFAULT NULL,
  `IMM_POI_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `indicazioni`
--

CREATE TABLE `indicazioni` (
  `IND_id` int(11) NOT NULL,
  `IND_timestamp` time DEFAULT NULL,
  `IND_testo` varchar(500) DEFAULT NULL,
  `IND_PER_ITI_ID` int(11) DEFAULT NULL,
  `IND_PER_GRU_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `indicazioni`
--

INSERT INTO `indicazioni` (`IND_id`, `IND_timestamp`, `IND_testo`, `IND_PER_ITI_ID`, `IND_PER_GRU_ID`) VALUES
(1, '10:00:00', 'Inizio visita presso edicola Madonna del Soccorso', 1, 101),
(2, '10:45:00', 'Proseguire verso l’edicola di San Francesco', 1, 101),
(3, '11:00:00', 'Pausa nei pressi della Madonna delle Grazie', 2, 102);

-- --------------------------------------------------------

--
-- Struttura della tabella `itinerari`
--

CREATE TABLE `itinerari` (
  `ITI_ID` int(11) NOT NULL,
  `ITI_Durata` double DEFAULT NULL,
  `ITI_Velocita` int(11) DEFAULT NULL,
  `ITI_Lunghezza` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `itinerari`
--

INSERT INTO `itinerari` (`ITI_ID`, `ITI_Durata`, `ITI_Velocita`, `ITI_Lunghezza`) VALUES
(1, 2.5, 5, 8.2),
(2, 1.5, 4, 5);

-- --------------------------------------------------------

--
-- Struttura della tabella `percorre`
--

CREATE TABLE `percorre` (
  `PER_ITI_ID` int(11) NOT NULL,
  `PER_GRU_ID` int(11) NOT NULL,
  `PER_Data_Partenza` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `percorre`
--

INSERT INTO `percorre` (`PER_ITI_ID`, `PER_GRU_ID`, `PER_Data_Partenza`) VALUES
(1, 101, '2025-05-10'),
(2, 102, '2025-05-12');

-- --------------------------------------------------------

--
-- Struttura della tabella `poi`
--

CREATE TABLE `poi` (
  `POI_ID` int(11) NOT NULL,
  `POI_nome` varchar(500) DEFAULT NULL,
  `POI_desc` varchar(500) DEFAULT NULL,
  `POI_longitudine` double DEFAULT NULL,
  `POI_latitudine` double DEFAULT NULL,
  `POI_indirizzo` varchar(500) DEFAULT NULL,
  `POI_TIP_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `poi`
--

INSERT INTO `poi` (`POI_ID`, `POI_nome`, `POI_desc`, `POI_longitudine`, `POI_latitudine`, `POI_indirizzo`, `POI_TIP_id`) VALUES
(1, 'Edicola votiva Madonna del Soccorso', 'Piccola edicola con affresco mariano del XVIII secolo', 12.3876, 43.1121, 'Via del Soccorso, Perugia', 1),
(2, 'Edicola votiva di San Francesco', 'Raffigura San Francesco in preghiera lungo il sentiero francescano', 12.6205, 43.0708, 'Via degli Eremiti, Assisi', 1),
(3, 'Edicola votiva della Madonna delle Grazie', 'Affresco restaurato con cornice in pietra, datato 1852', 12.2403, 42.9305, 'Località Fontivegge, Terni', 1),
(4, 'Edicola votiva di Sant\'Antonio', 'Iconografia popolare con ceri sempre accesi, amata dalla comunità', 12.55, 42.884, 'Strada Provinciale 451, Spello', 1),
(5, 'Edicola votiva della Vergine Addolorata', 'Edicola immersa nella campagna umbra, costruita nel 1901', 12.5032, 42.7639, 'Via Madonna Addolorata, Bevagna', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `sono_presenti`
--

CREATE TABLE `sono_presenti` (
  `SOP_POI_Id` int(11) NOT NULL,
  `SOP_ITI_Id` int(11) NOT NULL,
  `SOP_Progressivo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `sono_presenti`
--

INSERT INTO `sono_presenti` (`SOP_POI_Id`, `SOP_ITI_Id`, `SOP_Progressivo`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 2),
(5, 2, 3);

-- --------------------------------------------------------

--
-- Struttura della tabella `tipologie`
--

CREATE TABLE `tipologie` (
  `TIP_Id` int(11) NOT NULL,
  `TIP_Desc` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `tipologie`
--

INSERT INTO `tipologie` (`TIP_Id`, `TIP_Desc`) VALUES
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
  ADD PRIMARY KEY (`GRU_Codice`),
  ADD KEY `GRU_GUI_Id` (`GRU_GUI_Id`);

--
-- Indici per le tabelle `guide`
--
ALTER TABLE `guide`
  ADD PRIMARY KEY (`GUI_ID`);

--
-- Indici per le tabelle `immagini`
--
ALTER TABLE `immagini`
  ADD PRIMARY KEY (`IMM_ID`),
  ADD KEY `IMM_POI_Id` (`IMM_POI_Id`);

--
-- Indici per le tabelle `indicazioni`
--
ALTER TABLE `indicazioni`
  ADD PRIMARY KEY (`IND_id`),
  ADD KEY `indicazioni_ibfk_1` (`IND_PER_ITI_ID`),
  ADD KEY `indicazioni_ibfk_2` (`IND_PER_GRU_ID`);

--
-- Indici per le tabelle `itinerari`
--
ALTER TABLE `itinerari`
  ADD PRIMARY KEY (`ITI_ID`);

--
-- Indici per le tabelle `percorre`
--
ALTER TABLE `percorre`
  ADD PRIMARY KEY (`PER_ITI_ID`,`PER_GRU_ID`),
  ADD KEY `PER_GRU_ID` (`PER_GRU_ID`);

--
-- Indici per le tabelle `poi`
--
ALTER TABLE `poi`
  ADD PRIMARY KEY (`POI_ID`),
  ADD KEY `POI_TIP_id` (`POI_TIP_id`);

--
-- Indici per le tabelle `sono_presenti`
--
ALTER TABLE `sono_presenti`
  ADD PRIMARY KEY (`SOP_POI_Id`,`SOP_ITI_Id`),
  ADD KEY `SOP_ITI_Id` (`SOP_ITI_Id`);

--
-- Indici per le tabelle `tipologie`
--
ALTER TABLE `tipologie`
  ADD PRIMARY KEY (`TIP_Id`);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `gruppi`
--
ALTER TABLE `gruppi`
  ADD CONSTRAINT `gruppi_ibfk_1` FOREIGN KEY (`GRU_GUI_Id`) REFERENCES `guide` (`GUI_ID`);

--
-- Limiti per la tabella `immagini`
--
ALTER TABLE `immagini`
  ADD CONSTRAINT `immagini_ibfk_1` FOREIGN KEY (`IMM_POI_Id`) REFERENCES `poi` (`POI_ID`);

--
-- Limiti per la tabella `indicazioni`
--
ALTER TABLE `indicazioni`
  ADD CONSTRAINT `indicazioni_ibfk_1` FOREIGN KEY (`IND_PER_ITI_ID`) REFERENCES `percorre` (`PER_ITI_ID`),
  ADD CONSTRAINT `indicazioni_ibfk_2` FOREIGN KEY (`IND_PER_GRU_ID`) REFERENCES `percorre` (`PER_GRU_ID`);

--
-- Limiti per la tabella `percorre`
--
ALTER TABLE `percorre`
  ADD CONSTRAINT `percorre_ibfk_1` FOREIGN KEY (`PER_ITI_ID`) REFERENCES `itinerari` (`ITI_ID`),
  ADD CONSTRAINT `percorre_ibfk_2` FOREIGN KEY (`PER_GRU_ID`) REFERENCES `gruppi` (`GRU_Codice`);

--
-- Limiti per la tabella `poi`
--
ALTER TABLE `poi`
  ADD CONSTRAINT `poi_ibfk_1` FOREIGN KEY (`POI_TIP_id`) REFERENCES `tipologie` (`TIP_Id`);

--
-- Limiti per la tabella `sono_presenti`
--
ALTER TABLE `sono_presenti`
  ADD CONSTRAINT `sono_presenti_ibfk_1` FOREIGN KEY (`SOP_POI_Id`) REFERENCES `poi` (`POI_ID`),
  ADD CONSTRAINT `sono_presenti_ibfk_2` FOREIGN KEY (`SOP_ITI_Id`) REFERENCES `itinerari` (`ITI_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
