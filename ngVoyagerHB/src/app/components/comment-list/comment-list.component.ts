import { Component, OnInit } from '@angular/core';
import { CommentService } from 'src/app/services/comment.service';
import { Comment } from 'src/app/models/comment';

@Component({
  selector: 'app-comment-list',
  templateUrl: './comment-list.component.html',
  styleUrls: ['./comment-list.component.css']
})
export class CommentListComponent implements OnInit {

//////// init:
  constructor(private commentServ : CommentService) { }

  ngOnInit(): void {
  }

//////// fields:
comments : Comment[] = null;


//////// CRUD:

loadComments() {
  this.commentServ.index().subscribe(
    data => {
      this.comments = data;
      return data;
    },
    failure => {
      console.error("JournalArticleComponent.loadJournals() failed: ");
      console.error(failure);
    });
  return null;
}


}
