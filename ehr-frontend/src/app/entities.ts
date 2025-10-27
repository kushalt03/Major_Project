// This interface mirrors the PatientModel.java entity for type safety in Angular.
export interface PatientModel {
  mpid: number;
  firstName: string;
  lastName: string;
  dob: string | null; // Use string for form input/output of date type
  gender: 'Male' | 'Female' | 'Other' | 'Unknown';
  contactNo: string;
  email: string;
  nationalId: string;
  primaryAddress: string;
  insurancePolicyNo: string;
  pcpDoctorId: number | null; // Maps to Integer FK in Java
  creationTimestamp?: string;
  lastUpdated?: string;
}
