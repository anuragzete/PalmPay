import http from "http";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const dist = path.join(__dirname, "../dist");

const mimeTypes = {
    ".html": "text/html",
    ".js": "application/javascript",
    ".css": "text/css",
    ".json": "application/json",
    ".svg": "image/svg+xml",
    ".png": "image/png",
    ".jpg": "image/jpeg",
    ".jpeg": "image/jpeg",
    ".ico": "image/x-icon",

    ".wasm": "application/wasm",
    ".data": "application/octet-stream",
    ".binarypb": "application/octet-stream",

    ".woff": "font/woff",
    ".woff2": "font/woff2",
    ".ttf": "font/ttf",
    ".webp": "image/webp"
};

export function startServer() {
    return new Promise((resolve) => {

        const server = http.createServer((req, res) => {

            let filePath = path.join(
                dist,
                req.url === "/" ? "index.html" : req.url
            );

            if (!fs.existsSync(filePath)) {
                filePath = path.join(dist, "index.html");
            }

            const ext = path.extname(filePath);

            res.setHeader(
                "Content-Type",
                mimeTypes[ext] || "application/octet-stream"
            );

            fs.createReadStream(filePath).pipe(res);
        });

        server.listen(4173, "127.0.0.1", () => {
            console.log("PalmPay local server running.");
            resolve(server);
        });

    });
}