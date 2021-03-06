import { Picture } from "./picture";

export class Country {
  id: number;
  name: string;
  description: string;
  defaultImage: string;
  countryCode: string;

  constructor(id?: number, name?: string, description?: string, defaultImage?: string, countryCode?: string) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.defaultImage = defaultImage;
    this.countryCode = countryCode;
  }
}
