import { CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';
import { Country } from 'src/app/models/country';
import { ItineraryItem } from 'src/app/models/itinerary-item';
import { Trip } from 'src/app/models/trip';
import { CountryService } from 'src/app/services/country.service';
import { TripService } from 'src/app/services/trip.service';

@Component({
  selector: 'app-trip-list',
  templateUrl: './trip-list.component.html',
  styleUrls: ['./trip-list.component.css']
})
export class TripListComponent implements OnInit {

  trips: Trip[] = [];

  orderedItineraryItems: ItineraryItem [] = [];

  countries: Country [] = [];

  selected: Trip = null;

  wishlist: Trip = null;

  selectedCountry = null;

  selectedII: ItineraryItem = null;

  newTrip: Trip = new Trip();

  updatedTrip: Trip = null;

  userRole: string = "Hello";

  deleting: boolean = false;
  deleteBtnMsg: string = "Remove a Country";

  events: string[] = [];
  opened: boolean;

  isTripList: boolean = true;

// Modal
  closeResult = '';

// Methods

// Methods

  constructor(
    private tripSvc: TripService,
    private countrySvc: CountryService,
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
    this.reloadCountries();
  }


// ItineraryItem Methods
  orderIIList(trip: Trip){
    let IIArray: ItineraryItem [] = [];
    let count: number = 1;
    while(trip.itineraryItems.length != IIArray.length){
      trip.itineraryItems.forEach(II => {
        if(II.sequenceNum === count){
          IIArray.push(II);
        }
      })
      count++;
    }
    this.orderedItineraryItems = IIArray;
  }

// Country Methods
  reloadCountries(){
    this.countrySvc.index().subscribe(
      data => {this.countries = data},
      err => {console.error("Observer Got an Error loading countries" + err);}
    )
  }

// Trip Crud Methods

  // index
  reloadTrips(): void {
    this.tripSvc.index().subscribe(
      data => {
       for (let index = 0; index < data.length; index++) {
         let trip = data[index];
         if(trip['name'].toLowerCase() === "wishlist"){
            this.wishlist = trip;
         }
         else {
           this.trips.push(trip)
         }
       }
      },
      err => {console.error("Observer got an error loading trips: " + err)}
    )
  }

  // create
  createTrip(){

    this.newTrip.completed = false;
    this.newTrip.enabled = true;

    console.log(this.newTrip);

    this.newTrip.startDate = this.dateToStringParser(this.newTrip.startDate);
    this.newTrip.endDate = this.dateToStringParser(this.newTrip.endDate);
    this.newTrip.itineraryItems = [];
    console.log(this.newTrip);

    this.tripSvc.create(this.newTrip).subscribe(
      data => {
        this.selected = data;
        this.newTrip = new Trip();
        this.reloadTrips();
      },
      err => {
        console.error('Observer got an error: ' + err);
      }
    )
  }
  // Parser for Trip creation
  dateToStringParser(newTripDate): string {
      let dateStr = "";

      dateStr += newTripDate["year"];
      dateStr += "-";

      if(+newTripDate["month"] < 10){
        dateStr += "0";
        dateStr += newTripDate["month"];
      } else {
        dateStr += newTripDate["month"];
      }
      dateStr += "-";
      if(+newTripDate["day"] < 10){
        dateStr += "0";
        dateStr += newTripDate["day"];
      } else {
        dateStr += newTripDate["day"];
      }
      dateStr += "T00:00:00"
      console.log(dateStr);

      return dateStr;
  }
  startTripCreate(){
    this.newTrip = new Trip();
  }
  cancelTripCreate(){
    this.newTrip = null;
  }

  // update
  updateTrip(updatedTrip:Trip, updateLocation?:String){
    let tripToSend: Trip = new Trip();
    tripToSend.completed = updatedTrip.completed;
    tripToSend.createDate = updatedTrip.createDate;
    tripToSend.description = updatedTrip.description;
    tripToSend.enabled = updatedTrip.enabled;
    tripToSend.endDate = updatedTrip.endDate;
    tripToSend.id = updatedTrip.id;
    tripToSend.name = updatedTrip.name;
    tripToSend.startDate = updatedTrip.startDate;
    tripToSend.itineraryItems = updatedTrip.itineraryItems;

    // Fix each country JSON on iItem
    tripToSend.itineraryItems.forEach( itinItem => {
      let countryJson: Country = new Country();

      countryJson.id = itinItem.country.id;
      countryJson.name = itinItem.country.name;
      countryJson.description = itinItem.country.description;
      countryJson.defaultImage = itinItem.country.defaultImage;
      countryJson.countryCode = itinItem.country.countryCode;

      itinItem.country = countryJson;
    })

    this.tripSvc.update(tripToSend).subscribe(
      data => {
        if(!updateLocation){
          this.selected = data;
          this.orderIIList(this.selected);
        }
        this.updatedTrip = null;
        this.reloadTrips();
      },
      err => {
        console.error('Observer got an error: ' + err);
      }
    )
  }
  // Add new itineraryItem + fix country JSON for all iItems + update Trip
  addIItem(country: Country, trip: Trip){
    let iItem: ItineraryItem = new ItineraryItem ();
    // Fix each country JSON on iItem
    trip.itineraryItems.forEach( itinItem => {
      let countryJson: Country = new Country();

      countryJson.id = itinItem.country.id;
      countryJson.name = itinItem.country.name;
      countryJson.description = itinItem.country.description;
      countryJson.defaultImage = itinItem.country.defaultImage;
      countryJson.countryCode = itinItem.country.countryCode;

      itinItem.country = countryJson;
    })

    // Fix CountryJSON for new iItem
    let countryToAdd: Country = new Country ();
    countryToAdd.id = country.id;
    countryToAdd.name = country.name;
    countryToAdd.description = country.description;
    countryToAdd.defaultImage = country.defaultImage;
    countryToAdd.countryCode = country.countryCode;

    iItem.country = countryToAdd;
    iItem.notes = "";
    // Grow the sequence Numer by 1
    iItem.sequenceNum = (trip.itineraryItems.length + 1);

    trip.itineraryItems.push(iItem);
    this.updateTrip(trip);


  }

  // Remove itineraryItem
  removeItineraryItem(iItemToRemove: ItineraryItem, trip: Trip){

    let sqncNum: number = iItemToRemove.sequenceNum;
    let index: number = trip.itineraryItems.findIndex( (II) => II.id === iItemToRemove.id)

    trip.itineraryItems.splice(index, 1);

    trip.itineraryItems.forEach(iItem =>{
      if(iItem.sequenceNum > sqncNum ){
        // Fix SequenceNum
        iItem.sequenceNum -= 1;
      }

        // Fix Country JSON (definitely nessessary)
        let countryJson: Country = new Country();

        countryJson.id = iItem.country.id;
        countryJson.name = iItem.country.name;
        countryJson.description = iItem.country.description;
        countryJson.defaultImage = iItem.country.defaultImage;
        countryJson.countryCode = iItem.country.countryCode;

        iItem.country = countryJson;

        // Fix Trip JSON (not sure if nessessary)
        iItem.trip = new Trip();
        iItem.trip.id = trip.id
        iItem.trip.completed = trip.completed
        iItem.trip.createDate = trip.createDate
        iItem.trip.description = trip.description
        iItem.trip.enabled = trip.enabled
        iItem.trip.endDate = trip.endDate
        iItem.trip.name = trip.name
        iItem.trip.startDate = trip.startDate
    })
    this.selectedCountry = null;
    this.selectedII = null;
    this.updateTrip(trip);
  }

  // Update ItineraryItems
  saveNotes(trip: Trip){
    this.updateTrip(trip);
  }

  cancelNotes(trip: Trip, II: ItineraryItem, country){
    this.reloadTrips();

    this.trips.forEach(refreshedTrip => {
      if(refreshedTrip.id === trip.id){
        this.selected = refreshedTrip;
        this.selected.itineraryItems.forEach(IItem => {
          if(IItem.id === II.id){
            this.selectedII = IItem;
            this.selectedCountry = this.selectedII.country;
          }
        })
      }
    })

  }

  updateItinItem(){

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
  displaySingleTrip(trip: Trip){
    this.orderIIList(trip);
    this.selected = trip;
  }
  displayCountryAdvice(country, II?: ItineraryItem){
    this.selectedCountry = country;
    this.selectedII = II;
  }
  // delete display
  displayDelete(): void {
    if(this.deleting === false){
      this.deleting = true;
      this.deleteBtnMsg = "Hide Delete Options"
    } else {
      this.deleting = false;
      this.deleteBtnMsg = "Remove a Country";
    }

  }

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

// DragDrop Methods
  drop(event: CdkDragDrop<string[]>, selectedTrip?: Trip) {
    moveItemInArray(this.orderedItineraryItems, event.previousIndex, event.currentIndex);
    let count: number = 1;

    this.orderedItineraryItems.forEach(II => {
      II.sequenceNum = count;
      count ++;
    })
    selectedTrip.itineraryItems = this.orderedItineraryItems;
    this.updateTrip(selectedTrip);
  }

}
