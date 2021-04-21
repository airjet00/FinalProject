import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Trip } from '../models/trip';

@Injectable({
  providedIn: 'root'
})
export class TripService {

  private baseUrl: string = "http://localhost:8090/";
  private url = environment.baseUrl + "api/trips/";

  constructor(private http: HttpClient) { }


  index(): Observable<Trip[]> {
    return this.http.get<Trip[]>(this.url)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('A problem occurred.');
        })
      );
  }

  show(tid: string): Observable<Trip> {
    return this.http.get<Trip>(this.url + tid)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        })
      );
  }

  create(trip: Trip): Observable<Trip> {
    return this.http.post<Trip>(this.url, trip)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }

  update(trip: Trip): Observable<Trip> {
    return this.http.put<Trip>(this.url + trip.id, trip)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }

  delete(tid: number): Observable<Object> {
    return this.http.delete(this.url + tid)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }
}
