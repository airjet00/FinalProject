import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Country } from '../models/country';

@Injectable({
  providedIn: 'root'
})
export class CountryService {

  private url = environment.baseUrl + 'countries';

  constructor(private http: HttpClient, private router: Router) { }

  index(): Observable<Country[]> {
    return this.http.get<Country[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('CountryService.index(): error retrieving countries: ' + err);
      })
    );

  };
}
