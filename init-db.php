<?php
require_once __DIR__ . '/db.php';

$db = getDB();

$db->exec("
CREATE TABLE IF NOT EXISTS projects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    category TEXT NOT NULL DEFAULT 'Plateforme Web',
    description TEXT,
    link TEXT,
    tools TEXT,
    image TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS team_members (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    roles TEXT NOT NULL,
    description TEXT,
    photo TEXT,
    portfolio_url TEXT,
    linkedin TEXT,
    github TEXT,
    active INTEGER DEFAULT 1,
    order_num INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT,
    whatsapp TEXT,
    subject TEXT,
    message TEXT,
    is_read INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS admins (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    full_name TEXT,
    last_login DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS settings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    setting_key TEXT NOT NULL UNIQUE,
    setting_value TEXT,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
");

$adminCount = $db->query("SELECT COUNT(*) FROM admins")->fetchColumn();
if ($adminCount == 0) {
    $hash = password_hash('Odo2026', PASSWORD_DEFAULT);
    $stmt = $db->prepare("INSERT INTO admins (username, password_hash, full_name) VALUES (?, ?, ?)");
    $stmt->execute(['Odonel', $hash, 'Marthe Odonelle Njoya']);
}

$teamCount = $db->query("SELECT COUNT(*) FROM team_members")->fetchColumn();
if ($teamCount == 0) {
    $members = [
        ['Marthe Odonelle Njoya', 'Développeuse Fullstack', 'Développeuse Fullstack passionnée, Marthe maîtrise le développement front et back-end. Elle conçoit des applications web robustes, des interfaces soignées et des architectures solides. Disponible pour des missions en IT Support, Web Development, Front-end et UI/UX.', 'odonel.jpg', 'https://odonelle2001.github.io/MarthePotfolio/index.html', 'marthe-odonelle-njoya', 'Odonelle2001', 0],
        ['Ben FOCH', 'Développeur Web', 'Développeur Web créatif et rigoureux, Ben transforme vos idées en sites web performants et modernes. Spécialiste du développement frontend et de l\'intégration, il assure des rendus visuellement impeccables sur tous les appareils.', 'ben.jpeg', 'https://benfochportfolio.iceiy.com/index.php#hero', '', '', 1],
        ['YONKOUE Njoya Emma', 'Designer Graphique & UI/UX', 'Designer Graphique & UI/UX, Emma donne vie à l\'identité visuelle de vos projets. De la création de logo à la conception d\'interfaces utilisateur intuitives, elle conjugue esthétique et fonctionnalité pour des expériences mémorables.', 'emma.jpeg', 'https://porte-folio-4-0.vercel.app/', '', '', 2],
    ];
    $stmt = $db->prepare("INSERT INTO team_members (name, roles, description, photo, portfolio_url, linkedin, github, order_num) VALUES (?,?,?,?,?,?,?,?)");
    foreach ($members as $m) {
        $stmt->execute($m);
    }
}

$settingsCount = $db->query("SELECT COUNT(*) FROM settings")->fetchColumn();
if ($settingsCount == 0) {
    $defaults = [
        ['whatsapp_link', 'https://wa.me/237651347948'],
        ['telegram_link', 'https://t.me/liontech'],
        ['email', 'odonellenjoya83@gmail.com'],
        ['phone', '(651) 347-9485'],
        ['facebook', 'https://facebook.com/liontech'],
        ['instagram', 'https://instagram.com/liontech'],
        ['linkedin', 'https://linkedin.com/company/liontech'],
        ['github', 'https://github.com/Odonelle2001'],
        ['address', 'Yaoundé, Cameroun'],
    ];
    $stmt = $db->prepare("INSERT INTO settings (setting_key, setting_value) VALUES (?,?)");
    foreach ($defaults as $s) {
        $stmt->execute($s);
    }
}

$projectCount = $db->query("SELECT COUNT(*) FROM projects")->fetchColumn();
if ($projectCount == 0) {
    $projects = [
        ['Boutique Mode Yaoundé', 'Plateforme Web', 'Site e-commerce bilingue — optimisé mobile, +200% de ventes en ligne.', '#', 'HTML, CSS, PHP, MySQL', ''],
        ['Resto Le Palmier', 'Design Graphique', 'Campagne réseaux sociaux — abonnés Instagram × 3 en 60 jours.', '#', 'Photoshop, Illustrator', ''],
        ['Clinique Santé Plus', 'Plateforme Web', 'Google Ads — retour sur investissement multiplié par 5 en 3 mois.', '#', 'Google Ads, Analytics', ''],
        ['Bijouterie Elégance', 'Design Graphique', 'Identité de marque complète — logo, charte graphique et supports print.', '#', 'Illustrator, InDesign', ''],
        ['Hôtel Azur Douala', 'Plateforme Web', 'Système de réservation en ligne avec paiement intégré.', '#', 'PHP, JavaScript, Stripe', ''],
        ['Cabinet Juridique Dikobé', 'Plateforme Web', 'Site vitrine professionnel avec blog et formulaire de contact.', '#', 'WordPress, CSS', ''],
    ];
    $stmt = $db->prepare("INSERT INTO projects (title, category, description, link, tools, image) VALUES (?,?,?,?,?,?)");
    foreach ($projects as $p) {
        $stmt->execute($p);
    }
}

echo "Base de données initialisée avec succès.\n";
