import { Component, Inject, NgZone, PLATFORM_ID } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';

// amCharts imports
import * as am4core from '@amcharts/amcharts4/core';
import am4themes_animated from '@amcharts/amcharts4/themes/animated';
import * as am4maps from '@amcharts/amcharts4/maps';
import am4geodata_worldLow from "@amcharts/amcharts4-geodata/worldLow";
import { TripService } from 'src/app/services/trip.service';

@Component({
  selector: 'app-chart',
  templateUrl: './chart.component.html',
  styleUrls: ['./chart.component.css']
})

export class ChartComponent {
  private map: am4maps.MapImage;
  selectedCountries: Object[] = null;

  constructor(@Inject(PLATFORM_ID) private platformId, private zone: NgZone, private tripServ: TripService) {}


  // Run the function only in the browser
  browserOnly(f: () => void) {
    if (isPlatformBrowser(this.platformId)) {
      this.zone.runOutsideAngular(() => {
        f();
      });
    }
  }

  ngAfterViewInit() {
    this.getTripCountries();
  }

  ngOnDestroy() {
    // Clean up chart when the component is removed
    this.browserOnly(() => {
      if (this.map) {
        this.map.dispose();
      }
    });
  }

  getTripCountries() {
    this.tripServ.index().subscribe(
      data => {
        let trips = data;
        for (let index = 0; index < trips.length; index++) {
          let trip = trips[index];
          if(trip['itineraryItem'].length >0 ) {
            this.selectedCountries = [];
            for (let index = 0; index < trip['itineraryItem'].length; index++) {
              let ii = trip['itineraryItem'][index];
              let countryData = Object();
              countryData.id = ii['country']['countryCode'];
              countryData.fill = 'blue'
              this.selectedCountries.push(countryData);
            }
          }
        }
  // Chart code goes in here
  this.browserOnly(() => {

    am4core.useTheme(am4themes_animated);

    let map = am4core.create("chartdiv", am4maps.MapChart);
    map.geodata = am4geodata_worldLow;
    map.projection = new am4maps.projections.Miller();
    let polygonSeries = new am4maps.MapPolygonSeries();
    polygonSeries.useGeodata = true;
    map.series.push(polygonSeries);

    // Configure series
    let polygonTemplate = polygonSeries.mapPolygons.template;
    polygonTemplate.tooltipText = "{name}";
    polygonTemplate.fill = am4core.color("#74B266");

    // Create hover state and set alternative fill color
    let hs = polygonTemplate.states.create("hover");
    hs.properties.fill = am4core.color("#367B25");

    //Get trips from user to fill in country colors
    for (let index = 0; index < this.selectedCountries.length; index++) {
      console.log(this.selectedCountries[index]);

      polygonSeries.data.push(this.selectedCountries[index]);

    }

    polygonTemplate.propertyFields.fill = "fill";


  });

      },
      err => console.error('showCountries got an error: ' + err)
    )
  }
}
