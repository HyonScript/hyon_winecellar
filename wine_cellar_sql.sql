CREATE TABLE IF NOT EXISTS `wine_cellar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `barrels` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `crate` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('bottle', 'Bottle', 2, 0, 1),
('grape', 'Grape', 2, 0, 1),
('pressed_grape', 'Pressed Grape', 1, 0, 1),
('wine', 'Bottle of Wine', 2, 0, 1);