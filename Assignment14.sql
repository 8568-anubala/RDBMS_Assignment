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
VALUES (1, 2, '2024-08-01', '2025-08-01');--error
  
SELECT c.first_name, c.last_name, p.policy_title, a.first_name AS agent_first_name, a.last_name AS agent_last_name
FROM Customers c
JOIN PolicyAssignments pa ON c.customer_id = pa.customer_id
JOIN Policies p ON pa.policy_id = p.policy_id
JOIN Agents a ON p.policy_id = a.agent_id; --error
  
SELECT cl.claim_id, cl.claim_date, cl.claim_amount, p.policy_title
FROM Claims cl
JOIN Policies p ON cl.policy_id = p.policy_id;--error
  
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

 

 
 