import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Country } from 'src/app/models/country';
import { CountryService } from 'src/app/services/country.service';

@Component({
  selector: 'app-country-list',
  templateUrl: './country-list.component.html',
  styleUrls: ['./country-list.component.css']
})
export class CountryListComponent implements OnInit {

  countries: Country[] = null;

  constructor(private countryServ: CountryService, private router: Router) { }

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


}
