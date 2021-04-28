import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-admin-dashboard',
  templateUrl: './admin-dashboard.component.html',
  styleUrls: ['./admin-dashboard.component.css']
})
export class AdminDashboardComponent implements OnInit {

  viewCountries: boolean;
  viewUsers: boolean;
  featureCountriesDisplay: string = "initial";


  constructor() { }

  ngOnInit(): void {
  }

  manageCountries() : void {
    this.viewCountries = true;
    this.viewUsers = false;
  }

  manageUsers() : void {
    this.viewCountries = false;
    this.viewUsers = true;
  }

  // Method for feat countries display
  toggleFeatPage(){
    if (this.featureCountriesDisplay === "initial") {
      this.featureCountriesDisplay = "hidden";

    }
  }

}
