import { app, BrowserWindow } from 'electron';
import path from 'path';
import { fileURLToPath } from 'url';
import { startServer } from "./server.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const isDev = !app.isPackaged;

function createWindow() {
    const win = new BrowserWindow({
        width: 1200,
        height: 800,
        webPreferences: {
            nodeIntegration: false,
            contextIsolation: true, // For simple access to hardware/webcam
            // enableRemoteModule: true
        },
        // Premium App Look
        backgroundColor: '#0f172a',
        titleBarStyle: 'hiddenInset',
        icon: path.join(__dirname, '../public/vite.svg')
    });

    if (isDev) {
        win.loadURL('http://localhost:5173');
        // win.webContents.openDevTools();
    } else {
      win.loadURL("http://127.0.0.1:4173");
    }
}

app.whenReady().then(async () => {

    if (!isDev) {
        await startServer();
    }

    createWindow();

    app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) {
            createWindow();
        }
    });

    // Handle webcam permissions automatically
    app.on('web-contents-created', (event, contents) => {
        contents.session.setPermissionCheckHandler((webContents, permission, requestingOrigin) => {
            if (permission === 'media') {
                return true;
            }
            return false;
        });

        contents.session.setPermissionRequestHandler((webContents, permission, callback) => {
            if (permission === 'media') {
                callback(true);
            } else {
                callback(false);
            }
        });
    });
});

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        app.quit();
    }
});
