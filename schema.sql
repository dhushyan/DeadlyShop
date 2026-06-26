-- ============================================================
--  DEADLY SHOP — MySQL Schema + Sample Data
--  Run this file once: mysql -u root -p < schema.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS deadlyshop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE deadlyshop;

-- ----------------------------
-- TABLE: categories
-- ----------------------------
CREATE TABLE IF NOT EXISTS categories (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    slug       VARCHAR(100) NOT NULL UNIQUE,
    image_url  VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- TABLE: users
-- ----------------------------
CREATE TABLE IF NOT EXISTS users (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    email        VARCHAR(150) NOT NULL UNIQUE,
    mobile       VARCHAR(15),
    password     VARCHAR(255) NOT NULL,   -- BCrypt hash
    role         ENUM('user','admin') DEFAULT 'user',
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- TABLE: products
-- ----------------------------
CREATE TABLE IF NOT EXISTS products (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    category_id  INT NOT NULL,
    name         VARCHAR(200) NOT NULL,
    description  TEXT,
    price        DECIMAL(10,2) NOT NULL,
    stock        INT DEFAULT 0,
    image_url    VARCHAR(255),
    brand        VARCHAR(100),
    rating       DECIMAL(2,1) DEFAULT 4.0,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- ----------------------------
-- TABLE: cart
-- ----------------------------
CREATE TABLE IF NOT EXISTS cart (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT DEFAULT 1,
    added_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)    REFERENCES users(id)    ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_cart_item (user_id, product_id)
);

-- ----------------------------
-- TABLE: orders
-- ----------------------------
CREATE TABLE IF NOT EXISTS orders (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    user_id        INT NOT NULL,
    total_amount   DECIMAL(10,2) NOT NULL,
    status         ENUM('pending','confirmed','shipped','delivered','cancelled') DEFAULT 'pending',
    shipping_name  VARCHAR(150),
    shipping_phone VARCHAR(15),
    shipping_address TEXT,
    shipping_city  VARCHAR(100),
    shipping_state VARCHAR(100),
    shipping_pincode VARCHAR(10),
    payment_method VARCHAR(50) DEFAULT 'COD',
    placed_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ----------------------------
-- TABLE: order_items
-- ----------------------------
CREATE TABLE IF NOT EXISTS order_items (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    order_id   INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(id)   ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- ----------------------------
-- SAMPLE DATA
-- ----------------------------

INSERT INTO categories (name, slug) VALUES
('Helmets',       'helmets'),
('Gloves',        'gloves'),
('Jackets',       'jackets'),
('Riding Boots',  'boots'),
('Accessories',   'accessories'),
('Visors & Goggles', 'visors');

-- Admin user (password: Admin@123  — BCrypt hash below)
INSERT INTO users (name, email, mobile, password, role) VALUES
('Admin',      'admin@deadlyshop.com',  '9999999999',
 '$2a$12$QMiVYCnlNNQk8mFDLi/oTuYx5HCnAV0xeqz1klvwXR./mvqyqAqBi', 'admin'),
('Raj Kumar',  'raj@example.com',       '9876543210',
 '$2a$12$QMiVYCnlNNQk8mFDLi/oTuYx5HCnAV0xeqz1klvwXR./mvqyqAqBi', 'user'),
('Priya S',    'priya@example.com',     '9123456780',
 '$2a$12$QMiVYCnlNNQk8mFDLi/oTuYx5HCnAV0xeqz1klvwXR./mvqyqAqBi', 'user');

INSERT INTO products (category_id, name, description, price, stock, image_url, brand, rating) VALUES
(1, 'Stealth Pro Full-Face Helmet',
   'Aerodynamic full-face helmet with ECE 22.06 certification, anti-scratch visor, and integrated sun visor.',
   8999.00, 45, 'https://via.placeholder.com/400x300/1a1a2e/ffffff?text=Stealth+Pro+Helmet', 'Steelbird', 4.7),
(1, 'UrbanRider Open-Face Helmet',
   'Lightweight open-face helmet ideal for city commutes. Ventilation channels keep you cool.',
   4499.00, 60, 'https://via.placeholder.com/400x300/16213e/ffffff?text=UrbanRider+Helmet', 'Vega', 4.3),
(1, 'Carbon Fiber Helmet X1',
   'Premium carbon fiber shell, Bluetooth ready, noise-cancelling interior lining.',
   24999.00, 15, 'https://via.placeholder.com/400x300/0f3460/ffffff?text=Carbon+Fiber+Helmet', 'AGV', 4.9),
(1, 'Moto Cruiser Half Shell',
   'Retro-style half-shell helmet with padded cheek pads and D-ring buckle closure.',
   3299.00, 80, 'https://via.placeholder.com/400x300/533483/ffffff?text=Moto+Cruiser', 'LS2', 4.1),

(2, 'Race-Pro Leather Gloves',
   'Full-grain cowhide leather gloves with carbon-knuckle protection and wrist strap.',
   2799.00, 120, 'https://via.placeholder.com/400x300/e94560/ffffff?text=Race+Pro+Gloves', 'Rynox', 4.6),
(2, 'Summer Mesh Gloves',
   'Breathable mesh gloves with TPU palm sliders, perfect for summer rides.',
   1299.00, 200, 'https://via.placeholder.com/400x300/1a1a2e/ffffff?text=Summer+Mesh+Gloves', 'Cramster', 4.2),
(2, 'Winter Waterproof Gloves',
   'Waterproof outer shell with thermal inner lining. Touchscreen fingertip compatible.',
   3499.00, 75, 'https://via.placeholder.com/400x300/16213e/ffffff?text=Winter+Gloves', 'Alpinestars', 4.8),

(3, 'Dragster Leather Jacket',
   'CE Level-2 armored leather jacket with spine protector pocket and pre-curved arms.',
   18999.00, 30, 'https://via.placeholder.com/400x300/0f3460/ffffff?text=Dragster+Jacket', 'Rynox', 4.7),
(3, 'Mesh Adventure Jacket',
   'All-season mesh jacket with removable waterproof liner and 5 armor pockets.',
   11499.00, 50, 'https://via.placeholder.com/400x300/533483/ffffff?text=Mesh+Jacket', 'Cramster', 4.5),
(3, 'Urban Textile Jacket',
   'Stylish textile jacket suitable for daily commuting with shoulder and elbow protectors.',
   7299.00, 65, 'https://via.placeholder.com/400x300/e94560/ffffff?text=Urban+Jacket', 'Royal Enfield', 4.3),

(4, 'MotoTech Riding Boots',
   'Ankle-support riding boots with oil-resistant sole, steel toecap, and waterproof membrane.',
   9499.00, 40, 'https://via.placeholder.com/400x300/1a1a2e/ffffff?text=MotoTech+Boots', 'TCX', 4.6),
(4, 'Adventure Tourer Boots',
   'Tall adventure boots with metal buckles, shin plate, and replaceable sole.',
   14999.00, 25, 'https://via.placeholder.com/400x300/16213e/ffffff?text=Adventure+Boots', 'Sidi', 4.8),
(4, 'Urban Sneaker Boots',
   'Casual-look ankle boots with hidden CE-rated ankle protectors. All-day comfort.',
   6299.00, 90, 'https://via.placeholder.com/400x300/0f3460/ffffff?text=Urban+Sneakers', 'Rusher', 4.2),

(5, 'USB Tank Bag',
   'Magnetic tank bag with USB charging port, map window, and 15L capacity.',
   3999.00, 55, 'https://via.placeholder.com/400x300/533483/ffffff?text=Tank+Bag', 'Rynox', 4.4),
(5, 'Handlebar Phone Mount',
   'Universal smartphone mount with 360-degree rotation and vibration damper.',
   799.00, 300, 'https://via.placeholder.com/400x300/e94560/ffffff?text=Phone+Mount', 'SP Connect', 4.5),
(5, 'Chain Lube Spray',
   'Advanced PTFE chain lubricant. Reduces wear, repels water and dirt.',
   399.00, 500, 'https://via.placeholder.com/400x300/1a1a2e/ffffff?text=Chain+Lube', 'Motul', 4.7),

(6, 'Tinted Racing Visor',
   'Smoked racing visor with anti-scratch coating. Fits most open-face helmets.',
   999.00, 150, 'https://via.placeholder.com/400x300/16213e/ffffff?text=Tinted+Visor', 'Vega', 4.3),
(6, 'Iridium Mirror Visor',
   'Gold iridium mirror-finish visor with 100% UV protection. Fits most full-face helmets.',
   1799.00, 100, 'https://via.placeholder.com/400x300/0f3460/ffffff?text=Mirror+Visor', 'AGV', 4.6),
(6, 'Riding Goggles Vintage',
   'Retro leather-frame goggles with polycarbonate UV400 lens. Ideal for cruisers.',
   1499.00, 80, 'https://via.placeholder.com/400x300/533483/ffffff?text=Riding+Goggles', 'Cramster', 4.4);
