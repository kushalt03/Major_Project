-- Roles
INSERT INTO ROLES (role_id, role_name, access_level) VALUES
(1, 'System Administrator', 99),
(2, 'Attending Physician', 50),
(3, 'Head Nurse', 40),
(4, 'Billing Clerk', 30),
(5, 'Lab Technician', 20),
(6, 'Pharmacist', 35);

-- HOSPITAL_DEPARTMENTS
INSERT INTO HOSPITAL_DEPARTMENTS (dept_id, dept_name, dept_head_id, dept_type, cost_center_code, is_clinical) VALUES
(1, 'Cardiology', NULL, 'Clinical', 'CC01', TRUE),
(2, 'Administration', NULL, 'Administrative', 'CC02', FALSE),
(3, 'ICU', NULL, 'Clinical', 'CC03', TRUE),
(4, 'Laboratory Services', NULL, 'Ancillary', 'CC04', TRUE),
(5, 'Pharmacy', NULL, 'Ancillary', 'CC05', FALSE),
(6, 'General Surgery', NULL, 'Clinical', 'CC06', TRUE);

-- STAFF (1001-1007 used for clarity)
INSERT INTO STAFF (staff_id, first_name, last_name, staff_type, username, password_hash, role_id, dept_id, contact_no, email, date_of_joining, is_active) VALUES
(1001, 'Dr. Aris', 'Volkov', 'Doctor', 'avolkov', 'hashed123', 2, 1, '9876543210', 'aris.v@hosp.com', '2015-01-15', TRUE),
(1002, 'Nurse Jane', 'Doe', 'Nurse', 'jdoe', 'hashed456', 3, 3, '9988776655', 'jane.d@hosp.com', '2018-05-20', TRUE),
(1003, 'Mr. Sam', 'Smith', 'Admin', 'ssmith', 'hashed789', 4, 2, '9000111222', 'sam.s@hosp.com', '2020-11-01', TRUE),
(1004, 'Dr. Elara', 'Rios', 'Doctor', 'erios', 'hashedabc', 2, 6, '8765432109', 'elara.r@hosp.com', '2021-09-10', TRUE),
(1005, 'Ms. Kiera', 'Patel', 'Technician', 'kpatel', 'hasheddef', 5, 4, '7654321098', 'kiera.p@hosp.com', '2022-03-05', TRUE),
(1006, 'Dr. Ben', 'Chang', 'Doctor', 'bchang', 'hashedghi', 2, 1, '7778889990', 'ben.c@hosp.com', '2019-04-12', TRUE),
(1007, 'Pharmacist', 'Liu', 'Clerical', 'fliu', 'hashedjkl', 6, 5, '6665554443', 'frank.l@hosp.com', '2023-08-15', TRUE);


-- DOCTORS
INSERT INTO DOCTORS (staff_id, license_number, specialization_id, opd_consultation_fee, is_attending, is_on_call) VALUES
(1001, 'MD-1001A', 1, 500.00, TRUE, FALSE), -- Cardiology
(1004, 'MD-1004B', 6, 750.00, TRUE, TRUE),  -- Surgery
(1006, 'MD-1006C', 1, 500.00, FALSE, FALSE); -- Cardiology

-- HOSPITAL_ROOMS
INSERT INTO HOSPITAL_ROOMS (room_id, room_number, room_type, unit_type, daily_charge, is_occupied, isolation_status) VALUES
(1, '301A', 'Single', 'Ward', 3000.00, TRUE, FALSE),
(2, 'ICU-1', 'ICU', 'ICU', 15000.00, TRUE, FALSE),
(3, '205', 'Twin', 'Ward', 1500.00, FALSE, FALSE),
(4, '402', 'Single', 'Ward', 3000.00, FALSE, TRUE),
(5, 'OPD-1', 'Single', 'Ward', 0.00, FALSE, FALSE);

-- NURSES
INSERT INTO NURSES (staff_id, grade, ward_assignment_id, certifications) VALUES
(1002, 'Level III', 2, 'ACLS, PALS');

