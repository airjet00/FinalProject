import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Trip } from 'src/app/models/trip';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { TripService } from 'src/app/services/trip.service';
import { UserService } from 'src/app/services/user.service';

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
    private tripSvc: TripService,
    private userSvc: UserService
  ) { }

  ngOnInit(): void {
  }
  register(userForm:User){

    this.authSvc.register(userForm).subscribe(
      returnedUser => {
        this.authSvc.login(this.user.username, this.user.password).subscribe(
          data => {

            let wishlist = new Trip();
            wishlist.name = "wishlist";
            wishlist.startDate = "2021-09-01T00:00:00";
            wishlist.endDate = "2021-09-01T00:00:00";
            wishlist.completed = false;
            wishlist.enabled = true;

            this.createWL(wishlist);

            this.getUserInfo(data['name']);

            if(localStorage.getItem("username")){
              this.router.navigateByUrl("countries")
            }

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

  createWL(wishlist: Trip): void {
    this.tripSvc.create(wishlist).subscribe(
      data => {},
      err => {
        console.error("Observer encountered error: " + err);
      }
    );
  }

  getUserInfo(username: string): void {
    let user: User = null;
    this.userSvc.showByUsername(username).subscribe(
      data => {
        user = data;
        localStorage.setItem('userRole', user.role);
        localStorage.setItem('userFirstName', user.firstName);
        localStorage.setItem('userLastName', user.lastName);
        localStorage.setItem('username', user.username);

        if (localStorage.getItem('userRole') === "admin") {
          this.router.navigateByUrl("admin-dashboard");
          console.warn("if");
          }

        else {
          this.router.navigateByUrl("countries");
          console.warn("else");

        }
      },
      err => {
        console.error("Observer encountered error: " + err);
      }
    );
  }

}
