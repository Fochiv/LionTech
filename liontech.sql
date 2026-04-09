-- ============================================================
-- LIONTECH — Base de données MySQL
-- Compatible WAMP Server / phpMyAdmin
-- Pour adapter à Replit : utilisez SQLite via PDO (db.php)
-- ============================================================

CREATE DATABASE IF NOT EXISTS `liontech` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `liontech`;

-- ============================================================
-- TABLE: projects (Réalisations)
-- ============================================================
CREATE TABLE IF NOT EXISTS `projects` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(255) NOT NULL,
  `category` ENUM('Plateforme Web', 'Design Graphique') NOT NULL DEFAULT 'Plateforme Web',
  `description` TEXT,
  `link` VARCHAR(500),
  `tools` VARCHAR(500) COMMENT 'Langages/outils séparés par des virgules',
  `image` VARCHAR(255),
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- TABLE: team_members (Membres de l'équipe)
-- ============================================================
CREATE TABLE IF NOT EXISTS `team_members` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `roles` VARCHAR(500) NOT NULL,
  `photo` VARCHAR(255),
  `portfolio_url` VARCHAR(500),
  `linkedin` VARCHAR(255) COMMENT 'Nom utilisateur LinkedIn',
  `github` VARCHAR(255) COMMENT 'Nom utilisateur GitHub',
  `active` TINYINT(1) DEFAULT 1,
  `order_num` INT DEFAULT 0,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- TABLE: messages (Messages du formulaire de contact)
-- ============================================================
CREATE TABLE IF NOT EXISTS `messages` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255),
  `whatsapp` VARCHAR(50),
  `subject` VARCHAR(500),
  `message` TEXT,
  `is_read` TINYINT(1) DEFAULT 0,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- TABLE: admins (Administrateurs)
-- ============================================================
CREATE TABLE IF NOT EXISTS `admins` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(100) NOT NULL UNIQUE,
  `password_hash` VARCHAR(255) NOT NULL COMMENT 'Haché avec password_hash()',
  `full_name` VARCHAR(255),
  `last_login` DATETIME,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- TABLE: settings (Paramètres du site)
-- ============================================================
CREATE TABLE IF NOT EXISTS `settings` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `setting_key` VARCHAR(100) NOT NULL UNIQUE,
  `setting_value` TEXT,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- DONNÉES PAR DÉFAUT
-- ============================================================

-- Compte admin par défaut (identifiant: Odonel / mot de passe: Odo2026)
INSERT INTO `admins` (`username`, `password_hash`, `full_name`) VALUES
('Odonel', '$2y$10$replaceme_run_php_password_hash', 'Marthe Odonelle Njoya');
-- Note: Regénérez le hash en PHP : echo password_hash('Odo2026', PASSWORD_DEFAULT);

-- Membres de l'équipe
INSERT INTO `team_members` (`name`, `roles`, `photo`, `portfolio_url`, `linkedin`, `github`, `order_num`) VALUES
('Marthe Odonelle Njoya', 'Développeuse Fullstack', 'odonel.jpg', 'https://odonelle2001.github.io/MarthePotfolio/index.html', 'marthe-odonelle-njoya', 'Odonelle2001', 0),
('Ben FOCH', 'Développeur Web', 'ben.jpeg', 'https://benfochportfolio.iceiy.com/index.php#hero', '', '', 1),
('YONKOUE Njoya Emma', 'Designer Graphique & UI/UX', 'emma.jpeg', 'https://porte-folio-4-0.vercel.app/', '', '', 2);

-- Projets d'exemple
INSERT INTO `projects` (`title`, `category`, `description`, `link`, `tools`, `image`) VALUES
('Boutique Mode Yaoundé', 'Plateforme Web', 'Site e-commerce bilingue — optimisé mobile, +200% de ventes en ligne.', '#', 'HTML, CSS, PHP, MySQL', ''),
('Resto Le Palmier', 'Design Graphique', 'Campagne réseaux sociaux — abonnés Instagram × 3 en 60 jours.', '#', 'Photoshop, Illustrator', ''),
('Clinique Santé Plus', 'Plateforme Web', 'Google Ads — retour sur investissement multiplié par 5 en 3 mois.', '#', 'Google Ads, Analytics', ''),
('Bijouterie Elégance', 'Design Graphique', 'Identité de marque complète — logo, charte graphique et supports print.', '#', 'Illustrator, InDesign', ''),
('Hôtel Azur Douala', 'Plateforme Web', 'Système de réservation en ligne avec paiement intégré.', '#', 'PHP, JavaScript, Stripe', ''),
('Cabinet Juridique Dikobé', 'Plateforme Web', 'Site vitrine professionnel avec blog et formulaire de contact.', '#', 'WordPress, CSS', '');

-- Paramètres du site
INSERT INTO `settings` (`setting_key`, `setting_value`) VALUES
('whatsapp_link', 'https://wa.me/237651347948'),
('telegram_link', 'https://t.me/liontech'),
('email', 'odonellenjoya83@gmail.com'),
('phone', '(651) 347-9485'),
('facebook', 'https://facebook.com/liontech'),
('instagram', 'https://instagram.com/liontech'),
('linkedin', 'https://linkedin.com/company/liontech'),
('github', 'https://github.com/Odonelle2001'),
('address', 'Yaoundé, Cameroun');

-- ============================================================
-- INSTRUCTIONS D'INSTALLATION SUR WAMP
-- ============================================================
-- 1. Placez le dossier liontech/ dans : C:/wamp64/www/
-- 2. Démarrez WAMP et ouvrez phpMyAdmin (http://localhost/phpmyadmin)
-- 3. Créez une base de données nommée "liontech" (utf8mb4)
-- 4. Importez ce fichier liontech.sql
-- 5. Modifiez db.php :
--    Changez la ligne PDO sqlite: par :
--    $pdo = new PDO('mysql:host=localhost;dbname=liontech;charset=utf8mb4', 'root', '');
-- 6. Régénérez le hash admin :
--    php -r "echo password_hash('Odo2026', PASSWORD_DEFAULT);"
-- 7. Accédez au site : http://localhost/liontech/
-- 8. Accédez à l'admin : http://localhost/liontech/admin/login.php
-- ============================================================
