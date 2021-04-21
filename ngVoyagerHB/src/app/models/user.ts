import { stringify } from "@angular/compiler/src/util";

export class User {
  id: number;
  username: string;
  email: string;
  password: string;
  role: string;
  firstName: string;
  middleName: string;
  lastName: string;
  suffix: string;
  dob: string;
  enabled: boolean;
  createDate: string;
  updateDate: string;

  constructor(id?: number, username?: string, email?: string, password?: string,
    role?: string, firstName?: string, middleName?: string, lastName?: string,
    suffix?: string, dob?: string, enabled?: boolean, createDate?: string, updateDate?: string) {
    this.id = id;
    this.username = username;
    this.email = email;
    this.password = password;
    this.role = role;
    this.firstName = firstName;
    this.middleName = middleName;
    this.lastName = lastName;
    this.suffix = suffix;
    this.dob = dob;
    this.enabled = enabled;
    this.createDate = createDate;
    this.updateDate = updateDate;
  }
}
