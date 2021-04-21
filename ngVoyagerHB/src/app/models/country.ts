export class Country {
  id: number;
  name: string;
  description: string;
  defaultImage: string;

  constructor(id?: number, name?: string, description?: string, defaultImage?: string) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.defaultImage = defaultImage;

  }
}
