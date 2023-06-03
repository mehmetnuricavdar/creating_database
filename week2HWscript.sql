CREATE TABLE `customers` (
  `customerID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL UNIQUE,
  `phone` varchar(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `orders` (
  `orderID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_date` DATE NOT NULL,
  PRIMARY KEY (`orderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `customerOrder` (
  `orderID` int(10) unsigned NOT NULL,
  `customerID` int(10) unsigned NOT NULL,
  `order_status` ENUM('pending','shipped','delivered','cancelled') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`orderID`),
  CONSTRAINT `customerOrder_customerID` FOREIGN KEY (`customerID`) REFERENCES `customers` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `customerOrder_orderID` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `country` (
  `countryID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `countryName` varchar(255) NOT NULL,
  PRIMARY KEY (`countryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `brand` (
  `brandID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `brandName` varchar(255) NOT NULL,
  `countryID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`brandID`),
 CONSTRAINT `brand_countryID` FOREIGN KEY (`countryID`) REFERENCES `country` (`countryID`) ON DELETE CASCADE ON UPDATE CASCADE
  -- FOREIGN KEY (countryID) REFERENCES country(countryID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `item` (
  `itemID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemName` varchar(255) NOT NULL,
  `itemPrice` DECIMAL(10,2) NOT NULL,
  `brandID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`itemID`),
  CONSTRAINT `item_brandID` FOREIGN KEY (`brandID`) REFERENCES `brand` (`brandID`) ON DELETE CASCADE ON UPDATE CASCADE
 -- FOREIGN KEY (brandID) REFERENCES brand(brandID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `city` (
  `cityID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cityName` varchar(255) NOT NULL,
  `countryID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cityID`),
  CONSTRAINT `city_countryID` FOREIGN KEY (`countryID`) REFERENCES `country` (`countryID`) ON DELETE CASCADE ON UPDATE CASCADE
  -- FOREIGN KEY (countryID) REFERENCES country(countryID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `store` (
  `storeID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `storeName` varchar(255) NOT NULL,
  `cityID` int(10) unsigned NOT NULL,
  `countryID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`storeID`),
  CONSTRAINT `store_countryID` FOREIGN KEY (`countryID`) REFERENCES `country` (`countryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `store_cityID` FOREIGN KEY (`cityID`) REFERENCES `city` (`cityID`) ON DELETE CASCADE ON UPDATE CASCADE
 -- FOREIGN KEY (countryID) REFERENCES country(countryID),
 -- FOREIGN KEY (cityID) REFERENCES city(cityID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_item` (
  `orderID` int(10) unsigned NOT NULL,
  `itemID` int(10) unsigned NOT NULL,
  `itemQuantity` int(10) NOT NULL,
  PRIMARY KEY (`orderID`, `itemID`),
  CONSTRAINT `order_item_orderID` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_item_itemID` FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`) ON DELETE CASCADE ON UPDATE CASCADE
  -- FOREIGN KEY (orderID) REFERENCES `order`(orderID)
 -- FOREIGN KEY (itemID) REFERENCES item(itemID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `salesAdvisor` (
  `advisorID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `advisorFirstName` varchar(255) NOT NULL,
  `advisorLastName` varchar(255) NOT NULL,
  `storeID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`advisorID`),
  CONSTRAINT `salesAdvisor_storeID` FOREIGN KEY (`storeID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE
 -- FOREIGN KEY (storeID) REFERENCES store(storeID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_advisor` (
  `orderID` int(10) unsigned NOT NULL,
  `advisorID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`orderID`, `advisorID`),
  CONSTRAINT `order_advisor_orderId` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_advisor_advisorID` FOREIGN KEY (`advisorID`) REFERENCES `salesAdvisor` (`advisorID`) ON DELETE CASCADE ON UPDATE CASCADE
  -- FOREIGN KEY (orderID) REFERENCES `order`(orderID),
  -- FOREIGN KEY (advisorID) REFERENCES salesAdvisor(advisorID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

