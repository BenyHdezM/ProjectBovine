const { app, BrowserWindow } = require('electron');
const path = require('path');

let mainWindow;

const createWindow = () => {
    mainWindow = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            preload: path.join(__dirname, 'preload.js'),
            contextIsolation: true,
            nodeIntegration: false,
        },
    });

    const startUrl = path.join(__dirname, 'dist/index.html');
    mainWindow.loadFile(startUrl);
};

app.on('ready', createWindow);

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit();
});

app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
});


const db = require('./database');

db.serialize(() => {
    db.run('CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT)');
    db.run('INSERT INTO users (name) VALUES (?)', ['John Doe'], function(err) {
        if (err) console.error(err.message);
        else console.log(`Inserted row with ID: ${this.lastID}`);
    });
});
