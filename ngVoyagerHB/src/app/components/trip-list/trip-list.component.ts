import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';
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

  userRole: string = "Hello";

  events: string[] = [];
  opened: boolean;

  isTripList: boolean = true;

// Modal
  closeResult = '';

// Methods

// Methods

  constructor(
    private tripSvc: TripService,
    private route: ActivatedRoute,
    private router: Router,
    private modalService: NgbModal
  ) { }

  ngOnInit(): void {
    let tripId = this.route.snapshot.paramMap.get('tid')
    if(tripId){
      this.tripSvc.show(tripId).subscribe(
        data => {
          this.selected = data;
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
  createTrip(){
    this.newTrip.completed = false;
    this.newTrip.enabled = true;
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
  startTripCreate(){
    this.newTrip = new Trip();
  }
  cancelTripCreate(){
    this.newTrip = null;
  }

  // update
  updateTrip(updatedTrip:Trip, updateLocation?:String){
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
  deleteTrip(id:number){
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


// Local Storage method

  getUserRole(): void {
      this.userRole = localStorage.getItem("userRole");
  }
// Modal Methods
  open(content) {
    this.modalService.open(content, {ariaLabelledBy: 'modal-basic-title'}).result.then((result) => {
      this.closeResult = `Closed with: ${result}`;
    }, (reason) => {
      this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
    });
  }

  private getDismissReason(reason: any): string {
    if (reason === ModalDismissReasons.ESC) {
      return 'by pressing ESC';
    } else if (reason === ModalDismissReasons.BACKDROP_CLICK) {
      return 'by clicking on a backdrop';
    } else {
      return `with: ${reason}`;
    }
  }

// SideBar Methods
  toggleTrip(){
    this.isTripList = true;
  }
  toggleWish(){
    this.isTripList = false;
  }

}
