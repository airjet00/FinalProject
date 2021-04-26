import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavigationComponent } from './components/navigation/navigation.component';
import { FooterComponent } from './components/footer/footer.component';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { CountryListComponent } from './components/country-list/country-list.component';
import { SearchComponent } from './components/search/search.component';
import { TripListComponent } from './components/trip-list/trip-list.component';
import { UserListComponent } from './components/user-list/user-list.component';
import { CommentListComponent } from './components/comment-list/comment-list.component';
import { PictureListComponent } from './components/picture-list/picture-list.component';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { AuthService } from './services/auth.service';
import { CountryService } from './services/country.service';
import { HomeComponent } from './components/home/home.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { UserService } from './services/user.service';
import { TripsSidebarComponent } from './components/trips-sidebar/trips-sidebar.component';
import { AdviceTypesComponent } from './components/advice-types/advice-types.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import {MatSidenavModule} from '@angular/material/sidenav';
import {MatCheckboxModule} from '@angular/material/checkbox';
import { AboutPageComponent } from './components/about-page/about-page.component';
import { ChartComponent } from './components/chart/chart.component';
import { AdminDashboardComponent } from './components/admin-dashboard/admin-dashboard.component';
import { ManageCountriesComponent } from './components/manage-countries/manage-countries.component';

@NgModule({
  declarations: [
    AppComponent,
    NavigationComponent,
    FooterComponent,
    RegisterComponent,
    LoginComponent,
    LogoutComponent,
    CountryListComponent,
    SearchComponent,
    TripListComponent,
    UserListComponent,
    CommentListComponent,
    PictureListComponent,
    HomeComponent,
    NotFoundComponent,
    TripsSidebarComponent,
    AdviceTypesComponent,
    AboutPageComponent,
    ChartComponent,
    AdminDashboardComponent,
    ManageCountriesComponent
  ],
  exports:[
    MatSidenavModule,
    MatCheckboxModule
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    BrowserAnimationsModule,
    NgbModule,
    MatSidenavModule,
    MatCheckboxModule
  ],
  providers: [
    AuthService,
    CountryService,
    UserService,
    CommentListComponent
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
