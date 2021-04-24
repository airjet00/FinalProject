import { Component, OnInit } from '@angular/core';
import { CommentService } from 'src/app/services/comment.service';
import { Comment } from 'src/app/models/comment';
import { Country } from 'src/app/models/country';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { CountryService } from 'src/app/services/country.service';

@Component({
  selector: 'app-comment-list',
  templateUrl: './comment-list.component.html',
  styleUrls: ['./comment-list.component.css']
})
export class CommentListComponent implements OnInit {

  //////// fields:
  countryId: number;
  country: Country;

  // comments: Comment[] = null;
  showComment: Comment;

  createCommentResult: Comment;

  updateComment: Comment = new Comment();

  commentForDeletion: Comment = null;

  ///////////////////

  role: string = null;
  username: string = null;

  comments: Comment[];
  commentIndex: number = null;

  createComment: Comment = new Comment();
  commentEdit: Comment = null;

  responseEdit: Comment = null;
  responseIndex: number = null;

  //////// init:
  constructor(private router: Router, private authService: AuthService, private commentServ: CommentService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.countryId = +this.route.snapshot.paramMap.get('cid');

    this.username = localStorage.getItem("username");

    this.loadComments();

    // this.createComment = new Comment();
    // this.country = new Country();
    // this.country.id = this.countryId
    // this.createComment.country = this.country;
    // this.role = localStorage.getItem("userRole");


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
    console.warn("** comment.id = " + comment.id);


    this.updateComment = comment;
  }

  // confirmUpdate() {
  //   console.warn("** in component, confirmUpdate()");
  //   console.warn("** this.updateComment.id = " + this.updateComment.id);
  //   // console.warn("***************************\nthis.updateComment.user is" + this.updateComment.user.id + " " + this.updateComment.user.firstName);

  //   this.commentServ.update(this.updateComment, this.countryId).subscribe(
  //     dataReceived => {
  //       this.updateComment = dataReceived;
  //       this.updateComment = new Comment();
  //     },
  //     failure => {
  //       console.error(failure);
  //     });;
  // }

///////////////////// CREATE
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

////////////////////////

  delete(comment: Comment): void {
    this.commentForDeletion = comment;
    this.commentServ.delete(this.countryId, this.commentForDeletion.id).subscribe(
      dataReceived => {
        this.commentForDeletion = null;
      },
      failure => {
        console.error(failure);
      });

  }


  /////////////////////////////

  private loginCheck() {
    if (!this.authService.checkLogin) {
      this.router.navigateByUrl('/home');
    }
  }

  // editComment(comment: Comment, i) {
  //   // this.commentEdit = comment;
  //   // this.commentIndex = i;

  // }

  // editResponse(comment: Comment, i) {
  //   // this.responseEdit = comment;
  //   // this.responseIndex = i;
  // }

  // saveEdit(comment: Comment) {
  //   let cid = +this.route.snapshot.paramMap.get('cid');
  //   this.commentServ.update(comment, cid).subscribe(
  //     data => {
  //       this.showCountry(cid);
  //       // this.commentEdit=null;
  //       // this.responseEdit=null;
  //     },
  //     fail => {
  //       console.error('CountryListComponent.editComment() failed:');
  //       console.error(fail);
  //     }
  //   )
  // }


  // deleteComment(id: number) {
  //   console.log(id);

  //   let cid = +this.route.snapshot.paramMap.get('cid');
  //   this.commentServ.delete(cid, id).subscribe(
  //     data => {
  //       this.showCountry(cid);
  //     },
  //     fail => {
  //       console.error('CountryListComponent.deleteComment() failed:');
  //       console.error(fail);
  //     }
  //   )
  // }
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
