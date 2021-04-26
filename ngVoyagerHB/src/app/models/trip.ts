import { ItineraryItem } from "./itinerary-item";

export class Trip {
  id: number;
  name: string;
  description: string;
  startDate: string;
  endDate: string;
  completed: boolean;
  enabled: boolean;
  createDate: string;
  itineraryItems: ItineraryItem [];

  constructor(id?: number, name?: string, description?: string, startDate?: string,
    endDate?: string, completed?: boolean, enabled?: boolean, createDate?: string, itineraryItems?: ItineraryItem[]) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.startDate = startDate;
    this.endDate = endDate;
    this.completed = completed;
    this.enabled = enabled;
    this.createDate = createDate;
    this.itineraryItems = itineraryItems;
  }
}
