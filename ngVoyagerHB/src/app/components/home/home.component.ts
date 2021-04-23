import { Component, OnInit } from '@angular/core';
import { Picture } from 'src/app/models/picture';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  pictures : Picture[] = [];

  constructor() { }

  ngOnInit(): void {
    let p1 : Picture = new Picture();
    // Poland
    p1.imageUrl = "https://lp-cms-production.imgix.net/2019-06/53628468.jpg?auto=format&fit=crop&ixlib=react-8.6.4&h=520&w=1312&q=50&dpr=2";

    let p2: Picture = new Picture();
    // Egyptian pyramids
    p2.imageUrl = "https://lp-cms-production.imgix.net/2019-06/82e213048af4e026b6ba31e8f24cc923-pyramids-of-giza.jpg?auto=compress&crop=center&fit=crop&format=auto&h=832&w=1920";

    this.pictures.push(p1, p2);


  }

}
