import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

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
    private router: Router
  ) { }

  ngOnInit(): void {
  }

  login(user:User){

    this.authSvc.login(user.username, user.password).subscribe(
      data => {
        // TODO add location after login
        this.router.navigateByUrl("**")
      },
      err => {
        console.error("Encountered Error logging in: " + err);

      }
    );
  }

}
