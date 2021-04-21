export class AdviceType {
  id: number;
  name: string;
  description: string;
  adviceUrl: string;

  constructor(id?: number, name?: string, description?: string, adviceUrl?: string) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.adviceUrl = adviceUrl;

  }
}
