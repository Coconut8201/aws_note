import { useState } from "react";
import { ImageUploader } from "./components/ImageUploader";
import type { UploadResult } from "./services/s3Service";
import "./App.css";

function App() {
  const [uploadedImages, setUploadedImages] = useState<UploadResult[]>([]);

  const handleUploadSuccess = (result: UploadResult) => {
    console.log("圖片上傳成功:", result);
    setUploadedImages((prev) => [...prev, result]);
  };

  return (
    <div className="App">
      <h1>S3 圖片上傳 Demo</h1>

      <div className="uploader-container">
        <ImageUploader onUploadSuccess={handleUploadSuccess} maxSizeMB={10} />
      </div>

      {uploadedImages.length > 0 && (
        <div className="uploaded-list">
          <h2>已上傳的圖片</h2>
          <ul>
            {uploadedImages.map((img, index) => (
              <li key={index}>
                <a href={img.url} target="_blank" rel="noopener noreferrer">
                  {img.key}
                </a>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}

export default App;