-- STAFF_SCHEDULE (Ensure multiple shifts and types are covered)
INSERT INTO STAFF_SCHEDULE (staff_id, shift_date, start_time, end_time, duty_location, is_leave) VALUES
(1001, CURDATE(), '09:00:00', '17:00:00', 'Cardiology Clinic', FALSE),
(1002, CURDATE(), '19:00:00', '07:00:00', 'ICU-1', FALSE),
(1004, CURDATE(), '10:00:00', '18:00:00', 'OR 2', FALSE),
(1005, CURDATE() + INTERVAL 1 DAY, '08:00:00', '16:00:00', 'Lab Main', FALSE);

-- Update Department Heads (Deferred FKs)
UPDATE HOSPITAL_DEPARTMENTS SET dept_head_id = 1001 WHERE dept_id = 1; -- Dr. Volkov (Cardiology)
UPDATE HOSPITAL_DEPARTMENTS SET dept_head_id = 1004 WHERE dept_id = 6; -- Dr. Rios (Surgery)


-- -----------------------------------------------------
-- 2. Master Patient Index (EHR Core)
-- -----------------------------------------------------

-- PATIENT (MPID 1: IPD/ICU Patient, MPID 2: OPD Patient, MPID 3: Surgical Patient)
INSERT INTO PATIENT (mpid, first_name, last_name, dob, gender, contact_no, national_id, primary_address, insurance_policy_no, pcp_doctor_id) VALUES
(1, 'Elias', 'Vance', '1975-04-20', 'Male', '5551234567', 'NID12345', '45 Ocean Dr, City A', 'INS998877', 1001),
(2, 'Lila', 'Chen', '1990-08-15', 'Female', '5559876543', 'NID67890', '789 Elm St, City B', NULL, 1006),
(3, 'Mark', 'Tewks', '1962-11-05', 'Male', '5553332221', 'NID00112', '10 Willow Ave, City C', 'INS445566', 1004);

-- PATIENT_ALLERGIES
INSERT INTO PATIENT_ALLERGIES (mpid, substance_name, allergy_code, reaction, severity, recorded_date, recorded_by_staff_id) VALUES
(1, 'Penicillin', 'SNOMED123', 'Anaphylaxis', 'Severe', CURDATE(), 1001),
(2, 'Dust Mites', NULL, 'Rhinitis', 'Mild', CURDATE(), 1004),
(3, 'Latex', 'SNOMED456', 'Contact Dermatitis', 'Moderate', CURDATE(), 1004);

-- ICD_MASTER
INSERT INTO ICD_MASTER (icd_code, description, category) VALUES
('I21.9', 'Acute myocardial infarction, unspecified', 'Cardiology'),
('J45.909', 'Unspecified asthma, uncomplicated', 'Pulmonology'),
('Z00.00', 'Encounter for general adult medical examination', 'Screening'),
('K35.80', 'Acute appendicitis, unspecified', 'Gastroenterology'),
('R51', 'Headache', 'Neurology');

-- PATIENT_HISTORY
INSERT INTO PATIENT_HISTORY (mpid, history_type, icd_code, description, recorded_date) VALUES
(1, 'Chronic Condition', 'I21.9', 'History of previous heart attack 5 years ago.', '2020-05-01'),
(2, 'Chronic Condition', 'J45.909', 'Childhood asthma, managed.', '2005-01-01'),
(3, 'Past Surgical', 'K35.80', 'Emergency Appendectomy 10 years ago.', '2015-08-10');


-- -----------------------------------------------------
-- 3. Patient Encounters (Service Points)
-- -----------------------------------------------------

-- ENCOUNTER (101: Elias IPD/ICU, 102: Lila OPD, 103: Mark Surgical IPD)
INSERT INTO ENCOUNTER (encounter_id, mpid, encounter_type, start_datetime, end_datetime, attending_doctor_id, admitting_staff_id, primary_diagnosis_code, billing_status) VALUES
(101, 1, 'ICU', NOW() - INTERVAL 2 DAY, NULL, 1001, 1002, 'I21.9', 'Open'), -- Elias: Ongoing ICU stay
(102, 2, 'OPD', NOW() - INTERVAL 1 HOUR, NOW() - INTERVAL 30 MINUTE, 1006, 1003, 'R51', 'Closed'), -- Lila: Headache consult
(103, 3, 'IPD', NOW() - INTERVAL 1 DAY, NULL, 1004, 1003, 'K35.80', 'Open'); -- Mark: Surgical admission

