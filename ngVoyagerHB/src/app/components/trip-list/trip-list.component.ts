import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Trip } from 'src/app/models/trip';
import { TripService } from 'src/app/services/trip.service';

@Component({
  selector: 'app-trip-list',
  templateUrl: './trip-list.component.html',
  styleUrls: ['./trip-list.component.css']
})
export class TripListComponent implements OnInit {

  trips: Trip[] = [];

  selected: Trip = null;

  newTrip: Trip = null;

  updatedTrip: Trip = null;

// Methods

  constructor(
    private tripSvc: TripService,
    private route: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit(): void {
    let tripId = this.route.snapshot.paramMap.get('tid')
    if(tripId){
      this.tripSvc.show(tripId).subscribe(
        todo => {
          this.selected = todo;
        },
        fail => {
          console.error('TodoListComp.ngOnInit failed to load todo');
          console.error(fail);
          this.router.navigateByUrl('notFound');
        }
      )
    }
    this.reloadTrips();
  }
// Crud Methods

  // index
  reloadTrips(): void {
    this.tripSvc.index().subscribe(
      data => {this.trips = data},
      err => {console.error("Observer got an error: " + err)}
    )
  }

  // create
  createTodo(){
    this.newTrip.completed = false;
    this.tripSvc.create(this.newTrip).subscribe(
      data => {
        this.selected = data;
        this.newTrip = null;
        this.reloadTrips();
      },
      err => {
        console.error('Observer got an error: ' + err);
      }
    )
  }

  // update
  updateTodo(updatedTrip:Trip, updateLocation?:String){
    this.tripSvc.update(updatedTrip).subscribe(
      data => {
        if(!updateLocation){
          this.selected = data;
        }
        this.updatedTrip = null;
        this.reloadTrips();
      },
      err => {
        console.error('Observer got an error: ' + err);
      }
    )
  }

  // delete
  deleteTodo(id:number){
    this.tripSvc.delete(id).subscribe(
      data => {
        this.reloadTrips();
      },
      err => {
        console.error('Observer got an error: ' + err);
      }
    )
  }

// Display Methods



}
