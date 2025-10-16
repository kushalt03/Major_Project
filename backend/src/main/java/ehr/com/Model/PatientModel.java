package ehr.com.Model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "patient")
public class PatientModel implements Serializable {

    private static final long serialVersionUID = 1L;

    public enum Gender {
        Male, Female, Other, Unknown
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "mpid")
    private Integer mpid;

    @JsonProperty("firstName")
    @Column(name = "first_name", nullable = false, length = 50)
    private String firstName;

    @JsonProperty("lastName")
    @Column(name = "last_name", nullable = false, length = 50)
    private String lastName;

    @JsonProperty("dob")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Column(name = "dob", nullable = false)
    private LocalDate dob;

    @JsonProperty("gender")
    @Enumerated(EnumType.STRING)
    @Column(name = "gender")
    private Gender gender;

    @JsonProperty("contactNo")
    @Column(name = "contact_no", length = 15)
    private String contactNo;

    @JsonProperty("email")
    @Column(name = "email", length = 100)
    private String email;

    @JsonProperty("nationalId")
    @Column(name = "national_id", unique = true, length = 50)
    private String nationalId;

    @JsonProperty("primaryAddress")
    @Column(name = "primary_address", length = 255)
    private String primaryAddress;

    @JsonProperty("insurancePolicyNo")
    @Column(name = "insurance_policy_no", length = 50)
    private String insurancePolicyNo;

    @JsonProperty("pcpDoctorId")
    @Column(name = "pcp_doctor_id")
    private Integer pcpDoctorId;

    @Column(name = "creation_timestamp", updatable = false)
    private LocalDateTime creationTimestamp;

    @Column(name = "last_updated")
    private LocalDateTime lastUpdated;

    public PatientModel() {}

    // Getters and Setters
    public Integer getMpid() { return mpid; }
    public void setMpid(Integer mpid) { this.mpid = mpid; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }

    public Gender getGender() { return gender; }
    public void setGender(Gender gender) { this.gender = gender; }

    public String getContactNo() { return contactNo; }
    public void setContactNo(String contactNo) { this.contactNo = contactNo; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getNationalId() { return nationalId; }
    public void setNationalId(String nationalId) { this.nationalId = nationalId; }

    public String getPrimaryAddress() { return primaryAddress; }
    public void setPrimaryAddress(String primaryAddress) { this.primaryAddress = primaryAddress; }

    public String getInsurancePolicyNo() { return insurancePolicyNo; }
    public void setInsurancePolicyNo(String insurancePolicyNo) { this.insurancePolicyNo = insurancePolicyNo; }

    public Integer getPcpDoctorId() { return pcpDoctorId; }
    public void setPcpDoctorId(Integer pcpDoctorId) { this.pcpDoctorId = pcpDoctorId; }

    public LocalDateTime getCreationTimestamp() { return creationTimestamp; }
    public void setCreationTimestamp(LocalDateTime creationTimestamp) { this.creationTimestamp = creationTimestamp; }

    public LocalDateTime getLastUpdated() { return lastUpdated; }
    public void setLastUpdated(LocalDateTime lastUpdated) { this.lastUpdated = lastUpdated; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof PatientModel)) return false;
        PatientModel that = (PatientModel) o;
        return Objects.equals(mpid, that.mpid);
    }

    @Override
    public int hashCode() {
        return Objects.hash(mpid);
    }

    @Override
    public String toString() {
        return "PatientModel{" +
                "mpid=" + mpid +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                '}';
    }
}
