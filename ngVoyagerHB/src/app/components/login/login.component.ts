import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  user:User = new User();

  constructor(
    private authSvc:AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private userSvc: UserService
  ) { }

  ngOnInit(): void {
  }

  login(user:User){

    this.authSvc.login(user.username, user.password).subscribe(
      data => {
        // Log for testing
        // console.log(this.authSvc.getCredentials());
        this.getUserInfo(user.username);
        this.router.navigateByUrl("countries");
      },
      err => {
        console.error("Encountered Error logging in: " + err);

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
      },
      err => {
        console.error("Observer encountered error: " + err);
      }
    );
  }
}
