import { Component, NgModule, OnInit } from '@angular/core';
import { Trip } from 'src/app/models/trip';
import { TripService } from 'src/app/services/trip.service';


@Component({
  selector: 'app-trips-sidebar',
  templateUrl: './trips-sidebar.component.html',
  styleUrls: ['./trips-sidebar.component.css']
})
export class TripsSidebarComponent implements OnInit {

  events: string[] = [];
  opened: boolean;

  isTripList: boolean = true;

  trips: Trip[] = [];
// Methods
  constructor( private tripSvc: TripService ) { }
  ngOnInit(): void {
    this.reloadTrips();
  }
  // shouldRun = [/(^|\.)plnkr\.co$/, /(^|\.)stackblitz\.io$/].some(h => h.test(window.location.host));
  // index
  reloadTrips(): void {
    this.tripSvc.index().subscribe(
      data => {this.trips = data},
      err => {console.error("Observer got an error: " + err)}
    )
  }


  toggleTrip(){
    this.isTripList = true;
  }
  toggleWish(){
    this.isTripList = false;
  }



}
