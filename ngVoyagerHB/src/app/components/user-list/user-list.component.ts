import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { Comment } from 'src/app/models/comment';
import { AuthService } from 'src/app/services/auth.service';
import { CommentService } from 'src/app/services/comment.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-user-list',
  templateUrl: './user-list.component.html',
  styleUrls: ['./user-list.component.css'],
})
export class UserListComponent implements OnInit {
  users: User[] = [];
  newUser: User = new User();
  usersname: string = null;
  selected: User = null;
  commentsByUser: Comment[];

  constructor(
    private userServ: UserService,
    private router: Router,
    private authService: AuthService,
    private route: ActivatedRoute,
    private commServ: CommentService
  ) {}

  ngOnInit(): void {
    this.loadUsers();
    this.users.forEach(u => {
      this.filterByUser(u);
    });
  }

  // Load all users for Admin only
  loadUsers() {
    this.userServ.index().subscribe(
      (data) => {
        this.users = data;
      },
      (fail) => {
        console.error('Error loading users ' + fail);
        console.error(fail);
      }
    );
  }

  loadUser(id) {
    this.userServ.show(id).subscribe(
      (data) => {
        this.selected = data;
      },
      (fail) => {
        console.error('Error loading user ' + fail);
        console.error(fail);
      }
    );
  }

  updateUser(editUser: User): void {
    this.newUser.id = editUser.id;
    this.userServ.update(this.newUser).subscribe(
      (data) => {
        this.loadUser(data.id);
      },
      (fail) => {
        console.error('Error updating user ' + fail);
        console.error(fail);
      }
    );
  }

  // Flip user enable to false to disable account
  deleteUser(id) {
    this.userServ.delete(id).subscribe(
      (data) => {
        this.loadUsers();
      },
      (fail) => {
        console.error('Error deleting user ' + fail);
        console.error(fail);
      }
    );
  }

  enableUser(user) {
    let sendUser = new User();
    sendUser.id = user.id;
    sendUser.email = user.email;
    sendUser.firstName = user.firstName;
    sendUser.middleName = user.middleName;
    sendUser.lastName = user.lastName;
    sendUser.suffix = user.suffix;
    sendUser.dob = user.dob;
    sendUser.enabled = true;
    sendUser.role = user.role;
    this.userServ.update(sendUser).subscribe(
      (data) => {
        this.loadUsers();
      },
      (fail) => {
        console.error('Error enabling user ' + fail);
      }
    );
  }


indexByUsername(username: string) {
  this.commServ.indexByUsername(username).subscribe(
    data => {
      return data;
    },
    failure => {
      console.error(failure);
    });
  return null;
}

filterByUser(user: User){

}

}
