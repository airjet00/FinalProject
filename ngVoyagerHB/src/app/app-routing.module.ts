import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AboutPageComponent } from './components/about-page/about-page.component';
import { AdminDashboardComponent } from './components/admin-dashboard/admin-dashboard.component';
import { CommentListComponent } from './components/comment-list/comment-list.component';
import { CountryListComponent } from './components/country-list/country-list.component';
import { HomeComponent } from './components/home/home.component';
import { LoginComponent } from './components/login/login.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { PictureListComponent } from './components/picture-list/picture-list.component';
import { RegisterComponent } from './components/register/register.component';
import { SearchComponent } from './components/search/search.component';
import { TripListComponent } from './components/trip-list/trip-list.component';
import { TripsSidebarComponent } from './components/trips-sidebar/trips-sidebar.component';
import { UserListComponent } from './components/user-list/user-list.component';

const routes: Routes = [  { path: '', pathMatch: 'full', redirectTo: 'home' },
{ path: 'home', component: HomeComponent },
{ path: 'about', component: AboutPageComponent },
{ path: 'register', component: RegisterComponent },
{ path: 'login', component: LoginComponent },
{ path: 'search', component: SearchComponent },
{ path: 'countries', component: CountryListComponent },
{ path: 'countries/:cid', component: CountryListComponent },
{ path: 'countries/:countryId/comments', component: CommentListComponent },
{ path: 'countries/:cid/pictures', component: PictureListComponent },
{ path: 'trips', component: TripListComponent },
{ path: 'trips/:tid', component: TripListComponent },
{ path: 'sideBar', component: TripsSidebarComponent },
{ path: 'comment-list', component: CommentListComponent },
{ path: 'user-list', component: UserListComponent},
{ path: 'admin-dashboard', component: AdminDashboardComponent},
{ path: '**', component: NotFoundComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
