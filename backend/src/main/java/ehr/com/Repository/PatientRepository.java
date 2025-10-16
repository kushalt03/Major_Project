package ehr.com.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ehr.com.Model.PatientModel;

@Repository
public interface PatientRepository extends JpaRepository<PatientModel, Integer> {
    // You can add custom finders if needed later
    // Example: Optional<PatientModel> findByNationalId(String nationalId);
}
