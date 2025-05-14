-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 14, 2025 alle 11:20
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
-- Database: `itinerario,sonopresenti`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `itinerario`
--

CREATE TABLE `itinerario` (
  `Iti_Id` int(11) NOT NULL,
  `Iti_Durata` time NOT NULL,
  `Iti_Velocita` double NOT NULL,
  `Iti_Lunghezza` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `sonopresenti`
--

CREATE TABLE `sonopresenti` (
  `Sop_Poi_Id` int(11) NOT NULL,
  `Sop_Iti_Id` int(11) NOT NULL,
  `Sop_Progressivo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `itinerario`
--
ALTER TABLE `itinerario`
  ADD PRIMARY KEY (`Iti_Id`);

--
-- Indici per le tabelle `sonopresenti`
--
ALTER TABLE `sonopresenti`
  ADD PRIMARY KEY (`Sop_Poi_Id`,`Sop_Iti_Id`,`Sop_Progressivo`),
  ADD KEY `Sop_Iti_Id` (`Sop_Iti_Id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `itinerario`
--
ALTER TABLE `itinerario`
  MODIFY `Iti_Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `sonopresenti`
--
ALTER TABLE `sonopresenti`
  ADD CONSTRAINT `sonopresenti_ibfk_1` FOREIGN KEY (`Sop_Poi_Id`) REFERENCES `poi` (`poi_Id`),
  ADD CONSTRAINT `sonopresenti_ibfk_2` FOREIGN KEY (`Sop_Iti_Id`) REFERENCES `itinerario` (`Iti_Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
