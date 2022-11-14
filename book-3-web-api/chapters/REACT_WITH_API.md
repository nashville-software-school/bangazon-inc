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
 
Programming refrigerators may come in a later chapter. For now, lets build a react client that will make requests to our API. Open your Streamish project and make a directory called `client`. This is where we'll put our React code. In your terminal, `cd` into the client directory and run `npx create-react-app .`

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

## Adding a Video API Manager

Make two directories under the `src` folder: `components` and `modules`. In the `modules` directory create a file called `videoManager.js` and give it the following code

> `src/modules/videoManager.js`

```js
const baseUrl = '/api/video';

export const getAllVideos = () => {
  return fetch(baseUrl)
    .then((res) => res.json())
};

export const addVideo = (video) => {
  return fetch(baseUrl, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(video),
  });
};
```

This module contains functions for getting all videos and addinga  new video. 

> **NOTE:** The URL in the `baseUrl` variable is a relative url -- it doesn't look anything like `https://localhost:5001/api/video`. This is a benefit of adding the `proxy` attribute in our package.json file.

## Adding a Videos List Component

Let's start simply by displaying a list of all the video titles.

Inside the components directory, create a file called `VideoList.js` and add the following code

> `src/components/VideoList.js`

```js
import React, { useEffect, useState } from "react";
import { getAllVideos } from "../modules/videoManager";

const VideoList = () => {
  const [videos, setVideos] = useState([]);

  const getVideos = () => {
    getAllVideos().then(videos => setVideos(videos));
  };

  useEffect(() => {
    getVideos();
  }, []);

  return (
    <div>
      {videos.map(v => 
        <div>{v.title}</div>
      )}
    </div>
  );
}

export default VideoList;
```

Nothing too fancy here. When the component loads, it will call the `getAllVideos` function, set the state of the `videos` array and re-render to display a list of video titles.

## Wiring It Up

Replace App.js with the following code.

> `src/App.js`

```js
import React from "react";
import "./App.css";
import VideoList from "./components/VideoList";

function App() {
  return (
    <div className="App">
      <VideoList />
    </div>
  );
}

export default App;
```

Make sure your API server is still running, and run `npm start` in your terminal.

## Styling w/ Reactstrap

Let's make our app look a little nicer. Install reactstrap by running the following command (Make sure to run this from the same directory your package.json file is in)

```sh
npm install --save bootstrap reactstrap
```

Now import the css file into your `index.js` file

```js
import 'bootstrap/dist/css/bootstrap.min.css';
```

## Making a Video Component

Right now we're only displaying video titles, but that's not terribly interesting, is it? Let's change our app to display more information, including the video itself. And let's do that the react way...by making a component.

Create a `Video.js` file in the components directory with the following code

> `src/components/Video.js`

```js
import React from "react";
import { Card, CardBody } from "reactstrap";

const Video = ({ video }) => {
  return (
    <Card >
      <p className="text-left px-2">Posted by: {video.userProfile.name}</p>
      <CardBody>
        <iframe className="video"
          src={video.url}
          title="YouTube video player"
          frameBorder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowFullScreen />

        <p>
          <strong>{video.title}</strong>
        </p>
        <p>{video.description}</p>
      </CardBody>
    </Card>
  );
};

export default Video;
```

Again, nothing too fancy here; we're just using the Card component that comes with reactstrap to organize some of the video details.

> **NOTE:** Maybe embedding a YouTube video is a _little bit_ fancy...

Now lets update the `VideoList` component to use the new `Video` component

> `src/components/VideoList.js`

```js
import React, { useEffect, useState } from "react";
import Video from './Video';
import { getAllVideos } from "../modules/videoManager";

const VideoList = () => {
  const [videos, setVideos] = useState([]);

  const getVideos = () => {
    getAllVideos().then(videos => setVideos(videos));
  };

  useEffect(() => {
    getVideos();
  }, []);

  return (
    <div className="container">
      <div className="row justify-content-center">
        {videos.map((video) => (
          <Video video={video} key={video.id} />
        ))}
      </div>
    </div>
  );
};

export default VideoList;
```

## Exercises

1. Update the Video component so that it includes the comments on each video.
1. Add a "Search Videos" feature to your app that uses the `/api/video/search` API endpoint.
1. Add the ability for a user to save a new video record to the database. We'll do this in a few steps:

    1. Replace the `VideoController.Post` method with this code:

      ```cs
      [HttpPost]
      public IActionResult Post(Video video)
      {
          // NOTE: This is only temporary to set the UserProfileId until we implement login
          // TODO: After we implement login, use the id of the current user
          video.UserProfileId = 1;

          video.DateCreated = DateTime.Now;
          if (string.IsNullOrWhiteSpace(video.Description))
          {
              video.Description = null;
          }

          try
          {
              // Handle the video URL

              // A valid video link might look like this:
              //  https://www.youtube.com/watch?v=sstOXCQ-EG0&list=PLdo4fOcmZ0oVGRpRwbMhUA0KAvMA2mLyN
              // 
              // Our job is to pull out the "v=XXXXX" part to get the get the "code/id" of the video
              //  So we can construct an URL that's appropriate for embedding a video

              // An embeddable Video URL looks something like this:
              //  https://www.youtube.com/embed/sstOXCQ-EG0

              // If this isn't a YouTube video, we should just give up
              if (!video.Url.Contains("youtube"))
              {
                  return BadRequest();
              }

              // If it's not already an embeddable URL, we have some work to do
              if (!video.Url.Contains("embed"))
              {
                  var videoCode = video.Url.Split("v=")[1].Split("&")[0];
                  video.Url = $"https://www.youtube.com/embed/{videoCode}";
              }
          }
          catch // Something went wrong while creating the embeddable url
          {
              return BadRequest();
          }

          _videoRepository.Add(video);

          return CreatedAtAction("Get", new { id = video.Id }, video);
      }
      ```

      2. READ THE CODE you just pasted into the `VideoController.Post` method. What does it do?
      3. Create a `VideoForm` React component in the components directory and place it above the list of videos in the `VideoList` component.  
          * The user should not enter a `UserProfileId`
          * The user should not enter a `DateCreated`
          * The user may leave the `Description` blank
          * The user should be able to copy and paste the URL of a YouTube video directly from the web browser's location bar and should not have to do anything special to get an embeddable url
      4. After a new video is saved to the database, the list of videos should be refreshed to display the new video.
          > **NOTE:** One way to accomplish this is to pass the `getVideos` function into the `VideoForm` component as a prop.
      5. Comment the code in detail to describe what it does and _why_ it does it.
      6. **CHALLENGE** Create and/or update the unit tests for the `VideoController.Post` method. 
          > **NOTE:** You will need more than one test method to fully test the `Post` method.
