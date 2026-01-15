import {
  S3Client,
  PutObjectCommand,
  DeleteObjectCommand,
} from "@aws-sdk/client-s3";

const s3Client = new S3Client({
  region: process.env.BUN_PUBLIC_AWS_REGION || "ap-northeast-1",
  credentials: {
    accessKeyId: process.env.BUN_PUBLIC_AWS_ACCESS_KEY_ID || "",
    secretAccessKey: process.env.BUN_PUBLIC_AWS_SECRET_ACCESS_KEY || "",
  },
});

const BUCKET_NAME = process.env.BUN_PUBLIC_S3_BUCKET;

export interface UploadResult {
  url: string;
  key: string;
}

export const s3Service = {
  /**
   * 上傳圖片到 S3
   */
  async uploadImage(file: File): Promise<UploadResult> {
    const fileExtension = file.name.split(".").pop();
    const fileName = `images/${Date.now()}-${Math.random().toString(36).substring(7)}.${fileExtension}`;

    // 在瀏覽器環境中，需要將 File 轉換為 ArrayBuffer
    const arrayBuffer = await file.arrayBuffer();

    const command = new PutObjectCommand({
      Bucket: BUCKET_NAME,
      Key: fileName,
      Body: new Uint8Array(arrayBuffer),
      ContentType: file.type,
    });

    await s3Client.send(command);

    return {
      url: `https://${BUCKET_NAME}.s3.amazonaws.com/${fileName}`,
      key: fileName,
    };
  },

  /**
   * 刪除 S3 上的圖片
   */
  async deleteImage(key: string): Promise<void> {
    const command = new DeleteObjectCommand({
      Bucket: BUCKET_NAME,
      Key: key,
    });

    await s3Client.send(command);
  },

  /**
   * 取得圖片 URL
   */
  getImageUrl(key: string): string {
    return `https://${BUCKET_NAME}.s3.amazonaws.com/${key}`;
  },
};
