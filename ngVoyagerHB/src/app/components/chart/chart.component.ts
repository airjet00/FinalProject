import { Component, Inject, NgZone, PLATFORM_ID } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';

// amCharts imports
import * as am4core from '@amcharts/amcharts4/core';
import am4themes_animated from '@amcharts/amcharts4/themes/animated';
import * as am4maps from '@amcharts/amcharts4/maps';
import am4geodata_worldLow from "@amcharts/amcharts4-geodata/worldLow";
import { TripService } from 'src/app/services/trip.service';
import { Injectable } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-chart',
  templateUrl: './chart.component.html',
  styleUrls: ['./chart.component.css']
})

@Injectable({ providedIn: 'root' })

export class ChartComponent {
  map= null;
  selectedCountries: Object[] = null;
  username = null;
  countryLoc = [
    {code: "SG", latitude: 1.352083, longitude: 103.819836},
    {code: "AE", latitude: 23.424076, longitude: 53.847818},
    {code:"SE" , latitude: 60.128161, longitude: 18.643501},
    {code:"AR" , latitude: -38.416097, longitude: -63.616672},
    {code:"TH" , latitude: 15.870032, longitude: 100.992541},
    {code:"MX" , latitude: 23.634501, longitude: -102.552784},
    {code:"BW" , latitude: -22.328474, longitude: 24.684866},
    {code:"ES" , latitude: 40.463667, longitude: -3.74922},
    {code:"FR" , latitude: 46.227638, longitude: 2.213749},
    {code:"BR" , latitude: -14.235004, longitude: -51.92528},
    {code:"CN" , latitude: 35.86166, longitude: 104.195397},
    {code:"AU" , latitude: -25.274398, longitude: 133.775136},
    {code:"GB" , latitude: 55.378051, longitude: -3.435973},
    {code:"VN" , latitude: 14.058324, longitude: 108.277199}
  ];

  mylines: Object[];

  constructor(@Inject(PLATFORM_ID) private platformId, private zone: NgZone,
  private tripServ: TripService, private route: ActivatedRoute) {}


  // Run the function only in the browser
  browserOnly(f: () => void) {
    if (isPlatformBrowser(this.platformId)) {
      this.zone.runOutsideAngular(() => {
        f();
      });
    }
  }

  ngAfterViewInit() {
    // this.map = am4maps.MapImage;
    this.username = localStorage.getItem("username")
    let pathway = this.route.snapshot.url[0]['path'];

    if(pathway === "countries"){
      if(this.username){
      this.getTripCountries();
      }
      else{
        this.getBlankMap();
      }
    }
    if(pathway === "trips"){
      let tid = +this.route.snapshot.paramMap.get('tid');
      this.getSingleTripCountries(tid);
    }
  }

  ngOnDestroy() {
    // Clean up chart when the component is removed
    this.browserOnly(() => {
      if (this.map) {
        this.map.dispose();
        this.map = null;
      }
    });
  }

  getTripCountries() {
    this.tripServ.index().subscribe(
      data => {
        let trips = data;
        this.selectedCountries = [
          {id: "US", fill: "#22b3b8"}
        ];
        for (let index = 0; index < trips.length; index++) {
          let trip = trips[index];
          if(trip['completed'] && trip['itineraryItems'].length >0 ) {
            for (let index = 0; index < trip['itineraryItems'].length; index++) {
              let ii = trip['itineraryItems'][index];
              let countryData = Object();
              countryData.id = ii['country']['countryCode'];
              countryData.fill = '#22b3b8'
              this.selectedCountries.push(countryData);
            }
          }
        }
        // Chart code goes in here
        this.browserOnly(() => {

          am4core.useTheme(am4themes_animated);

          this.map = am4core.create("chartdiv", am4maps.MapChart);
          this.map.geodata = am4geodata_worldLow;
          this.map.projection = new am4maps.projections.Miller();
          let polygonSeries = new am4maps.MapPolygonSeries();
          polygonSeries.useGeodata = true;
          this.map.series.push(polygonSeries);

          // Configure series
          let polygonTemplate = polygonSeries.mapPolygons.template;
          polygonTemplate.tooltipText = "{name}";
          polygonTemplate.fill = am4core.color("#74B266");

          // Create hover state and set alternative fill color
          let hs = polygonTemplate.states.create("hover");
          hs.properties.fill = am4core.color("#367B25");

          //Get trips from user to fill in country colors
          for (let index = 0; index < this.selectedCountries.length; index++) {

            polygonSeries.data.push(this.selectedCountries[index]);

          }

          polygonTemplate.propertyFields.fill = "fill";


        });

      },
      err => console.error('showCountries got an error: ' + err)
    )
  }

