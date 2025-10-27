import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PatientFormComponent } from './PatientDetails/PatientDetails.component';

@Component({
  selector: 'app-root',
//   standalone: true,
  imports: [CommonModule, PatientFormComponent],
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'Patient Management';

  onFormSubmitted(patientData: any) {
    console.log('Patient form submitted:', patientData);
  }
}
