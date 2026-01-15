import { useState, useRef } from "react";
import type { ChangeEvent } from "react";
import { s3Service } from "../services/s3Service";
import type { UploadResult } from "../services/s3Service";

interface ImageUploaderProps {
  onUploadSuccess?: (result: UploadResult) => void;
  maxSizeMB?: number;
}

export function ImageUploader({
  onUploadSuccess,
  maxSizeMB = 5,
}: ImageUploaderProps) {
  const [uploading, setUploading] = useState(false);
  const [imageUrl, setImageUrl] = useState<string>("");
  const [error, setError] = useState<string>("");
  const [uploadedKey, setUploadedKey] = useState<string>("");
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleFileChange = async (e: ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // 檢查檔案類型
    if (!file.type.startsWith("image/")) {
      setError("請選擇圖片檔案");
      return;
    }

    // 檢查檔案大小
    const fileSizeMB = file.size / (1024 * 1024);
    if (fileSizeMB > maxSizeMB) {
      setError(`檔案大小不能超過 ${maxSizeMB}MB`);
      return;
    }

    setError("");
    setUploading(true);

    try {
      const result = await s3Service.uploadImage(file);
      setImageUrl(result.url);
      setUploadedKey(result.key);
      onUploadSuccess?.(result);
    } catch (err) {
      console.error("上傳失敗:", err);
      setError(err instanceof Error ? err.message : "上傳失敗");
    } finally {
      setUploading(false);
    }
  };

  const handleDelete = async () => {
    if (!uploadedKey) return;

    try {
      await s3Service.deleteImage(uploadedKey);
      setImageUrl("");
      setUploadedKey("");
      if (fileInputRef.current) {
        fileInputRef.current.value = "";
      }
    } catch (err) {
      console.error("刪除失敗:", err);
      setError("刪除失敗");
    }
  };

  const triggerFileInput = () => {
    fileInputRef.current?.click();
  };

  return (
    <div className="image-uploader">
      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        onChange={handleFileChange}
        disabled={uploading}
        style={{ display: "none" }}
      />

      {!imageUrl ? (
        <button
          onClick={triggerFileInput}
          disabled={uploading}
          className="upload-button"
        >
          {uploading ? "上傳中..." : "選擇圖片"}
        </button>
      ) : (
        <div className="image-preview">
          <img
            src={imageUrl}
            alt="Uploaded"
            style={{ maxWidth: "100%", maxHeight: "400px" }}
          />
          <div className="image-actions">
            <button onClick={triggerFileInput} className="change-button">
              更換圖片
            </button>
            <button onClick={handleDelete} className="delete-button">
              刪除圖片
            </button>
          </div>
          <p className="image-url">
            <small>{imageUrl}</small>
          </p>
        </div>
      )}

      {error && (
        <p className="error-message" style={{ color: "red" }}>
          {error}
        </p>
      )}
    </div>
  );
}
