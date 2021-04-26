import { Country } from "./country";
import { Trip } from "./trip";

export class ItineraryItem {
  id: number;
  sequenceNum: number;
  notes: string;
  country: Country;
  trip: Trip;

  constructor(id?: number, sequenceNum?: number, notes?: string, country?: Country, trip?: Trip) {
    this.id = id;
    this.sequenceNum = sequenceNum;
    this.notes = notes;
    this.country = country;
    this.trip = trip;

  }
}
