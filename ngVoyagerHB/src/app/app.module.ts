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
import { CountryService } from './services/country.service';
import { HomeComponent } from './components/home/home.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { UserService } from './services/user.service';

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
    NotFoundComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule
  ],
  providers: [
    CountryService,
    UserService

  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
