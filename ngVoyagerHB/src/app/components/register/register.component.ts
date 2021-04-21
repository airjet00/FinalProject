import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

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
    private router: Router
  ) { }

  ngOnInit(): void {
  }
  register(userForm:User){
    this.authSvc.register(userForm).subscribe(
      returnedUser => {
        this.authSvc.login(this.user.username, this.user.password).subscribe(
          data => {
            this.router.navigateByUrl("todo")
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
