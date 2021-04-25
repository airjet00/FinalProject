import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Country } from 'src/app/models/country';
import { CountryService } from 'src/app/services/country.service';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit {

  keyword: String;
  countries: Country[];
  chosenCountry: Country;
  searchResults: Country[];
  noneFound: boolean;

  constructor(private countryServ: CountryService, private router: Router) { }

  ngOnInit(): void {
    this.loadCountries();
  }

  loadCountries() {
    this.countryServ.index().subscribe(
      data => {
        this.countries = data;
      },
      err => console.error('loadCountries got an error: ' + err)
    )
  }
  searchCountry() {
    this.countryServ.search(this.keyword).subscribe(
      data => {
        this.searchResults = data;
        console.warn(this.searchResults);

        if (this.searchResults.length===0)
 {this.noneFound = true;}      },
      err => console.error('loadCountries got an error: ' + err)
    )
  }

  chooseCountry() {
    console.warn(this.chosenCountry);
    let url: string = '/countries/' + this.chosenCountry.id;
    this.router.navigate([url]);
  }

}
