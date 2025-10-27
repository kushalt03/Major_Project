import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ReactiveFormsModule } from '@angular/forms';
import { PatientFormComponent } from './PatientDetails.component';
import { WebClientService } from '../webClient';
import { of } from 'rxjs';

describe('PatientFormComponent', () => {
  let component: PatientFormComponent;
  let fixture: ComponentFixture<PatientFormComponent>;
  let mockWebClient: jasmine.SpyObj<WebClientService>;

  beforeEach(() => {
    mockWebClient = jasmine.createSpyObj('WebClientService', ['submitPatient']);

    TestBed.configureTestingModule({
      imports: [ReactiveFormsModule],
      declarations: [PatientFormComponent],
      providers: [{ provide: WebClientService, useValue: mockWebClient }]
    }).compileComponents();

    fixture = TestBed.createComponent(PatientFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should submit valid form', () => {
    component.patientForm.setValue({
      firstName: 'John',
      lastName: 'Doe',
      dob: '1990-01-01',
      gender: 'Male',
      contactNo: '1234567890',
      email: 'john@example.com',
      nationalId: 'N1234',
      primaryAddress: '123 Street',
      insurancePolicyNo: 'POL123',
      pcpDoctorId: 1
    });

    mockWebClient.submitPatient.and.returnValue(of({ message: 'Success' }));

    component.onSubmit();

    expect(mockWebClient.submitPatient).toHaveBeenCalled();
    expect(component.responseMessage).toBe('Patient saved successfully!');
  });
});
