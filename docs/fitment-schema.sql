-- Architectural sketch ONLY; NOT a complete production-ready migration set.
-- MySQL 8+, utf8mb4. Demo UI currently uses mock JS objects, not this database.
CREATE TABLE vehicle_makes (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE vehicle_models (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  make_id BIGINT UNSIGNED NOT NULL,
  name VARCHAR(120) NOT NULL,
  UNIQUE KEY ux_model_make_name (make_id, name),
  CONSTRAINT fk_model_make FOREIGN KEY (make_id) REFERENCES vehicle_makes(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE vehicle_variants (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  model_id BIGINT UNSIGNED NOT NULL,
  production_year SMALLINT UNSIGNED NOT NULL,
  trim_name VARCHAR(120) NOT NULL,
  UNIQUE KEY ux_variant (model_id, production_year, trim_name),
  CONSTRAINT fk_variant_model FOREIGN KEY (model_id) REFERENCES vehicle_models(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE categories (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE products (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  category_id BIGINT UNSIGNED NULL,
  sku VARCHAR(100) NOT NULL UNIQUE,
  name VARCHAR(250) NOT NULL,
  brand VARCHAR(120) NULL,
  price_minor BIGINT UNSIGNED NOT NULL DEFAULT 0,
  stock_qty INT UNSIGNED NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  INDEX idx_products_name (name),
  INDEX idx_products_brand (brand),
  CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE product_fitments (
  product_id BIGINT UNSIGNED NOT NULL,
  variant_id BIGINT UNSIGNED NOT NULL,
  verification_status ENUM('pending','verified','rejected') NOT NULL DEFAULT 'pending',
  note VARCHAR(255) NULL,
  PRIMARY KEY (product_id, variant_id),
  INDEX idx_fitments_variant_status_product (variant_id, verification_status, product_id),
  CONSTRAINT fk_fitment_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  CONSTRAINT fk_fitment_variant FOREIGN KEY (variant_id) REFERENCES vehicle_variants(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Query pattern for verified compatible products:
-- SELECT p.* FROM product_fitments f
-- JOIN products p ON p.id = f.product_id
-- WHERE f.variant_id = ? AND f.verification_status = 'verified'
-- AND p.is_active = TRUE ORDER BY p.id DESC LIMIT 24;