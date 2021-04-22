import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Picture } from '../models/picture';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class PictureService {

  private baseUrl = environment.baseUrl;

  private url: string;

  constructor(private http: HttpClient,
    private authService: AuthService, private router: Router) { }

  index(cid: number): Observable<Picture[]> {
    this.url = `${this.baseUrl}countries/${cid}/pictures`;

    return this.http.get<Picture[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('PictureService.index(): error retrieving pictures: ' + err);
      })
    );
  }

  create(cid: number, data: Picture) {
    this.url = `${this.baseUrl}countries/${cid}/pictures`
    let httpOptions = this.credentials();
    return this.http.post<Picture>(this.url, data, httpOptions)
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('PictureService.create(): error creating picture: ' + err);
      })
    );
  };

  update(cid: number, picture: Picture) {
    this.url = `${this.baseUrl}countries/${cid}/pictures`
    let httpOptions = this.credentials();
    return this.http.put<Picture>(this.url +'/'+ picture.id, picture, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('PictureService.update(): error updating picture: ' + err);
      })
    );
  }

  destroy(cid: number, id: number)  {
    this.url = `${this.baseUrl}countries/${cid}/pictures`
    let httpOptions = this.credentials();
    return this.http.delete<void>(this.url +'/'+ id, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('PictureService.destroy(): error destroying picture: ' + err);
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
