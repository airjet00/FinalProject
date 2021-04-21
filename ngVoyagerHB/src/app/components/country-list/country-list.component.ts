import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Country } from 'src/app/models/country';
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

  constructor(private countryServ: CountryService, private router: Router, private authService: AuthService) { }

  ngOnInit(): void {
    this.loadCountries();
  }

  loadCountries(){
    this.countryServ.index().subscribe(
      data => {
        this.countries = data;
      },
      err => console.error('loadCountries got an error: ' + err)
    )
  }

  showCountry(country: Country) {
    this.selected = country;
    console.log(this.selected);

    this.router.navigateByUrl('countries/' + country.id)
  }

  back() {
    this.selected = null;
  }

  searchCountry(){

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
