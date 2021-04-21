import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { Picture } from 'src/app/models/picture';
import { AuthService } from 'src/app/services/auth.service';
import { PictureService } from 'src/app/services/picture.service';

@Component({
  selector: 'app-picture-list',
  templateUrl: './picture-list.component.html',
  styleUrls: ['./picture-list.component.css']
})
export class PictureListComponent implements OnInit {
  pictures: Picture[] = [];
  selected: Picture = null;
  addPicture: boolean = false;
  update: boolean = false;
  cid: number = null;

  constructor(private pictureService: PictureService, private router: Router,
    private authService: AuthService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.loadPictures();
  }

  loadPictures(): void {
    this.cid= +this.route.snapshot.paramMap.get('cid');
    console.log(this.cid);

    this.pictureService.index(this.cid).subscribe(
      pictures => {
        this.pictures = pictures;
      },
      fail => {
        console.error('PictureListComponent.loadPictures() failed:');
        console.error(fail);
      }
    );
  }

  addNew() {
    this.update = false;
    this.addPicture = true;
    this.selected = new Picture();
  }

  createPicture(picture: Picture) {
    this.pictureService.create(this.cid, picture).subscribe(
      data => {
        this.addPicture = false;
        this.loadPictures();
      },
      fail => {
        console.error('PictureListComponent.createPicture() failed:');
        console.error(fail);
      }
    )
  }

  updatePicture(picture: Picture) {
    this.addPicture = true;
    this.update = true;
    this.selected = picture;
  }

  deleteBox(id: number) {
    this.pictureService.destroy(this.cid, id).subscribe(
      data => {
        this.addPicture = false;
        this.update = false;
        this.selected = null;
        this.loadPictures();
      },
      fail => {
        console.error('BoxListComponent.destroyBox() failed:');
        console.error(fail);
      }
    )
  }
}
