-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 28 Şub 2022, 03:03:13
-- Sunucu sürümü: 10.4.21-MariaDB
-- PHP Sürümü: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `ytsistemi`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `youtubers`
--

CREATE TABLE `youtubers` (
  `yt_id` int(11) NOT NULL,
  `yt_name` varchar(24) NOT NULL,
  `yt_level` int(11) NOT NULL,
  `yt_chname` varchar(32) NOT NULL,
  `yt_passw` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `youtubers`
--

INSERT INTO `youtubers` (`yt_id`, `yt_name`, `yt_level`, `yt_chname`, `yt_passw`) VALUES
(1, 'R4IN', 1, 'aaaa', 'tttt'),
(2, 'Test', 1, 'selam', 'selam'),
(3, 'User', 1, 'GTAMulti.COM - R4IN', '1234');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `youtubers`
--
ALTER TABLE `youtubers`
  ADD PRIMARY KEY (`yt_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `youtubers`
--
ALTER TABLE `youtubers`
  MODIFY `yt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
