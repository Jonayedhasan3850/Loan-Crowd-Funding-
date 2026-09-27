USE unifund_db;

-- SEED DATA

-- 1. Users (Roles: 1=Student, 2=Donor, 3=Admin | Status: 1=Active)
-- Password is 'password' for all
INSERT INTO users (user_id, email, password_hash, full_name, role_id, status_id) VALUES
(2, 'rahim@uiu.ac.bd', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Rahim Uddin', 1, 1),
(3, 'nusrat@buet.ac.bd', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Nusrat Jahan', 1, 1),
(4, 'karim@nsu.ac.bd', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Karim Ahmed', 1, 1),
(5, 'fatema@foundation.org', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Fatema Begum', 2, 1),
(6, 'tanvir@alumni.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Tanvir Ahmed', 2, 1);

-- 2. Student Profiles
INSERT INTO student_profiles (user_id, student_id_number, university, major, current_cgpa, credit_score) VALUES
(2, '011201001', 'United International University', 'Computer Science', 3.92, 750),
(3, '1905001', 'BUET', 'EEE', 3.85, 720),
(4, '213014042', 'North South University', 'BBA', 3.65, 680);

-- 3. Donor Profiles
INSERT INTO donor_profiles (user_id, donor_type_id, organization_name) VALUES
(5, 2, 'Grameen Foundation'),
(6, 2, 'BUET Alumni');

-- 4. Campaigns
-- Categories: 1=Education, 2=Medical, 3=Emergency, 4=Project
-- Statuses: 1=Draft, 2=Active, 3=Completed, 4=Rejected
INSERT INTO campaigns (campaign_id, student_id, category_id, status_id, title, description, goal_amount, start_date, end_date) VALUES
(1, 2, 4, 2, 'Solar Power for Rural Schools', 'Bringing electricity to education in remote areas.', 150000.00, '2025-01-01', '2025-06-30'),
(2, 3, 4, 3, 'AI in Agriculture', 'Detecting crop diseases using AI.', 50000.00, '2025-01-10', '2025-03-31');

-- 5. Loans
-- Statuses: 1=Pending, 2=Approved, 3=Active, 4=Defaulted, 5=Paid
INSERT INTO loans (loan_id, student_id, status_id, title, principal_amount, interest_rate, tenure_months, applied_at) VALUES
(1, 2, 1, 'Semester Tuition Fee', 50000.00, 5.00, 12, NOW()),
(2, 3, 3, 'Laptop Purchase', 85000.00, 5.00, 24, NOW());

-- 6. Loan Installments (for Loan 2 - Active)
INSERT INTO loan_installments (loan_id, due_date, installment_amount) VALUES
(2, DATE_ADD(NOW(), INTERVAL 1 MONTH), 3718.75),
(2, DATE_ADD(NOW(), INTERVAL 2 MONTH), 3718.75),
(2, DATE_ADD(NOW(), INTERVAL 3 MONTH), 3718.75);

-- 7. Transactions (History)
-- Loan 2 Disbursed (Money IN to Student 3)
INSERT INTO transactions (user_id, amount, created_at) VALUES (3, 85000.00, NOW()); 
-- (Optional: Add Subtype txn_disbursement if table existed, but we only have txn_donations/repayments. 
-- Wait, we don't have txn_disbursements table in schema! Just `transactions`. 
-- If we want to verify "Type", `get_transaction_history.php` checks if ID exists in subtype. 
-- If not in either, it shows "transaction". That's fine.)

-- Donation to Campaign 2 (Money OUT from Donor 5)
INSERT INTO transactions (transaction_id, user_id, amount) VALUES (100, 5, 5000.00);
INSERT INTO txn_donations (transaction_id, campaign_id, message, is_anonymous) VALUES (100, 2, 'Great work!', 0);

