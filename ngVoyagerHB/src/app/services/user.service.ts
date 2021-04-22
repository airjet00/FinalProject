import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private baseUrl: string = "http://localhost:8090/";
  private url = environment.baseUrl + "api/users/";

  constructor( private http: HttpClient,
    private authService: AuthService
    ) { }


  index(): Observable<User[]> {
    return this.http.get<User[]>(this.url, this.credentials()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError("Error getting user list" + err);
      })
    );
  }

  show(id): Observable<User>{
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
