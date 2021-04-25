

export class Comment {
  id: number;
  content: string;
  createDate: string;
  updateDate: string;
  enabled: boolean;
  originalComment: Comment;

  constructor(id?: number, content?: string, createDate?: string, updateDate?: string, enabled?: boolean, originalComment?: Comment) {
    this.id = id;
    this.content = content;
    this.createDate = createDate;
    this.updateDate = updateDate;
    this.enabled = enabled;
    this.originalComment = originalComment;
  }
}
