import { Component, OnInit } from '@angular/core';
import { CommentService } from 'src/app/services/comment.service';
import { Comment } from 'src/app/models/comment';
import { Country } from 'src/app/models/country';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { User } from 'src/app/models/user';

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

  updateComment: Comment = new Comment();

  commentForDeletion: Comment = null;



  //////// init:
  constructor(private router: Router, private authService: AuthService, private commentServ: CommentService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.countryId = +this.route.snapshot.paramMap.get('countryId');
    this.loadComments();

    this.createComment = new Comment();
    // this.country = new Country();
    // this.country.id = this.countryId
    // this.createComment.country = this.country;

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

  prepareUpdate(comment): void {
    console.warn("** in component, prepareUpdate()");
    console.warn("** comment.id = "+ comment.id);


    this.updateComment = comment;
  }

  confirmUpdate() {
    console.warn("** in component, confirmUpdate()");
    console.warn("** this.updateComment.id = "+ this.updateComment.id);
    // console.warn("***************************\nthis.updateComment.user is" + this.updateComment.user.id + " " + this.updateComment.user.firstName);

    this.commentServ.update(this.updateComment, this.countryId).subscribe(
      dataReceived => {
        this.updateComment = dataReceived;
        this.updateComment = new Comment();
      },
      failure => {
        console.error(failure);
      });;
  }


  create(): void {

    this.commentServ.create(this.countryId, this.createComment).subscribe(
      dataReceived => {
        this.createCommentResult = dataReceived;
        this.createComment = new Comment();
        this.loadComments();
      },
      failure => {
        console.error(failure);
      });
  }


  delete(comment : Comment) : void {
    this.commentForDeletion = comment;
    this.commentServ.delete(this.countryId, this.commentForDeletion.id).subscribe(
      dataReceived => {
        this.commentForDeletion = null;
      },
      failure => {
        console.error(failure);
      });

  }


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
