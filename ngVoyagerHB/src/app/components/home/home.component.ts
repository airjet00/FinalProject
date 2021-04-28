import { Component, OnInit } from '@angular/core';
import { Picture } from 'src/app/models/picture';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  pictures : Picture[] = [];
  constructor(private authSvc: AuthService) { }

  ngOnInit(): void {
    let p1 : Picture = new Picture();
    // Poland
    p1.imageUrl = "https://lp-cms-production.imgix.net/2019-06/53628468.jpg?auto=format&fit=crop&ixlib=react-8.6.4&h=520&w=1312&q=50&dpr=2";

    let p2: Picture = new Picture();
    // Egyptian pyramids
    p2.imageUrl = "https://lp-cms-production.imgix.net/2019-06/82e213048af4e026b6ba31e8f24cc923-pyramids-of-giza.jpg?auto=compress&crop=center&fit=crop&format=auto&h=832&w=1920";

    let p3: Picture = new Picture();
    // Tahiti
    p3.imageUrl = "https://lp-cms-production.imgix.net/2019-06/43717172.jpg?auto=format&fit=crop&ixlib=react-8.6.4&h=520&w=1312&q=50&dpr=2";

    // Smaller picture -- need big pic
    let p4: Picture = new Picture();
    // Thailand
    p4.imageUrl = "https://images.unsplash.com/photo-1578335144141-069e13ef7890?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2089&q=80";


    this.pictures.push(p1, p2, p3, p4);


  }


  checkLoggedIn(): boolean{
    return this.authSvc.checkLogin();
  }


}
