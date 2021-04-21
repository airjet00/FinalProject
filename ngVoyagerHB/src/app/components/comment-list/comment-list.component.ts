import { Component, OnInit } from '@angular/core';
import { CommentService } from 'src/app/services/comment.service';
import { Comment } from 'src/app/models/comment';
import { Country } from 'src/app/models/country';

@Component({
  selector: 'app-comment-list',
  templateUrl: './comment-list.component.html',
  styleUrls: ['./comment-list.component.css']
})
export class CommentListComponent implements OnInit {

  //////// fields:
  comments : Comment[] = null;
  showComment : Comment;

  createComment : Comment = new Comment();
  createCommentResult: Comment;

//////// init:
  constructor(private commentServ : CommentService) { }

  ngOnInit(): void {
    this.createComment = new Comment();
    this.createComment.country = new Country();
  }

//////// CRUD:

loadComments() {
  this.commentServ.index().subscribe(
    data => {
      this.comments = data;
      return data;
    },
    failure => {
      console.error(failure);
    });
  return null;
}

show(form) : void {
  let cid : number = form.cid.value;
  console.warn(cid);

  this.commentServ.show(cid).subscribe(
    dataReceived => {
      this.showComment = dataReceived;
    },
    failure => {
      console.error(failure);
    });
}

create() : void {
  // Presumably "create comment" can only be accessed
  // through a country's page, so will have to think
  // about how to actually pass the country value.
  // Currently HARDCODED for testing:
  // FIXME /////////////////////////
  let c : Country = new Country();
  c.id = 1;
  this.createComment.country = c;
  // FIXME /////////////////////////


  this.commentServ.create(this.createComment).subscribe(
    dataReceived => {
      this.createCommentResult = dataReceived;
      this.createComment = new Comment();
    },
    failure => {
      console.error(failure);
    });
}

}
