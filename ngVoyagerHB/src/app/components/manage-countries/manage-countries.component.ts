import { ThisReceiver } from '@angular/compiler';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AdviceType } from 'src/app/models/advice-type';
import { Country } from 'src/app/models/country';
import { Picture } from 'src/app/models/picture';
import { AuthService } from 'src/app/services/auth.service';
import { CommentService } from 'src/app/services/comment.service';
import { CountryService } from 'src/app/services/country.service';

@Component({
  selector: 'app-manage-countries',
  templateUrl: './manage-countries.component.html',
  styleUrls: ['./manage-countries.component.css']
})
export class ManageCountriesComponent implements OnInit {

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

  chosenCountry = new Country();
  viewEdit: boolean = false;
  viewAdd: boolean = false;
  viewDelete: boolean = false;
  deleteCountry: Country;
  addCountry: Country = new Country();
  deleteConfirmed: boolean = false;
  showCountryChanges: Country;
  countryToCreate: Country = new Country();

  constructor(private countryServ: CountryService, private router: Router, private authService: AuthService,
    private route: ActivatedRoute, private commentServ: CommentService) { }

  ngOnInit(): void {
    this.role = localStorage.getItem("userRole");
    this.username = localStorage.getItem("username");

    this.loadCountries();
    let cid = +this.route.snapshot.paramMap.get('cid');
    if (cid > 0) {
      this.showCountry(cid);
    }
  }

  loadCountries() {
    this.countryServ.index().subscribe(
      data => {
        this.countries = data;
      },
      err => console.error('loadCountries got an error: ' + err)
    )
  }

  selectEdit() { this.viewEdit = true; this.viewAdd = false; this.viewDelete = false; this.deleteConfirmed = false; this.showCountryChanges = null;}

  selectAdd() { this.viewAdd = true; this.viewEdit = false; this.viewDelete = false; this.deleteConfirmed = false; this.showCountryChanges = null;}

  selectDelete() { this.viewDelete = true; this.viewAdd = false; this.viewEdit = false; this.deleteConfirmed = false; this.showCountryChanges = null;}

  showCountry(cid) {
    this.countryServ.show(cid).subscribe(
      data => {
        this.selected = data;
        this.pictures = data["pictures"]
        this.advice = data["adviceTypes"]
        this.loadComments(cid);
      },
      err => console.error('showCountries got an error: ' + err)
    )
  }

  loadComments(cid) {

    this.commentServ.index(cid).subscribe(
      data => {
        // this.comments = data;
      },
      err => console.error('showCountries got an error: ' + err)
    )
  }

  back() {
    this.selected = null;
    this.router.navigateByUrl('countries')
  }

  searchCountry() {
    this.countryServ.search(this.keyword).subscribe(
      data => {
        this.countries = data;
      },
      err => console.error('loadCountries got an error: ' + err)
    )
  }

  addNewCountry() {
    this.loginCheck();
    this.countryServ.create(this.countryToCreate).subscribe(
      data => {
        this.loadCountries();
        this.countryToCreate = new Country();
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

  submitEdit() {

    let payload = new Country();
    payload.id = this.chosenCountry.id;
    payload.countryCode = this.chosenCountry.countryCode;
    payload.defaultImage = this.chosenCountry.defaultImage;
    payload.description = this.chosenCountry.description;
    payload.name = this.chosenCountry.name;

    this.countryServ.update(payload).subscribe(
      data => {
        this.showCountryChanges = payload;
        this.loadCountries();
        this.chosenCountry = new Country();
        this.viewEdit = false;
        payload = null;
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
    console.warn("in component, delete(), chosenCountry.name " + this.chosenCountry.name + "\nchosenCountry ID: " + this.chosenCountry.id);

    this.countryServ.destroy(this.chosenCountry.id).subscribe(
      data => {
        this.viewDelete = false;
        this.chosenCountry = null;
        this.deleteConfirmed = true;
        this.loadCountries();
      },
      fail => {
        console.error('CountryListComponent.deleteCountry() failed:');
        console.error(fail);
      }
    )
  }

  private loginCheck() {
    if (!this.authService.checkLogin) {
      this.router.navigateByUrl('/home');
    }
  }

}
