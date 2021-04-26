import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Trip } from 'src/app/models/trip';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { TripService } from 'src/app/services/trip.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  user: User = new User();

  constructor(
    private authSvc: AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private tripSvc: TripService
  ) { }

  ngOnInit(): void {
  }
  register(userForm:User){

    this.authSvc.register(userForm).subscribe(
      returnedUser => {
        this.authSvc.login(this.user.username, this.user.password).subscribe(
          data => {
            let wishlist = new Trip();
            wishlist.name = "Wishlist";
            wishlist.startDate = "2021-09-01T00:00:00";
            wishlist.endDate = "2021-09-01T00:00:00";
            wishlist.completed = false;
            this.tripSvc.create(wishlist);
            console.log(wishlist);

            this.router.navigateByUrl("countries")
          },
          err => {
            console.error("Encountered Error logging in: " + err);
            this.router.navigateByUrl('login');
          }
        );
        // reset form user (which shouldn't matter because of the redirect and reload? or would info persist?)
        this.user = new User();
      },
      err => {
        console.error("Encountered an error during user registration: " + err);

      }
    )
  }

}
