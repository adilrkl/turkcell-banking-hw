-- DDL
CREATE TABLE authors(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL
);

CREATE TABLE categories(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE books(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    page INTEGER,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    author_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE book_copies(
    id SERIAL PRIMARY KEY,
    book_id INTEGER NOT NULL,
    status VARCHAR(50) DEFAULT 'available', -- available, borrowed
    FOREIGN KEY (book_id) REFERENCES books(id)
);

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    user_type VARCHAR(50) NOT NULL, -- student, staff
    address TEXT,
    gsm VARCHAR(20),
    school_number VARCHAR(50)
);

CREATE TABLE transaction(
    id SERIAL PRIMARY KEY,
    borrower_id INTEGER NOT NULL,
    book_copies_id INTEGER NOT NULL,
    processed_by_id INTEGER NOT NULL,
    start_date DATE NOT NULL DEFAULT CURRENT_DATE,
    end_date DATE NOT NULL,
    status INTEGER DEFAULT 0, -- 0 = Good (İyi durumda), 1 = Worn (Yıpranmış)
    return_date DATE,
    FOREIGN KEY (borrower_id) REFERENCES users(id),
    FOREIGN KEY (book_copies_id) REFERENCES book_copies(id),
    FOREIGN KEY (processed_by_id) REFERENCES users(id)
);

ALTER TABLE transaction ADD COLUMN penalty_amount DECIMAL(10,2) DEFAULT 0;


-- DML
INSERT INTO authors (name, surname) VALUES 
('Sabahattin', 'Ali'),
('George', 'Orwell'),
('J.K.', 'Rowling'),
('İlber', 'Ortaylı'),
('Dostoyevski', 'Fyodor');

INSERT INTO categories (name) VALUES 
('Roman'),
('Bilim Kurgu'),
('Tarih'),
('Fantastik'),
('Klasik');

INSERT INTO books (name, page, isbn, author_id, category_id) VALUES 
('Kürk Mantolu Madonna', 160, '9789753638029', 1, 1),
('1984', 352, '9789750718533', 2, 2),
('Harry Potter Felsefe Taşı', 274, '9789750802942', 3, 4),
('Türklerin Tarihi', 288, '9786050819263', 4, 3),
('Suç ve Ceza', 687, '9789754580645', 5, 5);

INSERT INTO book_copies (book_id, status) VALUES 
(1, 'available'),
(1, 'borrowed'),
(2, 'borrowed'),
(3, 'available'),
(4, 'available'),
(5, 'borrowed');

INSERT INTO users (name, surname, user_type, address, gsm, school_number) VALUES 
('Ahmet', 'Yılmaz', 'staff', 'Kütüphane Ofisi', '+905551112233', NULL),
('Ayşe', 'Kaya', 'staff', 'Kütüphane Ofisi', '+905552223344', NULL),
('Ali', 'Veli', 'student', 'Öğrenci Yurdu', '+905321112233', '1001'),
('Fatma', 'Demir', 'student', 'Ev Adresi 1', '+905331112233', '1002'),
('Mehmet', 'Çelik', 'student', 'Ev Adresi 2', '+905441112233', '1003'),
('Hilal', 'Yıldız', 'student', 'Öğrenci Yurdu 2', '+905329998877', '1004');

INSERT INTO transaction (borrower_id, book_copies_id, processed_by_id, start_date, end_date, status, return_date, penalty_amount) VALUES 
(3, 2, 1, '2026-04-01', '2026-04-15', 0, '2026-04-14', 0),    -- Zamanında teslim
(4, 3, 2, '2026-04-05', '2026-04-20', 1, '2026-04-25', 10.50), -- Geç teslim ve yıpranmış kitap (status 1)
(5, 6, 1, '2026-04-10', '2026-04-25', 0, NULL, 0),             -- Henüz teslim edilmedi
(6, 1, 2, '2026-04-12', '2026-04-26', 0, '2026-04-20', 0),
(3, 4, 1, '2026-04-15', '2026-04-30', 0, NULL, 0);

UPDATE users SET gsm = '+905000000000' WHERE id = 6;
UPDATE transaction SET penalty_amount = 5.00 WHERE return_date IS NULL AND end_date < CURRENT_DATE;

-- Yanlış kategori ekleme ve silme işlemi
INSERT INTO categories (name) VALUES ('Turkcell');
DELETE FROM categories WHERE name = 'Turkcell';


-- SELECT, LIKE, AGGREGATE
SELECT * FROM books;

SELECT id, name FROM users;

SELECT * FROM users WHERE user_type = 'student' ORDER BY id DESC;

SELECT COUNT(*) FROM books;

SELECT MAX(page) FROM books;

SELECT AVG(page) FROM books;

SELECT SUM(penalty_amount) FROM transaction;

SELECT * FROM users WHERE name LIKE 'H%';

SELECT * FROM users WHERE surname ILIKE '%il%';

SELECT * FROM books WHERE name LIKE '%a';

SELECT * FROM authors WHERE name LIKE '%i_';