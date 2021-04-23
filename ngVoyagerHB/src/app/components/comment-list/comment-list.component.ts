import { Component, OnInit } from '@angular/core';
import { CommentService } from 'src/app/services/comment.service';
import { Comment } from 'src/app/models/comment';
import { Country } from 'src/app/models/country';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { CountryService } from 'src/app/services/country.service';
import { AdviceType } from 'src/app/models/advice-type';
import { Picture } from 'src/app/models/picture';

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

  // createComment: Comment = new Comment();
  createCommentResult: Comment;

  updateComment: Comment = new Comment();

  commentForDeletion: Comment = null;


  ///////////////////

  role: string = null;
  username: string = null;
  countries: Country[] = null;
  selected: Country = null;
  newCountry: Country = new Country();
  editCountry: Country = null;
  keyword: String = null;
  pictures: Picture[] = null;
  advice: AdviceType[] = null;
  comments: Comment[] = null;
  commentEdit: Comment = null;
  commentIndex: number = null;
  responseEdit: Comment = null;
  responseIndex: number = null;
  createComment: Comment = new Comment();

  //////// init:
  constructor(private router: Router, private authService: AuthService, private commentServ: CommentService, private route: ActivatedRoute, private countryServ: CountryService) { }

  ngOnInit(): void {
    this.countryId = +this.route.snapshot.paramMap.get('countryId');

    this.username = localStorage.getItem("username");
    console.warn(this.username);


    // this.loadComments();
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

  confirmUpdate() {
    console.warn("** in component, confirmUpdate()");
    console.warn("** this.updateComment.id = " + this.updateComment.id);
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


  loadCountries() {
    this.countryServ.index().subscribe(
      data => {
        this.countries = data;
      },
      err => console.error('loadCountries got an error: ' + err)
    )
  }

  selectCountry(country: Country) {
    this.selected = country;
    this.router.navigateByUrl('countries/' + country.id)
  }

  showCountry(cid) {
    this.countryServ.show(cid).subscribe(
      data => {
        this.selected = data;
        this.pictures = data["pictures"]
        this.advice = data["adviceTypes"]
        // this.loadComments(cid);
      },
      err => console.error('showCountries got an error: ' + err)
    )
  }

  loadComments1(cid) {

    this.commentServ.index(cid).subscribe(
      data => {
        this.comments = data;
      },
      err => console.error('showCountries got an error: ' + err)
    )
  }

  back() {
    this.selected = null;
    this.router.navigateByUrl('countries')
  }



  cancel() {
    this.editCountry = null;
  }


  private loginCheck() {
    if (!this.authService.checkLogin) {
      this.router.navigateByUrl('/home');
    }
  }

  editComment(comment: Comment, i) {
    // this.commentEdit = comment;
    // this.commentIndex = i;

  }

  editResponse(comment: Comment, i) {
    // this.responseEdit = comment;
    // this.responseIndex = i;
  }

  saveEdit(comment: Comment) {
    let cid = +this.route.snapshot.paramMap.get('cid');
    this.commentServ.update(comment, cid).subscribe(
      data => {
        this.showCountry(cid);
        // this.commentEdit=null;
        // this.responseEdit=null;
      },
      fail => {
        console.error('CountryListComponent.editComment() failed:');
        console.error(fail);
      }
    )
  }

  saveNewComment(comment: Comment) {
    let cid = +this.route.snapshot.paramMap.get('cid');
    this.commentServ.create(cid, comment).subscribe(
      data => {
        this.showCountry(cid);
        this.createComment = new Comment();
      },
      fail => {
        console.error('CountryListComponent.editComment() failed:');
        console.error(fail);
      }
    )
  }

  deleteComment(id: number) {
    console.log(id);

    let cid = +this.route.snapshot.paramMap.get('cid');
    this.commentServ.delete(cid, id).subscribe(
      data => {
        this.showCountry(cid);
      },
      fail => {
        console.error('CountryListComponent.deleteComment() failed:');
        console.error(fail);
      }
    )
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
