# React Router Revisited

---

## Objectives

After completing this lesson and working on related exercises you should be able to:

1. Add multiple routes ("pages") to a react application that uses a Web API.

---

Let's add different routes to our Streamish application so that we can have certain components on different views and at different URLs. In this chapter we'll set up the following routes:

- `/` Main feed for all videos (`/videos` will show the same feed)
- `/videos/add` Form for adding a new video
- `/videos/details/{id}` Details for a single video with all comments

Start by installing the React router package from npm. `cd` into your client directory and run

```sh
npm i react-router-dom
```

We can use the React router to only render certain views when a user is on a specific URL. Let's update `index.js` so that it can specify these routes, like this:

> `src/index.js`

```js
import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import "bootstrap/dist/css/bootstrap.min.css";
import App from "./App";
import reportWebVitals from "./reportWebVitals";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import VideoList from "./components/VideoList";
import VideoForm from "./components/VideoForm";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<App />}>
          <Route index element={<VideoList />} />
          <Route path="videos">
            <Route index element={<VideoList />} />
            <Route path="add" element={<AddVideo />} />
            <Route path="details/:id" element={<p>not implemented...</p>} />
          </Route>
        </Route>
        <Route path="*" element={<p>Whoops, nothing here...</p>} />
      </Routes>
    </BrowserRouter>
  </React.StrictMode>,
);

reportWebVitals();
```

A few things to note here. First, the `Routes`, `Route` and `BrowserRouter` come with the `react-router-dom` package we just installed. The nested `Route`s inside other `Route`s allow us to have a Route component structure that is nested the same way that our routes are organized. So all of the routes that begin `/videos` will be nested in the `videos` route, and all we have to specify in the nested routes is the next segment of the route. In this case, we have three routes inside `videos`: 
1. `/videos/add` which will render the `VideoForm` component
1. `/videos/details/:id` which will render the video details component (for the video with the id of whatever id is in the `route param` denoted here with `:id`) - we haven't created this component yet.
1. `/videos` - the route marked with the `index` attribute will build the element indicated when no additional route segments have been provided  

Second, we have a route at the top level of our routes that uses the `*` wildcard to indicate what to do when a route cannot be matched with the one provided. So, if we put `localhost:3000/taco` in the URL bar we would see `<p>Whoops, nothing here...</p>` rendered, because no route matches `/taco`. 

Finally, our top level route `/`, like the next level `videos`, has child routes (`videos` is actually a child of `/`). But unlike `videos`, the `/` route specifies an element to render, `App`. This means that every time a route that matches `/` is requested (every route in the app matches `/`!) the `App` component will render. 

So how do we render other components inside `App`? If we have nested routes inside the route that will render `App`, we can indicate where to render that nested component using the `Outlet` component from `react-router-dom` like this:

> `src/App.js`

```js
import React from "react";
import "./App.css";
import { Outlet } from "react-router-dom";
function App() {
  return (
    <div className="App">
      <Outlet />
    </div>
  );
}

export default App;
```

Run the app and go to `localhost:3000` and `localhost:3000/videos/add`

These will render the `App` component with the `VideoList` and `VideoForm` component rendered inside it, respectively. 

## Adding a Header Component

We don't expect our users to manually type into their url bar every time they want to navigate through the app so let's create a navbar component. Add a `Header.js` file to your components directory.

> `src/components/Header.js`

```js
import React from "react";
import { Link } from "react-router-dom";

const Header = () => {
  return (
    <nav className="navbar navbar-expand navbar-dark bg-info">
      <Link to="/" className="navbar-brand">
        StreamISH
      </Link>
      <ul className="navbar-nav mr-auto">
        <li className="nav-item">
          <Link to="/videos" className="nav-link">
            Feed
          </Link>
        </li>
        <li className="nav-item">
          <Link to="/videos/add" className="nav-link">
            New Video
          </Link>
        </li>
      </ul>
    </nav>
  );
};

export default Header;
```
Now we can add the Header component to our `App` component This will ensure that every time we navigate to any route with a match we will see the Header and whatever nested component matched the rest of the route:

> App.js

```js
import React from "react";
import "./App.css";
import Header from "./components/Header";
import { Outlet } from "react-router-dom";
function App() {
  return (
    <div className="App">
      <Header />
      <Outlet />
    </div>
  );
}

export default App;
```

The `<Link>` component is great for rendering links in our UI, but what about if we want to navigate the user programmatically? For example, on the Video form after a user submits and the new video gets successfully gets processed by our API, we'd like to maybe send the user back to the main feed. We can't do this with a simple `<Link>` component. Fortunately, the react router gives us an easy to use hook to allow us to do this called `useNavigate`.