  getBlankMap() {
    this.browserOnly(() => {

      am4core.useTheme(am4themes_animated);

      this.map = am4core.create("chartdiv", am4maps.MapChart);

      this.map.geodata = am4geodata_worldLow;
      this.map.projection = new am4maps.projections.Miller();
      let polygonSeries = new am4maps.MapPolygonSeries();
      polygonSeries.useGeodata = true;
      this.map.series.push(polygonSeries);



      // Configure series
      let polygonTemplate = polygonSeries.mapPolygons.template;
      polygonTemplate.tooltipText = "{name}";
      polygonTemplate.fill = am4core.color("#74B266");

      // Create hover state and set alternative fill color
      let hs = polygonTemplate.states.create("hover");
      hs.properties.fill = am4core.color("#367B25");
    })
  }

  getSingleTripCountries(tid) {
    if(this.map){this.ngOnDestroy();}
    this.tripServ.show(tid).subscribe(
      data => {
        let trip = data;
        this.selectedCountries = [
          {id: "US", fill: "#22b3b8"}
        ];
        this.mylines = [{latitude: 37.09024, longitude: -95.712891}];

        if(trip['itineraryItems'].length >0 ) {
          let itinitems = trip['itineraryItems'];
          itinitems.sort((a,b) => a.sequenceNum - b.sequenceNum);
          for (let index = 0; index < itinitems.length; index++) {
            let ii = itinitems[index];
            let countryData = Object();
            countryData.id = ii['country']['countryCode'];
            countryData.fill = '#22b3b8'
            this.selectedCountries.push(countryData);


            let locationData = Object();
            let pos = this.countryLoc.map(function(e) { return e.code; }).indexOf(countryData.id);
            locationData.latitude = this.countryLoc[pos].latitude;
            locationData.longitude = this.countryLoc[pos].longitude;
            this.mylines.push(locationData);

          }
        }
        // Chart code goes in here
        this.browserOnly(() => {

          am4core.useTheme(am4themes_animated);

          this.map = am4core.create("chartdiv", am4maps.MapChart);
          this.map.geodata = am4geodata_worldLow;
          this.map.projection = new am4maps.projections.Miller();
          let polygonSeries = new am4maps.MapPolygonSeries();
          polygonSeries.useGeodata = true;
          this.map.series.push(polygonSeries);

          // Configure series
          let polygonTemplate = polygonSeries.mapPolygons.template;
          polygonTemplate.tooltipText = "{name}";
          polygonTemplate.fill = am4core.color("#74B266");

          // Create hover state and set alternative fill color
          let hs = polygonTemplate.states.create("hover");
          hs.properties.fill = am4core.color("#367B25");

          //Get trips from user to fill in country colors
          for (let index = 0; index < this.selectedCountries.length; index++) {

            polygonSeries.data.push(this.selectedCountries[index]);

          }

          polygonTemplate.propertyFields.fill = "fill";

          if(trip.name !== "wishlist"){
          //Add pinpoint for cities
          let imageSeries = this.map.series.push(new am4maps.MapImageSeries());
          let imageSeriesTemplate = imageSeries.mapImages.template;
          let circle = imageSeriesTemplate.createChild(am4core.Circle);
          circle.radius = 4;
          circle.fill = am4core.color("#B27799");
          circle.stroke = am4core.color("#FFFFFF");
          circle.strokeWidth = 2;
          circle.nonScaling = true;
          // circle.tooltipText = "{title}";

          imageSeriesTemplate.propertyFields.latitude = "latitude";
          imageSeriesTemplate.propertyFields.longitude = "longitude";

          //UNCOMMENT THIS CODE TO PUT "US" AT THE END OF THE TRIP AS WELL
          // this.mylines.push({latitude: 37.09024, longitude: -95.712891});

          imageSeries.data = this.mylines;

          let lineSeries = this.map.series.push(new am4maps.MapLineSeries());

          lineSeries.data = [{
            "multiGeoLine": [
               this.mylines
            ]
          }];

          lineSeries.mapLines.template.line.strokeOpacity = 0.5;
          lineSeries.mapLines.template.line.strokeWidth = 4;
          lineSeries.mapLines.template.line.strokeDasharray = "3,3";
          lineSeries.mapLines.template.line.shortestDistance = true;
        }
      });

      },
      err => console.error('showCountries got an error: ' + err)
    )
  }

}
