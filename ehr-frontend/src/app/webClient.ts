import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class WebClientService {
  private baseUrl = 'http://localhost:5000/api/patients';

  constructor(private http: HttpClient) {}

  // Submit patient
  submitPatient(patient: any): Observable<any> {
    return this.http.post(`${this.baseUrl}/submit`, patient);
  }

  // Other APIs
  getAllPatients(): Observable<any> {
    return this.http.get(this.baseUrl);
  }

  getPatientById(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/${id}`);
  }

  updatePatient(id: number, patient: any): Observable<any> {
    return this.http.put(`${this.baseUrl}/${id}`, patient);
  }

  deletePatient(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/${id}`);
  }
}