-- OPD_APPOINTMENTS
INSERT INTO OPD_APPOINTMENTS (appointment_id, encounter_id, mpid, scheduled_date, time_slot, status, chief_complaint, exam_room) VALUES
(1, 102, 2, CURDATE(), '10:30:00', 'Completed', 'Severe, throbbing headache for 3 days.', 'R12');

-- IPD_ADMISSIONS
INSERT INTO IPD_ADMISSIONS (ipd_id, encounter_id, mpid, admission_reason, admitting_dept_id, assigned_room_id, bed_number, expected_discharge_date) VALUES
(1, 103, 3, 'Post-operative recovery from Cholecystectomy.', 6, 1, '301A-Bed1', CURDATE() + INTERVAL 5 DAY);

-- ICU_STAYS
INSERT INTO ICU_STAYS (icu_stay_id, encounter_id, mpid, icu_start_time, icu_end_time, ventilator_status, daily_score, nurse_to_patient_ratio) VALUES
(1, 101, 1, NOW() - INTERVAL 2 DAY, NULL, 'Invasive', 15.25, 1.0);


-- -----------------------------------------------------
-- 4. Clinical, Pharmacy, and Financial Data
-- -----------------------------------------------------

-- VITAL_SIGNS (Multiple measurements for ICU patient)
INSERT INTO VITAL_SIGNS (encounter_id, mpid, staff_id, measurement_time, temperature, heart_rate, blood_pressure, spo2, pain_score, gcs_score) VALUES
(101, 1, 1002, NOW() - INTERVAL 6 HOUR, 37.1, 95, '110/70', 98.5, 0, 15),
(101, 1, 1002, NOW() - INTERVAL 1 HOUR, 36.8, 88, '118/75', 99.0, 0, 15),
(103, 3, 1002, NOW() - INTERVAL 3 HOUR, 37.5, 92, '125/80', 97.0, 4, 15);

-- CLINICAL_NOTES
INSERT INTO CLINICAL_NOTES (encounter_id, mpid, author_staff_id, note_type, note_content, note_timestamp, is_signed, signed_by_staff_id) VALUES
(101, 1, 1001, 'Progress Note', 'Patient remains sedated on ventilator. Hemodynamics stable. Awaiting cath lab clearance.', NOW(), TRUE, 1001),
(102, 2, 1006, 'H&P', 'Mild tension headache, likely stress-related. Advised OTC analgesics.', NOW() - INTERVAL 30 MINUTE, TRUE, 1006),
(103, 3, 1004, 'Operative Note', 'Cholecystectomy successfully completed. Patient transferred to ward, incision clean.', NOW() - INTERVAL 1 DAY, TRUE, 1004);

-- DIAGNOSES
INSERT INTO DIAGNOSES (diagnosis_id, encounter_id, mpid, icd_code, diagnosis_type, date_of_diagnosis) VALUES
(1, 101, 1, 'I21.9', 'Primary', CURDATE() - INTERVAL 2 DAY),
(2, 102, 2, 'R51', 'Primary', CURDATE()),
(3, 103, 3, 'K35.80', 'Admission', CURDATE() - INTERVAL 1 DAY);

-- MEDICATIONS
INSERT INTO MEDICATIONS (med_code, med_name, generic_name, unit_cost, stock_level, reorder_point, expiry_date) VALUES
(501, 'Aspirin 81mg', 'Acetylsalicylic Acid', 1.50, 5000, 500, '2027-01-01'),
(502, 'Propofol 10mg/mL', 'Propofol', 120.00, 100, 20, '2026-06-01'),
(503, 'IV Dextrose 5%', 'Glucose', 50.00, 2000, 50, '2025-12-31');

-- PRESCRIPTIONS
INSERT INTO PRESCRIPTIONS (encounter_id, mpid, prescribing_staff_id, med_code, dosage, frequency, route, start_date, end_date, dispensed_quantity) VALUES
(101, 1, 1001, 502, '100mg/hr', 'Continuous Infusion', 'IV', CURDATE() - INTERVAL 2 DAY, NULL, 20),
(103, 3, 1004, 503, '1000 mL', 'Every 8 Hours', 'IV', CURDATE() - INTERVAL 1 DAY, CURDATE() + INTERVAL 2 DAY, 3);

