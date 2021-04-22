import { Component, OnInit } from '@angular/core';
import { CommentService } from 'src/app/services/comment.service';
import { Comment } from 'src/app/models/comment';
import { Country } from 'src/app/models/country';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-comment-list',
  templateUrl: './comment-list.component.html',
  styleUrls: ['./comment-list.component.css']
})
export class CommentListComponent implements OnInit {

  //////// fields:
  countryId: number;
  country: Country;

  comments: Comment[] = null;
  showComment: Comment;

  createComment: Comment = new Comment();
  createCommentResult: Comment;

  //////// init:
  constructor(private router: Router, private authService: AuthService, private commentServ: CommentService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    console.warn("MADE IT INTO THE COMMENT-LIST COMPONENT");


    this.countryId = +this.route.snapshot.paramMap.get('countryId');
    console.warn(
      "In comment-list.component, ngOnInit, route variable countryId = " +
      +this.route.snapshot.paramMap.get('countryId')
      );

      this.createComment = new Comment();
      this.country = new Country();
      this.country.id = this.countryId
      this.createComment.country = this.country;

  }

  //////// CRUD:
  loadComments() {
    this.commentServ.index(this.countryId).subscribe(
      data => {
        this.comments = data;
        return data;
      },
      failure => {
        console.error(failure);
      });
    return null;
  }

  // show(form): void {
  //   let cid: number = form.cid.value;
  //   console.warn(cid);

  //   this.commentServ.show(cid).subscribe(
  //     dataReceived => {
  //       this.showComment = dataReceived;
  //     },
  //     failure => {
  //       console.error(failure);
  //     });
  // }

  create(): void {

    this.commentServ.create(this.countryId, this.createComment).subscribe(
      dataReceived => {
        this.createCommentResult = dataReceived;
        this.createComment = new Comment();
      },
      failure => {
        console.error(failure);
      });
  }

}