In the last chapter you added a `VideoForm` component that saves new videos. Your component may look a little different than this, but should work in a similar way.

```js
import React, { useState } from 'react';
import { Button, Form, FormGroup, Label, Input, FormText } from 'reactstrap';
import { addVideo } from "../modules/videoManager";

const VideoForm = ({ getVideos }) => {
  const emptyVideo = {
    title: '',
    description: '',
    url: ''
  };

  const [video, setVideo] = useState(emptyVideo);

  const handleInputChange = (evt) => {
    const value = evt.target.value;
    const key = evt.target.id;

    const videoCopy = { ...video };

    videoCopy[key] = value;
    setVideo(videoCopy);
  };

  const handleSave = (evt) => {
    evt.preventDefault();

    addVideo(video).then(() => {
      setVideo(emptyVideo);
      getVideos();
    });
  };

  return (
    <Form>
      <FormGroup>
        <Label for="title">Title</Label>
        <Input type="text" name="title" id="title" placeholder="video title"
          value={video.title}
          onChange={handleInputChange} />
      </FormGroup>
      <FormGroup>
        <Label for="url">URL</Label>
        <Input type="text" name="url" id="url" placeholder="video link" 
          value={video.url}
          onChange={handleInputChange} />
      </FormGroup>
      <FormGroup>
        <Label for="description">Description</Label>
        <Input type="textarea" name="description" id="description"
          value={video.description}
          onChange={handleInputChange} />
      </FormGroup>
      <Button className="btn btn-primary" onClick={handleSave}>Submit</Button>
    </Form>
  );
};

export default VideoForm;
```

The `VideoForm` component above was written with the assumption that the form is displayed alongside of the `VideoList` component. Note that after the video is saved, the form is cleared and the video list is refreshed.

Now that we're adding routes, however, we will no longer display the form and the list at the same time. AFter the data is saved, the user will need to be redirected to the list page.

Change the `addVideo` call to look like this:

```js
addVideo(video).then((p) => {
    // Navigate the user back to the home route
    navigate("/");
});
```

To get access to the `navigate` instance, we need to use the `useNavigate` hook

```js
const navigate = useNavigate();
```

Add these two lines of code to your own `VideoForm` component and try adding a new video. You should be taken back to the feed after submitting the form.

## Using URL params in Components

The last thing we want to do with our new routing abilities, is create a `VideoDetails` component and use the route parameter to decide which video's details we should be showing. For example, if a user navigates to `/videos/details/2`, the component code will have to read the route param of `2` and use that value to make a fetch call to get that video's details.

Before we make a Video Details component, let's add a function to the `videoManager` that makes that fetch call

> `modules/videoManager.js`

```js
export const getVideo = (id) => {
    return fetch(`${baseUrl}/${id}`).then((res) => res.json());
};
```

**NOTE** This assumes your API is set up to return a video object which includes an array of comments. If you need to make an additional fetch call to get the comments for a video, update the `getVideo` function as needed.

Now we can add a `VideoDetails.js` file in your components directory. Notice the use of the `useParams` hook to access the route param.

> `src/components/VideoDetails.js`

```js
import React, { useEffect, useState } from "react";
import { ListGroup, ListGroupItem } from "reactstrap";
import { useParams } from "react-router-dom";
import Video from "./Video";
import { getVideo } from "../modules/videoManager";

const VideoDetails = () => {
  const [video, setVideo] = useState();
  const { id } = useParams();

  useEffect(() => {
    getVideo(id).then(setVideo);
  }, []);

  if (!video) {
    return null;
  }

  return (
    <div className="container">
      <div className="row justify-content-center">
        <div className="col-sm-12 col-lg-6">
          <Video video={video} />
          <ListGroup>
            {video.comments.map((c) => (
              <ListGroupItem>{c.message}</ListGroupItem>
            ))}
          </ListGroup>
        </div>
      </div>
    </div>
  );
};

export default VideoDetails;
```

Finally, we want to update each video in the feed to have a link to the details. Update the `Video` component to import the Link component from the react router and wrap the Title of each video in a `Link`.

> `src/components/Video.js`

```js
import { Link } from "react-router-dom";

// ...

```

```js
<Link to={`/videos/details/${video.id}`}>
    <strong>{video.title}</strong>
</Link>
```

## Exercise

1. Add a new route in ApplicationViews whose path is `users/details/:id` and make a new component called `UserVideos` to go inside that route. If the url is `/users/details/1`, the app should only show the videos made by the user with the Id of 1
1. Update the `Video` component so the username at the top is a link to your new route
