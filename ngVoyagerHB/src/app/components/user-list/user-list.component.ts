import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-user-list',
  templateUrl: './user-list.component.html',
  styleUrls: ['./user-list.component.css']
})
export class UserListComponent implements OnInit {

  users: User[] = [];

  constructor(
    private userServ: UserService
  ) { }

  ngOnInit(): void {
    this.loadUsers();
  }



  loadUsers(){
    this.userServ.index().subscribe(
      data => {
        this.users = data;
        return data;
      },
      fail => {
        console.error("Error loading users " + fail);
        console.error(fail);

      });
      return null;
  }
}
