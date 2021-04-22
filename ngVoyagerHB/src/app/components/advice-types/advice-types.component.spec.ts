import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AdviceTypesComponent } from './advice-types.component';

describe('AdviceTypesComponent', () => {
  let component: AdviceTypesComponent;
  let fixture: ComponentFixture<AdviceTypesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AdviceTypesComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AdviceTypesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
