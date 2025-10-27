/// <reference types="jasmine" />
import { TestBed } from '@angular/core/testing';
import { AppComponent } from './app.component';
import { PatientFormComponent } from './PatientDetails/PatientDetails.component';
import { ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

describe('AppComponent', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [
        AppComponent,           // ✅ Standalone component imported
        PatientFormComponent,    // ✅ Standalone child component
        ReactiveFormsModule,    // Required for formGroup
        CommonModule            // Required for *ngIf
      ]
    }).compileComponents();
  });

  it('should create the app', () => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.componentInstance;
    expect(app).toBeTruthy();
  });

  it(`should have the title 'Patient Management'`, () => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.componentInstance;
    expect(app.title).toEqual('Patient Management');
  });

  it('should render the title in an h1 tag', () => {
    const fixture = TestBed.createComponent(AppComponent);
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('h1')?.textContent).toContain('Patient Management System');
  });
});
