export class Trip {
  id: number;
  name: string;
  description: string;
  startDate: string;
  endDate: string;
  completed: boolean;
  enabled: boolean;
  createDate: string;

  constructor(id?: number, name?: string, description?: string, startDate?: string,
    endDate?: string, completed?: boolean, enabled?: boolean, createDate?: string) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.startDate = startDate;
    this.endDate = endDate;
    this.completed = completed;
    this.enabled = enabled;
    this.createDate = createDate;
  }
}
