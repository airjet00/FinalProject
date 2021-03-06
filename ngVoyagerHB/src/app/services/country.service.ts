import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Country } from '../models/country';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class CountryService {

  private baseUrl = environment.baseUrl;
  private url = environment.baseUrl + 'countries';

  constructor(private http: HttpClient, private authService: AuthService) { }

  index(): Observable<Country[]> {
    return this.http.get<Country[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('CountryService.index(): error retrieving countries: ' + err);
      })
    );
  };

  search(keyword: String): Observable<Country[]> {
    return this.http.get<Country[]>(this.url + '/search/' + keyword).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('CountryService.search(): error retrieving countries: ' + err);
      })
    );
  };

  show(countryId): Observable<Country> {
    return this.http.get<Country>(this.url + '/' + countryId).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('CountryService.show(): error retrieving country: ' + err);
      })
    );

  };

  create(country: Country) {
    let httpOptions = this.credentials();

    return this.http.post<Country>(this.baseUrl + "api/countries", country, httpOptions)
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('CountryService.create(): error creating country: ' + err);
      })
    );

  };

  update(country: Country) {
    let httpOptions = this.credentials();

    return this.http.put<Country>(this.baseUrl +'api/countries/'+ country.id, country, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('CountryService.update(): error updating country: ' + err);
      })
    );
  }

  destroy(id)  {
    let httpOptions = this.credentials();
    let restEndpoint : string = this.baseUrl + "api/countries/" + id;
    console.warn(restEndpoint);

    return this.http.delete<void>(restEndpoint, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('CountryService.destroy(): error deleting country: ' + err);
      })
    );


  }

  private credentials() {
    // Make credentials
    const credentials = this.authService.getCredentials();
    // Send credentials as Authorization header (this is spring security convention for basic auth)
    let httpOptions = {
      headers: new HttpHeaders({
        'Authorization': `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    }
    return httpOptions;
  }

}
