const { app, BrowserWindow } = require('electron')

const createWindow = () => {
    const win = new BrowserWindow({
        width: 800,
        height: 600
    })

    win.loadFile('dist/index.html')
    win.setMenuBarVisibility(false);
    win.maximize();
}

app.whenReady().then(() => {
    createWindow()
})

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit()
})

const db = require('./database.js');

db.serialize(() => {
    db.run('CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT)'); //Create a Table
    // This is an Example for Insert value on SQLite
    // db.run('INSERT INTO users (name) VALUES (?)', ['John Doe'], function(err) {
    //     if (err) console.error(err.message);
    //     else console.log(`Inserted row with ID: ${this.lastID}`);
    // });
});