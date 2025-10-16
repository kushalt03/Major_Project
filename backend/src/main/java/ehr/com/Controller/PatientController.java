package ehr.com.Controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ehr.com.Model.PatientModel;
import ehr.com.Repository.PatientRepository;

@RestController
@RequestMapping("/api/patients")
@CrossOrigin(origins = "http://localhost:4200")
public class PatientController {

    private final PatientRepository patientRepository;

    @Autowired
    public PatientController(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    // CREATE / SUBMIT
    @PostMapping("/submit")
    public PatientModel submitPatient(@RequestBody PatientModel patient) {
        patient.setCreationTimestamp(LocalDateTime.now());
        patient.setLastUpdated(LocalDateTime.now());
        return patientRepository.save(patient);
    }

    // READ ALL
    @GetMapping
    public List<PatientModel> getAllPatients() {
        return patientRepository.findAll();
    }

    // READ ONE
    @GetMapping("/{id}")
    public Optional<PatientModel> getPatientById(@PathVariable Integer id) {
        return patientRepository.findById(id);
    }

    // UPDATE
    @PutMapping("/{id}")
    public PatientModel updatePatient(@PathVariable Integer id, @RequestBody PatientModel updatedPatient) {
        return patientRepository.findById(id).map(existing -> {
            existing.setFirstName(updatedPatient.getFirstName());
            existing.setLastName(updatedPatient.getLastName());
            existing.setDob(updatedPatient.getDob());
            existing.setGender(updatedPatient.getGender());
            existing.setContactNo(updatedPatient.getContactNo());
            existing.setEmail(updatedPatient.getEmail());
            existing.setNationalId(updatedPatient.getNationalId());
            existing.setPrimaryAddress(updatedPatient.getPrimaryAddress());
            existing.setInsurancePolicyNo(updatedPatient.getInsurancePolicyNo());
            existing.setPcpDoctorId(updatedPatient.getPcpDoctorId());
            existing.setLastUpdated(LocalDateTime.now());
            return patientRepository.save(existing);
        }).orElseThrow(() -> new RuntimeException("Patient not found with id " + id));
    }

    // DELETE
    @DeleteMapping("/{id}")
    public String deletePatient(@PathVariable Integer id) {
        if (patientRepository.existsById(id)) {
            patientRepository.deleteById(id);
            return "Patient deleted successfully";
        } else {
            return "Patient not found";
        }
    }
}