-- LAB_ORDERS
INSERT INTO LAB_ORDERS (order_id, encounter_id, mpid, ordering_staff_id, order_datetime, test_code, status, priority, specimen_id) VALUES
(201, 101, 1, 1001, NOW() - INTERVAL 12 HOUR, 'CARDIAC_ENZ', 'Processing', 'STAT', 'S99887'),
(202, 102, 2, 1006, NOW() - INTERVAL 45 MINUTE, 'CBC', 'Completed', 'Routine', 'S99888'),
(203, 103, 3, 1004, NOW() - INTERVAL 1 DAY, 'LFT', 'Completed', 'Routine', 'S99889');

-- LAB_RESULTS
INSERT INTO LAB_RESULTS (result_id, order_id, result_value, unit, normal_range, is_abnormal, result_text, verified_staff_id, result_datetime) VALUES
(1, 202, 'Hgb: 14.5', 'g/dL', '13.5-17.5', FALSE, 'CBC WNL.', 1005, NOW() - INTERVAL 15 MINUTE),
(2, 203, 'ALT: 80', 'U/L', '10-40', TRUE, 'Liver function tests are mildly elevated post-op.', 1005, NOW() - INTERVAL 6 HOUR);

-- SERVICE_RATES
INSERT INTO SERVICE_RATES (rate_id, service_code, service_name, standard_charge, insurance_group_charge) VALUES
(301, 'IPD_SINGLE', 'Single Room Daily Charge', 3000.00, 2500.00),
(302, 'ICU_DAILY', 'ICU Bed Daily Charge', 15000.00, 12000.00),
(303, 'LAB_CBC', 'Complete Blood Count', 250.00, 200.00),
(304, 'PROC_VENT', 'Ventilator Usage (Per Day)', 10000.00, 8000.00),
(305, 'SURG_CHOL', 'Laparoscopic Cholecystectomy', 50000.00, 45000.00),
(306, 'MED_PROPOFOL', 'Propofol Infusion (Daily Dose)', 2000.00, 1800.00);


-- BILLING_TRANSACTIONS (Elias ICU, Mark Surgical IPD, Lila OPD)
INSERT INTO BILLING_TRANSACTIONS (encounter_id, mpid, service_rate_id, item_quantity, unit_price_at_time, transaction_amount, billed_to, is_paid, recorded_by_staff_id) VALUES
-- Elias (ICU 101) - 2 days ICU, 2 days Ventilator, Propofol charge
(101, 1, 302, 2, 15000.00, 30000.00, 'Insurance', FALSE, 1003),
(101, 1, 304, 2, 10000.00, 20000.00, 'Insurance', FALSE, 1003),
(101, 1, 306, 2, 2000.00, 4000.00, 'Insurance', FALSE, 1003),
-- Mark (IPD 103) - Surgery, 1 Day Bed, IV Fluid
(103, 3, 305, 1, 50000.00, 50000.00, 'Insurance', FALSE, 1003),
(103, 3, 301, 1, 3000.00, 3000.00, 'Insurance', FALSE, 1003),
(103, 3, 503, 3, 50.00, 150.00, 'Patient', FALSE, 1003),
-- Lila (OPD 102) - Doctor consult + Lab (Paid in full)
(102, 2, 303, 1, 250.00, 250.00, 'Patient', TRUE, 1003),
(102, 2, 306, 1, 500.00, 500.00, 'Patient', TRUE, 1003); -- Using doctor rate 500

-- PAYMENTS (Lila paid cash for OPD)
INSERT INTO PAYMENTS (encounter_id, mpid, payment_method, payment_amount, received_by_staff_id) VALUES
(102, 2, 'Cash', 750.00, 1003); -- 250 (Lab) + 500 (Consult)

-- INSURANCE_CLAIMS (Mark and Elias claims)
INSERT INTO INSURANCE_CLAIMS (claim_id, encounter_id, mpid, insurance_policy_no, claim_submission_date, claim_status) VALUES
(1, 101, 1, 'INS998877', NOW() - INTERVAL 1 DAY, 'Submitted'),
(2, 103, 3, 'INS445566', NOW(), 'Processing');
