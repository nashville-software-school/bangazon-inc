

1. Create Web API VS project
1. Create SQL script (either copy from Gifter and modify or generate from DBDiagram): Save SQL file in the project
1. Create .gitignore
1. Install tools (Copy from WisdomAndGrace.csproj)
1. Add connection string
1. Create Models
1. Create Data folder and ApplicationDbContext.cs
1. Update Startup to use Entity Framework and ApplicationDbContext
1. Update Startup to ignore reference loops when serializing JSON
1. Update Startup to handle JWTs
1. Copy in the UserRepository and UserController from WisdomAndGrace

## Client Side

1. Create client directory and run `npx create-react-app .`
1. Install router using `npm install react-router-dom`
1. Install whatever component library you want
1. Create a new firebase project and enable authentication
1. Create a .env.local file and add the firebase API Key
1. Update `appSettings.json` to include `FirebaseProjectId`
1. Add call to `firebase.initializeApp`
1. Copy in UserProfileProvider.js, Login.js, Register.js
1. Copy in ApplicationViews.js and remove code that's not needed
1. Modify App.js to use UserProfileProvider and ApplicationViews