import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AdviceType } from 'src/app/models/advice-type';
import { Country } from 'src/app/models/country';
import { Picture } from 'src/app/models/picture';
import { AuthService } from 'src/app/services/auth.service';
import { CommentService } from 'src/app/services/comment.service';
import { CountryService } from 'src/app/services/country.service';
import { Comment } from 'src/app/models/comment';


@Component({
  selector: 'app-country-list',
  templateUrl: './country-list.component.html',
  styleUrls: ['./country-list.component.css']
})
export class CountryListComponent implements OnInit {

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
  createResponse: Comment = new Comment();
  activeIndex: number = null;

  constructor(private countryServ: CountryService, private router: Router, private authService: AuthService,
    private route: ActivatedRoute, private commentServ: CommentService) { }

  ngOnInit(): void {
    this.role = localStorage.getItem("userRole");
    this.username = localStorage.getItem("username");

    this.loadCountries();
    let cid = +this.route.snapshot.paramMap.get('cid');
    if( cid > 0) {
    this.showCountry(cid);
    }
  }

  loadCountries(){
    this.countryServ.index().subscribe(
      data => {
        this.countries = data;
        this.countries = this.shuffleCountries(this.countries);
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
        this.pictures= data["pictures"]
        this.advice = data["adviceTypes"]
        this.loadComments(cid);
      },
      err => console.error('showCountries got an error: ' + err)
    )
  }

  loadComments(cid) {

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

  searchCountry(){
    this.countryServ.search(this.keyword).subscribe(
      data => {
        this.countries = data;
      },
      err => console.error('loadCountries got an error: ' + err)
    )
  }

  addNewCountry() {
    this.loginCheck();
    this.countryServ.create(this.newCountry).subscribe(
      data => {
        this.loadCountries();
      },
      fail => {
        console.error('CountryListComponent.createCountry() failed:');
        console.error(fail);
      }
    );
  }

  editLocation(country) {
    this.loginCheck();
    this.editCountry = country;
  }

  completeEdit() {
    this.countryServ.update(this.editCountry).subscribe(
      data => {
        this.loadCountries();
        this.editCountry=null;
      },
      fail => {
        console.error('CountryListComponent.updateCountry() failed:');
        console.error(fail);
      }
    )
  }

  cancel() {
    this.editCountry = null;
  }

  delete() {
    this.loginCheck();
    this.countryServ.destroy(this.editCountry.id).subscribe(
      data => {
        this.loadCountries();
        this.editCountry=null;
      },
      fail => {
        console.error('CountryListComponent.deleteCountry() failed:');
        console.error(fail);
      }
    )
  }

  private loginCheck() {
    if(!this.authService.checkLogin) {
      this.router.navigateByUrl('/home');
    }
  }

  editComment(comment: Comment, i) {
    this.commentEdit = comment;
    this.commentIndex = i;

  }

  editResponse(comment: Comment, i) {
    this.responseEdit = comment;
    this.responseIndex = i;
  }

  saveEdit(comment: Comment) {
    let cid = +this.route.snapshot.paramMap.get('cid');
    this.commentServ.update(comment, cid).subscribe(
      data => {
        this.showCountry(cid);
        this.commentEdit=null;
        this.responseEdit=null;
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
        this.createComment= new Comment();
      },
      fail => {
        console.error('CountryListComponent.editComment() failed:');
        console.error(fail);
      }
    )
  }

  saveNewResponse(comment: Comment, originalCommentId: number) {
    console.log(comment);
    console.log(originalCommentId);
    let ogComment = new Comment();
    ogComment.id = originalCommentId;

    let cid = +this.route.snapshot.paramMap.get('cid');
    comment.originalComment = ogComment;

    this.commentServ.create(cid, comment).subscribe(
      data => {
        this.showCountry(cid);
        this.createResponse= new Comment();
        this.activeIndex = null;
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

  addNewResponse(index) {
    if (this.activeIndex === index){
      this.activeIndex = null;
    }
    else{
      this.activeIndex = index;
    }

  }

  shuffleCountries(arrCountries : Country []) {
    let m = arrCountries.length, t, i;

    // While there remain elements to shuffle
    while (m) {
      // Pick a remaining element…
      i = Math.floor(Math.random() * m--);

      // And swap it with the current element.
      t = arrCountries[m];
      arrCountries[m] = arrCountries[i];
      arrCountries[i] = t;
    }

    return arrCountries;
  }
}
