import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Trip } from '../models/trip';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class TripService {

  // private baseUrl: string = "http://localhost:8090/";
  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + "api/trips/";

  constructor(
    private authSvc: AuthService,
    private http: HttpClient,
    private route: ActivatedRoute,
    private router: Router
    ) { }


  index(): Observable<Trip[]> {
    // Only allow Logged in users to be on trips page
    if(!this.authSvc.checkLogin()){
      this.router.navigateByUrl("login");
    }

    let credentials = this.authSvc.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        'Authorization': `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };

    return this.http.get<Trip[]>(this.url, httpOptions)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('A problem occurred.');
        })
      );
  }

  show(tid: string): Observable<Trip> {

    if(!this.authSvc.checkLogin()){
      this.router.navigateByUrl("login");
    }

    let credentials = this.authSvc.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        'Authorization': `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };

    return this.http.get<Trip>(this.url + tid, httpOptions)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        })
      );
  }

  create(trip: Trip): Observable<Trip> {

    if(!this.authSvc.checkLogin()){
      this.router.navigateByUrl("login");
    }

    let credentials = this.authSvc.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        'content-Type': 'application/json',
        'Authorization': `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };

    return this.http.post<Trip>(this.url, trip, httpOptions)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }

  update(trip: Trip): Observable<Trip> {

    if(!this.authSvc.checkLogin()){
      this.router.navigateByUrl("login");
    }

    let credentials = this.authSvc.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        'content-Type': 'application/json',
        'Authorization': `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };

    return this.http.put<Trip>(this.url + trip.id, trip, httpOptions)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }

  delete(tid: number): Observable<Object> {

    if(!this.authSvc.checkLogin()){
      this.router.navigateByUrl("login");
    }

    let credentials = this.authSvc.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        'Authorization': `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };

    return this.http.delete(this.url + tid, httpOptions)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }
}
