import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AdviceType } from 'src/app/models/advice-type';
import { Country } from 'src/app/models/country';
import { Picture } from 'src/app/models/picture';
import { AuthService } from 'src/app/services/auth.service';
import { CountryService } from 'src/app/services/country.service';


@Component({
  selector: 'app-country-list',
  templateUrl: './country-list.component.html',
  styleUrls: ['./country-list.component.css']
})
export class CountryListComponent implements OnInit {

  countries: Country[] = null;
  selected: Country = null;
  newCountry: Country = new Country();
  editCountry: Country = null;
  keyword: String = null;
  pictures: Picture[] = null;
  advice: AdviceType[] = null;
  comments: Comment[] = null;

  constructor(private countryServ: CountryService, private router: Router, private authService: AuthService,
    private route: ActivatedRoute) { }

  ngOnInit(): void {
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
        this.comments = data["comments"]
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

}
