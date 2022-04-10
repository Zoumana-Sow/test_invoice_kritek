-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : dim. 10 avr. 2022 à 18:04
-- Version du serveur : 10.4.22-MariaDB
-- Version de PHP : 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `krit_test`
--

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
                                               `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
                                               `executed_at` datetime DEFAULT NULL,
                                               `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
    ('DoctrineMigrations\\Version20220410035909', '2022-04-10 03:59:29', 183);

-- --------------------------------------------------------

--
-- Structure de la table `invoice`
--

CREATE TABLE `invoice` (
                           `id` int(11) NOT NULL,
                           `date_invoice` date NOT NULL,
                           `number_invoice` int(11) NOT NULL,
                           `customer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `invoice`
--

INSERT INTO `invoice` (`id`, `date_invoice`, `number_invoice`, `customer_id`) VALUES
                                                                                  (1, '2019-04-02', 1, 101),
                                                                                  (8, '2017-01-01', 2, 101),
                                                                                  (9, '2017-01-01', 9, 101),
                                                                                  (10, '2017-01-01', 10, 1),
                                                                                  (11, '2017-01-01', 11, 1);

-- --------------------------------------------------------

--
-- Structure de la table `invoice_lines`
--

CREATE TABLE `invoice_lines` (
                                 `id` int(11) NOT NULL,
                                 `invoice_id` int(11) DEFAULT NULL,
                                 `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `quantity` int(11) NOT NULL,
                                 `amount` decimal(10,2) DEFAULT NULL,
                                 `vat_amount` decimal(10,2) DEFAULT NULL,
                                 `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `invoice_lines`
--

INSERT INTO `invoice_lines` (`id`, `invoice_id`, `description`, `quantity`, `amount`, `vat_amount`, `total`) VALUES
                                                                                                                 (1, 8, 'AIZ', 181, '10.00', '325.80', '2135.80'),
                                                                                                                 (2, 9, 'ZJA', 181, '10.00', '325.80', '2135.80'),
                                                                                                                 (3, 10, 'Test', 100, '22.00', '396.00', '2596.00'),
                                                                                                                 (4, 11, 'Test', 100, '22.00', '396.00', '2596.00');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
    ADD PRIMARY KEY (`version`);

--
-- Index pour la table `invoice`
--
ALTER TABLE `invoice`
    ADD PRIMARY KEY (`id`);

--
-- Index pour la table `invoice_lines`
--
ALTER TABLE `invoice_lines`
    ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_72DBDC232989F1FD` (`invoice_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `invoice`
--
ALTER TABLE `invoice`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `invoice_lines`
--
ALTER TABLE `invoice_lines`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `invoice_lines`
--
ALTER TABLE `invoice_lines`
    ADD CONSTRAINT `FK_72DBDC232989F1FD` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
