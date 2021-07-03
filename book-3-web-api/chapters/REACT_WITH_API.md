# Adding a React Client

> **NOTE:** Even though there isn't _technically_ a lot of new material in the next couple of chapters, at first all this is going to seem pretty foreign. You may find yourself looking over it and saying "Hmmm.... This looks vaguely familiar. Did we cover this? Did I used to understand this? Did I dream it? Did I see it in a vision? Are these memories even mine?". You may find yourself scouring the dusty attic of your mind, looking under sheets, opening boxes...pausing now and again to reflect on your past and the array of choices that have led you to this time and place...trying to pinpoint exactly where things went wrong.  
> 
> Don't worry. This is all perfectly natural.  
> 
> You're gonna be fine.

---

## Objectives

After completing this lesson and working on related exercises you should be able to:

1. Define the term "client" as it relates to Web APIs.
1. List at least three types of applications that could be a client for a Web API.
1. Use configuration in a react app's `package.json` file to avoid CORS errors.
1. Write code in a react application to get a collection of data from an ASP<span>.</span>NET Core Web API.
1. Write code in a react application to add a new record using an ASP<span>.</span>NET Core Web API.

---

The cool thing about exposing a Web API is that any client capable of making HTTP requests can communicate with it. You can create web apps in React, Angular, or Vue and they could all talk to the same API. It even extends past browser based clients. You could make a mobile or desktop app and they could talk to the API. Maybe even IOT devices ([Internet of Things](https://en.wikipedia.org/wiki/Internet_of_things)) like microwaves or refrigerators want to make requests to your API.

## Create React App
 
Programming refrigerators may come in a later chapter. For now, lets build a react client that will make requests to our API. Open your Stremish project and make a directory called `client`. This is where we'll put our React code. In your terminal, `cd` into the client directory and run `npx create-react-app .`

**NOTE** VS Code has a much better developer experience when writing javascript. For our projects, it's recommended that you continue writing your C# code in Visual Studio, but use VS Code for javascript. `cd` into the newly created `client` folder and open VS Code from there using the `code .` command.

## Handling CORS

In development, our React app will be running on port 3000 and our API will be running on port 5001. Making requests from React to the Web API will result in CORS issues. We've seen one way we can resolve this--by enabling CORS on the server. Another way we can handle this is by adding a `proxy` property in our package.json file. Update the top of your package.json file to look like this:

```js
{
  "name": "client",
  "proxy": "https://localhost:5001",
  "version": "0.1.0",
  // ...other code omitted for brevity...
```

## Adding Video Provider

Make two directories under the `src` folder: `components` and `providers`. In the prodivers directory create a file called `VideoProvider.js` and give it the following code

```js
import React, { useState } from "react";

export const VideoContext = React.createContext();

export const VideoProvider = (props) => {
  const [videos, setVideos] = useState([]);

  const getAllVideos = () => {
    return fetch("/api/video")
      .then((res) => res.json())
      .then(setVideos);
  };

  const addVideo = (video) => {
    return fetch("/api/video", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(video),
    });
  };

  return (
    <VideoContext.Provider value={{ videos, getAllVideos, addVideo }}>
      {props.children}
    </VideoContext.Provider>
  );
};
```

This providers the state value of the videos array, as well as methods to fetch all videos and add a new video. Note that the urls we are making requests to are relative urls--they don't have anything like `https://localhost:5001/api/video`. This is a benefit of adding the `proxy` attribute in our package.json file.

## Adding a Videos List Component

Inside the components directory, create a file called `VideoList.js` and add the following code

```js
import React, { useContext, useEffect } from "react";
import { VideoContext } from "../providers/VideoProvider";

const VideoList = () => {
  const { videos, getAllVideos } = useContext(VideoContext);

  useEffect(() => {
    getAllVideos();
  }, []);

  return (
    <div>
      {videos.map((video) => (
        <div key={video.id}>
          <img src={video.imageUrl} alt={video.title} />
          <p>
            <strong>{video.title}</strong>
          </p>
          <p>{video.caption}</p>
        </div>
      ))}
    </div>
  );
};

export default VideoList;
```

Nothing too fancy here. When the component loads, it will call the `getAllVideos` method it recieves from the provider and render a list of videos.

## Wiring It Up

We have our nice provider and component so lets use them. Replace App.js with the following code

```js
import React from "react";
import "./App.css";
import { VideoProvider } from "./providers/VideoProvider";
import VideoList from "./components/VideoList";

function App() {
  return (
    <div className="App">
      <VideoProvider>
        <VideoList />
      </VideoProvider>
    </div>
  );
}

export default App;
```

Make sure your API server is still running, and run `npm start` in your terminal.

## Styling w/ Reactstrap

Lets make our app look a little nicer. Install reactstrap by running the following command (Make sure to run this from the same directory your package.json file is in)

```sh
npm install --save bootstrap reactstrap
```

Now import the css file into your `index.js` file

```js
import 'bootstrap/dist/css/bootstrap.min.css';
```

#### Making a Video Component

Our videos might get a little more complex so it's probably a good idea to separate it out into it's own component. Create a `Video.js` file in the components directory with the following code

```js
import React from "react";
import { Card, CardImg, CardBody } from "reactstrap";

const Video = ({ video }) => {
  return (
    <Card className="m-4">
      <p className="text-left px-2">Videoed by: {video.userProfile.name}</p>
      <CardImg top src={video.imageUrl} alt={video.title} />
      <CardBody>
        <p>
          <strong>{video.title}</strong>
        </p>
        <p>{video.caption}</p>
      </CardBody>
    </Card>
  );
};

export default Video;
```

Again, nothing fancy here; we're just using the Card component that comes with reactstrap to organize some of the video details.

Now lets update the `VideoList` component to use the new `Video` component

```js
import React, { useContext, useEffect } from "react";
import { VideoContext } from "../providers/VideoProvider";
import Video from "./Video";

const VideoList = () => {
  const { videos, getAllVideos } = useContext(VideoContext);

  useEffect(() => {
    getAllVideos();
  }, []);

  return (
    <div className="container">
      <div className="row justify-content-center">
        <div className="cards-column">
          {videos.map((video) => (
            <Video key={video.id} video={video} />
          ))}
        </div>
      </div>
    </div>
  );
};

export default VideoList;
```

## Exercise

1. Allow the user to add a new video. Create a `VideoForm` component in the components directory and include it in App.js so that it shows up above the list of videos. Ex:

```js
function App() {
  return (
    <div className="App">
      <VideoProvider>
        {/* <AwesomeNewVideoComponent/> */}
        <VideoList />
      </VideoProvider>
    </div>
  );
}
``` 

2. Add a "Search Videos" feature to your app that uses the `/api/video/search` API endpoint.

3. Update the Video component so that it includes the comments on each video.
