-- Este script se ejecuta automáticamente al iniciar el contenedor por primera vez

USE cafeland_db;

CREATE TABLE suppliers (
    id VARCHAR(50) PRIMARY KEY, 
    company_name VARCHAR(100) NOT NULL,
    phone VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE supplies (
    id VARCHAR(50) PRIMARY KEY, 
    supply_name VARCHAR(100) NOT NULL,
    current_stock INT NOT NULL DEFAULT 0,
    unit VARCHAR(10) NOT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id VARCHAR(50) PRIMARY KEY, 
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    price DOUBLE NOT NULL,
    category VARCHAR(20) NOT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    total_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    order_id INT NOT NULL,
    product_id VARCHAR(50) NOT NULL, 
    quantity INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(id) -- Sigue funcionando el FK
);



INSERT INTO suppliers (id, company_name, phone) VALUES
('PROV-101', 'Distribuidora del Centro', '4421112233'),
('PROV-102', 'Café Quillá de Querétaro', '4425556677');

INSERT INTO supplies (id, supply_name, current_stock, unit) VALUES
('INS-101', 'Café en Grano Coatepec', 5000, 'gr'),
('INS-102', 'Leche Entera Santa Clara', 12, 'L'),
('INS-103', 'Jarabe de Vainilla', 1500, 'ml');

INSERT INTO products (id, name, description, price, category) VALUES
('PROD-1', 'Café Americano', 'Bebida elaborada con granos de altura', 35.0, 'Bebidas'),
('PROD-2', 'Capuccino Frapé', 'Café espresso con leche espumada y hielo', 48.5, 'Bebidas'),
('PROD-3', 'Pastel de Tres Leches', 'Rebanada de pastel húmedo tradicional', 45.0, 'Postres');

INSERT INTO orders (id, total_price, status) VALUES
(1, 70.00, 'ENTREGADO'),
(2, 93.50, 'PENDIENTE');

INSERT INTO order_items (order_id, product_id, quantity, subtotal) VALUES
(1, 'PROD-1', 2, 70.00),
(2, 'PROD-1', 1, 35.00), 
(2, 'PROD-2', 1, 48.50);