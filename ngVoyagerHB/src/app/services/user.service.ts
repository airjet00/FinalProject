import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  // private baseUrl: string = "http://localhost:8090/";
  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + "api/users/";

  constructor(
    private http: HttpClient,
    private authSvc: AuthService,
    private route: ActivatedRoute,
    private router: Router
    ) { }

  index(): Observable<User[]> {
    return this.http.get<User[]>(this.url, this.credentials()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError("Error getting user list" + err);
      })
    );
  }

  showByUsername(username: string): Observable<User>{

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

    return this.http.get<User>((this.url + "search/" + username), httpOptions).pipe(
      catchError((err: any) =>{
        console.log();
        return throwError("Error getting user" + err);
      })
    );
  }

  show(id: number): Observable<User>{
    return this.http.get<User>(this.url + id, this.credentials()).pipe(
      catchError((err: any) =>{
        console.log();
        return throwError("Error getting user" + err);

      })
    );
  }
  create(user: User): Observable<User>{
    return this.http.post<User>(this.url, user, this.credentials()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError("Error creating user " + err);
      })
    );
  }

  update(user: User): Observable<User> {
    return this.http.put<User>(this.url + user.id, user, this.credentials()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError("Error updating user " +err);
      })
    );
  }

  delete(id: number) {
    console.log(id + "**************************************");

    return this.http.delete<User>(this.url + id, this.credentials()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError("Error deleting user " + err);
      })
    );
  }

  private credentials() {
    // Make credentials
    const credentials = this.authSvc.getCredentials();
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
