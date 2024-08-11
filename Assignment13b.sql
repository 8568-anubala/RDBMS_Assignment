  CREATE TABLE Customers (
    customer_id  Serial PRIMARY KEY  ,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender  Varchar NOT NULL,
    contact_number VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL
);
 
 CREATE TABLE Policies (
    policy_id  serial PRIMARY KEY  ,
    policy_name VARCHAR(100) NOT NULL,
    policy_type Varchar NOT NULL,
    coverage_details TEXT NOT NULL,
    premium DECIMAL(10, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);
 
 CREATE TABLE Claims (
    claim_id  serial PRIMARY KEY  ,
    claim_date DATE NOT NULL,
    claim_amount DECIMAL(10, 2) NOT NULL,
    approved_amount DECIMAL(10, 2),
    claim_status  Varchar NOT NULL,
    policy_id INT NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (policy_id) REFERENCES Policies(policy_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
 
 CREATE TABLE Agents (
    agent_id  serial PRIMARY KEY  ,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    contact_number VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    hire_date DATE NOT NULL
);
 
 CREATE TABLE PolicyAssignments (
    assignment_id serial PRIMARY KEY  ,
    customer_id INT NOT NULL,
    policy_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (policy_id) REFERENCES Policies(policy_id)
);
 
 CREATE TABLE ClaimProcessing (
    processing_id serial PRIMARY KEY  ,
    claim_id INT NOT NULL,
    processing_date DATE NOT NULL,
    payment_amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (claim_id) REFERENCES Claims(claim_id)
);

select*from claimprocessing;

ALTER TABLE Agents ADD COLUMN department VARCHAR(50);

 ALTER TABLE Policies  change policy_name policy_title VARCHAR(100);//error
 
 ALTER TABLE Customers DROP COLUMN address;
 
 UPDATE Policies SET premium = 1500.00 WHERE policy_id = 1;

DELETE FROM Claims WHERE claim_id = 10;
 INSERT INTO PolicyAssignments (customer_id, policy_id, start_date, end_date)
VALUES (1, 2, '2024-08-01', '2025-08-01');
  
SELECT c.first_name, c.last_name, p.policy_title, a.first_name AS agent_first_name, a.last_name AS agent_last_name
FROM Customers c
JOIN PolicyAssignments pa ON c.customer_id = pa.customer_id
JOIN Policies p ON pa.policy_id = p.policy_id
JOIN Agents a ON p.policy_id = a.agent_id;
  
SELECT cl.claim_id, cl.claim_date, cl.claim_amount, p.policy_title
FROM Claims cl
JOIN Policies p ON cl.policy_id = p.policy_id;
  
SELECT cl.claim_id, cl.claim_date, cl.claim_amount, c.first_name, c.last_name
FROM Claims cl
JOIN Customers c ON cl.customer_id = c.customer_id;
  
SELECT p.policy_type, COUNT(cl.claim_id) AS number_of_claims, SUM(cl.claim_amount) AS total_claim_amount
FROM Claims cl
JOIN Policies p ON cl.policy_id = p.policy_id
GROUP BY p.policy_type;
  
SELECT c.customer_id, c.first_name, c.last_name, MAX(cl.claim_date) AS most_recent_claim
FROM Claims cl
JOIN Customers c ON cl.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;


CREATE TABLE insurance_db.Customers (
customer_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
contact_number VARCHAR(15),
date_of_birth DATE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE insurance_db.Agents (
agent_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
contact_number VARCHAR(15),
hire_date DATE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE insurance_db.Policies (
policy_id SERIAL PRIMARY KEY,
policy_name VARCHAR(100) NOT NULL,
coverage_details TEXT,
premium NUMERIC(10, 2) NOT NULL,
	policy_type VARCHAR(50),
start_date DATE,
end_date DATE,
customer_id INT REFERENCES insurance_db.Customers(customer_id),
agent_id INT REFERENCES insurance_db.Agents(agent_id),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE insurance_db.Claims (
claim_id SERIAL PRIMARY KEY,
claim_date DATE NOT NULL,
claim_amount NUMERIC(10, 2) NOT NULL,
status VARCHAR(50) DEFAULT 'Pending',
policy_id INT REFERENCES insurance_db.Policies(policy_id),
description TEXT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- This table manages the many-to-many relationship between Customers and Policies.
CREATE TABLE insurance_db.PolicyAssignments (
assignment_id SERIAL PRIMARY KEY,
customer_id INT REFERENCES insurance_db.Customers(customer_id),
policy_id INT REFERENCES insurance_db.Policies(policy_id),
start_date DATE,
end_date DATE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 INSERT INTO insurance_db.Customers (first_name, last_name, email, contact_number,
date_of_birth) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', '1985-01-15'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '1990-07-22'),
('Michael', 'Johnson', 'michael.johnson@example.com', '555-9876', '1983-02-14'),
('Emily', 'Davis', 'emily.davis@example.com', '555-4321', '1975-12-30'),
('David', 'Wilson', 'david.wilson@example.com', '555-6789', '1988-05-20'),
('Olivia', 'Brown', 'olivia.brown@example.com', '555-3456', '1995-09-15'),
('James', 'Jones', 'james.jones@example.com', '555-6543', '1982-11-25'),
('Sophia', 'Garcia', 'sophia.garcia@example.com', '555-8765', '1993-03-10'),
('Robert', 'Martinez', 'robert.martinez@example.com', '555-3456', '1979-06-14'),
('Isabella', 'Lopez', 'isabella.lopez@example.com', '555-6543', '1992-08-24');
INSERT INTO insurance_db.Agents (first_name, last_name, email, contact_number, hire_date)
VALUES
('Alice', 'Green', 'alice.green@example.com', '555-1111', '2010-06-01'),
('Bob', 'White', 'bob.white@example.com', '555-2222', '2012-07-15'),
('Charlie', 'Black', 'charlie.black@example.com', '555-3333', '2014-09-10'),
('Diana', 'Red', 'diana.red@example.com', '555-4444', '2011-03-21'),
('Edward', 'Blue', 'edward.blue@example.com', '555-5555', '2013-11-05');
INSERT INTO insurance_db.Policies (policy_name, coverage_details, premium, policy_type,
start_date, end_date, customer_id, agent_id) VALUES
('Health Protect', 'Comprehensive health coverage', 500.00, 'Health', '2024-01-01', '2025-01-01',
1, 1),
('Auto Secure', 'Car insurance with full coverage', 800.00, 'Auto', '2024-02-01', '2025-02-01', 2,
2),
 
 ('Home Shield', 'Home insurance against fire and theft', 1200.00, 'Home', '2024-03-01',
'2025-03-01', 3, 3),
('Life Guard', 'Life insurance with critical illness rider', 1500.00, 'Life', '2024-04-01', '2025-04-01',
4, 4),
('Travel Safe', 'Travel insurance with medical and baggage cover', 200.00, 'Travel', '2024-05-01',
'2025-05-01', 5, 5),
('Pet Protect', 'Insurance for pets against illness and injury', 300.00, 'Pet', '2024-06-01',
'2025-06-01', 6, 1),
('Health Shield', 'Basic health insurance coverage', 400.00, 'Health', '2024-07-01', '2025-07-01',
7, 2),
('Auto Protect', 'Car insurance with theft protection', 600.00, 'Auto', '2024-08-01', '2025-08-01', 8,
3),
('Home Secure', 'Home insurance with earthquake coverage', 1400.00, 'Home', '2024-09-01',
'2025-09-01', 9, 4),
('Life Secure', 'Life insurance with accidental death cover', 1300.00, 'Life', '2024-10-01',
'2025-10-01', 10, 5);
INSERT INTO insurance_db.Claims (claim_date, claim_amount, status, policy_id, description)
VALUES
('2024-07-15', 2500.00, 'Processed', 1, 'Medical expenses for surgery'),
('2024-08-05', 1500.00, 'Pending', 2, 'Car damage due to accident'),
('2024-09-10', 3500.00, 'Rejected', 3, 'Fire damage to home'),
('2024-10-20', 2000.00, 'Processed', 4, 'Critical illness treatment'),
('2024-11-25', 500.00, 'Pending', 5, 'Lost luggage during travel'),
('2024-12-12', 700.00, 'Processed', 6, 'Vet bills for pet injury'),
('2024-01-03', 400.00, 'Pending', 7, 'Outpatient treatment'),
('2024-02-15', 1000.00, 'Processed', 8, 'Car theft'),
('2024-03-22', 2500.00, 'Rejected', 9, 'Home repairs after earthquake'),
('2024-04-18', 1200.00, 'Pending', 10, 'Accidental death claim');
 
 INSERT INTO insurance_db.PolicyAssignments (customer_id, policy_id, start_date, end_date)
VALUES
(1, 1, '2024-01-01', '2025-01-01'),
(2, 2, '2024-02-01', '2025-02-01'),
(3, 3, '2024-03-01', '2025-03-01'),
(4, 4, '2024-04-01', '2025-04-01'),
(5, 5, '2024-05-01', '2025-05-01'),
(6, 6, '2024-06-01', '2025-06-01'),
(7, 7, '2024-07-01', '2025-07-01'),
(8, 8, '2024-08-01', '2025-08-01'),
(9, 9, '2024-09-01', '2025-09-01'),
(10, 10, '2024-10-01', '2025-10-01');
 