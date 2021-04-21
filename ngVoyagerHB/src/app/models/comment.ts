export class Comment {
  id: number;
  content: string;
  createDate: string;
  updateDate: string;
  enabled: boolean;

  constructor(id?: number, content?: string, createDate?: string, updateDate?: string, enabled?: boolean) {
    this.id = id;
    this.content = content;
    this.createDate = createDate;
    this.updateDate = updateDate;
    this.enabled = enabled;
  }
}
