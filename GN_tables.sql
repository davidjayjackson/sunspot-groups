
DROP TABLE IF EXISTS `GNDB`;

CREATE TABLE `GNDB` (
  `year` varchar(11) NOT NULL DEFAULT '0000',
  `month` varchar(11) NOT NULL DEFAULT '00',
  `day` varchar(11) NOT NULL DEFAULT '00',
  `station` varchar(5) NOT NULL DEFAULT '00000',
  `obs` varchar(10) NOT NULL DEFAULT '000',
  `ggg` varchar(3) NOT NULL DEFAULT '00!'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='GN built';

commit;

--
-- Table structure for table `GN_obs`
--

DROP TABLE IF EXISTS `GN_obs`;

CREATE TABLE `GN_obs` (
  `obs` varchar(10) NOT NULL DEFAULT '0000',
  `year0` varchar(4) NOT NULL DEFAULT '0000',
  `year1` varchar(4) NOT NULL DEFAULT '0000',
  `dbrecs` varchar(6) NOT NULL DEFAULT '000000',
  `namecntry` varchar(30) NOT NULL DEFAULT ' '

 /* PRIMARY KEY (`obs`) USING BTREE */
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='GN_obs built';

commit;


