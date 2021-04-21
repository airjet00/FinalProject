export class ItineraryItem {
  id: number;
  sequenceNum: number;
  notes: string;

  constructor(id?: number, sequenceNum?: number, notes?: string) {
    this.id = id;
    this.sequenceNum = sequenceNum;
    this.notes = notes;

  }
}
