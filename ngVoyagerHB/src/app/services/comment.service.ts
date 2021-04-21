import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';
import { environment } from 'src/environments/environment.prod';
import { Comment } from '../models/comment';


@Injectable({
  providedIn: 'root'
})
export class CommentService {

  // private url: string = "http://localhost:8090/api/comments";

  private url = environment.baseUrl + "api/comments/";

  constructor(private http: HttpClient) { }


  index(): Observable<Comment[]> {
    return this.http.get<Comment[]>(this.url)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('A problem occurred.');
        })
      );
  }

  show(cid: string): Observable<Comment> {
    return this.http.get<Comment>(this.url + cid)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        })
      );
  }

  create(comment: Comment): Observable<Comment> {
    return this.http.post<Comment>(this.url, comment)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }

  update(comment: Comment): Observable<Comment> {
    return this.http.put<Comment>(this.url + comment.id, comment)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }

  delete(cid: number): Observable<Object> {
    return this.http.delete(this.url + cid)
      .pipe(
        catchError((err: any) => {
          return throwError(err);
        }
        )
      );
  }


}
