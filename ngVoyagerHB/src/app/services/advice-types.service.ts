import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { AdviceType } from '../models/advice-type';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class AdviceTypesService {

  private baseUrl = environment.baseUrl;

  private url: string;

  constructor(private http: HttpClient,
    private authService: AuthService, private router: Router) { }

  index(cid: number): Observable<AdviceType[]> {
    this.url = `${this.baseUrl}countries/${cid}/adviceTypes`;

    return this.http.get<AdviceType[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('AdviceTypeService.index(): error retrieving advice: ' + err);
      })
    );
  }

  create(cid: number, data: AdviceType) {
    this.url = `${this.baseUrl}countries/${cid}/adviceTypes`
    let httpOptions = this.credentials();
    return this.http.post<AdviceType>(this.url, data, httpOptions)
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('AdviceTypeService.create(): error creating advice: ' + err);
      })
    );
  };

  update(cid: number, advice: AdviceType) {
    this.url = `${this.baseUrl}countries/${cid}/adviceTypes`
    let httpOptions = this.credentials();
    return this.http.put<AdviceType>(this.url +'/'+ advice.id, advice, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('AdviceTypeService.update(): error updating advice: ' + err);
      })
    );
  }

  destroy(cid: number, id: number)  {
    this.url = `${this.baseUrl}countries/${cid}/adviceTypes`
    let httpOptions = this.credentials();
    return this.http.delete<void>(this.url +'/'+ id, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('AdviceTypeService.destroy(): error destroying advice: ' + err);
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
