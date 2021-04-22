import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Comment } from '../models/comment';
import { AuthService } from './auth.service';


@Injectable({
  providedIn: 'root'
})
export class CommentService {

  private urlWithoutAPI = environment.baseUrl + "countries/";
  private urlWithAPI = environment.baseUrl + "api/countries/";

  comment : Comment;
  showComment : Comment = new Comment();

  constructor(private http: HttpClient, private authServ : AuthService) { }


  index(countryId : number): Observable<Comment[]> {
    return this.http.get<Comment[]>(this.urlWithoutAPI + countryId + "/comments")
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('A problem occurred.');
        })
      );
  }

  show(cid : number) {
    return this.http.get<Comment>(this.urlWithAPI + cid, this.credentials())
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        })
      );
  }
  create(countryId : number, comment: Comment): Observable<Comment> {
    //endpoint:  api/countries/3/comments/
    return this.http.post<Comment>(this.urlWithAPI + countryId + "/comments", comment, this.credentials())
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }

  update(comment: Comment): Observable<Comment> {
    return this.http.put<Comment>(this.urlWithAPI + comment.id, comment, this.credentials())
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }

  delete(cid: number): Observable<Object> {
    return this.http.delete(this.urlWithAPI + cid, this.credentials())
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }


  private credentials() {
    // Make credentials
    const credentials = this.authServ.getCredentials();
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
