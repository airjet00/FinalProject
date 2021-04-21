import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private baseUrl: string = "http://localhost:8090/";
  private url = environment.baseUrl + "api/user/";

  constructor( private http: HttpClient) { }

  index(): Observable<User[]> {
    return this.http.get<User[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError("Error getting user list" + err);
      })
    );
  }

  show(id: String): Observable<User>{
    return this.http.get<User>(this.url + id).pipe(
      catchError((err: any) =>{
        console.log();
        return throwError("Error getting user" + err);

      })
    );
  }
  create(user: User): Observable<User>{
    return this.http.post<User>(this.url, user).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError("Error creating user " + err);
      })
    );
  }

  update(user: User): Observable<User> {
    return this.http.put<User>(this.url + user.id, user).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError("Error updating user " +err);
      })
    );
  }

  delete(id: number) {
    return this.http.delete<User>(this.url + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError("Error deleting user " + err);
      })
    );
  }
}
