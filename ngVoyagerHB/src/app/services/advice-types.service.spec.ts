import { TestBed } from '@angular/core/testing';

import { AdviceTypesService } from './advice-types.service';

describe('AdviceTypesService', () => {
  let service: AdviceTypesService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AdviceTypesService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
