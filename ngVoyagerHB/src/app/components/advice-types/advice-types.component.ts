import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { AdviceType } from 'src/app/models/advice-type';
import { AdviceTypesService } from 'src/app/services/advice-types.service';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-advice-types',
  templateUrl: './advice-types.component.html',
  styleUrls: ['./advice-types.component.css']
})
export class AdviceTypesComponent implements OnInit {
  pictures: AdviceType[] = [];
  selected: AdviceType = null;
  addAdvice: boolean = false;
  update: boolean = false;
  cid: number = null;

  constructor(private pictureService: AdviceTypesService, private router: Router,
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
        console.error('AdviceListComponent.loadAdvice() failed:');
        console.error(fail);
      }
    );
  }

  addNew() {
    this.update = false;
    this.addAdvice = true;
    this.selected = new AdviceType();
  }

  createPicture(picture: AdviceType) {
    this.pictureService.create(this.cid, picture).subscribe(
      data => {
        this.addAdvice = false;
        this.loadPictures();
      },
      fail => {
        console.error('AdviceListComponent.createAdvice() failed:');
        console.error(fail);
      }
    )
  }

  updatePicture(picture: AdviceType) {
    this.addAdvice = true;
    this.update = true;
    this.selected = picture;
  }

  deleteBox(id: number) {
    this.pictureService.destroy(this.cid, id).subscribe(
      data => {
        this.addAdvice = false;
        this.update = false;
        this.selected = null;
        this.loadPictures();
      },
      fail => {
        console.error('AdviceListComponent.destroyAdvice() failed:');
        console.error(fail);
      }
    )
  }
}
