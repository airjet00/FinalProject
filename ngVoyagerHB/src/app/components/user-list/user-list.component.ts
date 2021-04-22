import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-user-list',
  templateUrl: './user-list.component.html',
  styleUrls: ['./user-list.component.css']
})
export class UserListComponent implements OnInit {

  users: User[] = [];
  user: User = new User();
  constructor(
    private userServ: UserService,
    private router: Router,
    private authService: AuthService,
    private route: ActivatedRoute
  ) { }

  ngOnInit(): void {
    this.loadUsers();
  }



  loadUsers(){
    this.userServ.index().subscribe(
      data => {
        this.users = data;
      },
      fail => {
        console.error("Error loading users " + fail);
        console.error(fail);

      });

  }

}
