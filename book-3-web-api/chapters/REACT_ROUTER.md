# React Router Revisited

---

## Objectives

After completing this lesson and working on related exercises you should be able to:

1. Add multiple routes ("pages") to a react application that uses a Web API.

---

Let's add different routes to our Streamish application so that we can have certain components on different views and at different URLs. In this chapter we'll set up the following routes:

- `/` Main feed for all videos
- `/videos/add` Form for adding a new video
- `/videos/{id}` Details for a single video with all comments

Start by installing the React router package from npm. `cd` into your client directory and run

```sh
npm i react-router-dom@5.3.0
```

We can use the React router to only render certain views when a user is on a specific URL. Let's create a component that will specify this. Make a new file in your components directory and name it `ApplicationViews.js`

> `src/components/ApplicationViews.js`

```js
import React from "react";
import { Switch, Route } from "react-router-dom";
import VideoList from "./VideoList";
import VideoForm from "./VideoForm";

const ApplicationViews = () => {
  return (
    <Switch>
      <Route path="/" exact>
        <VideoList />
      </Route>

      <Route path="/videos/add">
        <VideoForm />
      </Route>

      <Route path="/videos/:id">{/* TODO: Video Details Component */}</Route>
    </Switch>
  );
};

export default ApplicationViews;
```

A few things to note here. First, the `<Switch>` and `<Route>` components are ones we get from the npm module we just installed. The `Switch` component is going to look at the url and render the first route that is a match.

Second thing to note is the presence of the `exact` attribute on the home route. Technically "/" will match every single route in our application since they all start like that. The `exact` attribute specifies that we only want to render this component then the url is _exactly_ `/`

Second thing to note is the `<Route>` component. If a url matches the value of the `path` attribute, the children of that `<Route>` will be what gets rendered. As we've seen before, URLs often have _route params_ in them. The third route here is an example of a path with a route param: `/videos/:id`. Using the colon, we can tell the react router that this will be some `id` parameter. These are all examples of paths that would match this route:

> **/videos/5**  
> **/videos/12345**  
> **/videos/foo**  

To be able to use this `ApplicationViews` component, we have to import it into our `App.js` file and also wrap our entire app in a `<Router>` component.

> `src/App.js`

```js
import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import "./App.css";
import ApplicationViews from "./components/ApplicationViews";

function App() {
  return (
    <div className="App">
      <Router>
        <ApplicationViews />
      </Router>
    </div>
  );
}

export default App;
```

Run the app and go to `localhost:3000` and `localhost:3000/videos/add`

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
          <Link to="/" className="nav-link">
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

Notice that instead of `<a>` tags to navigate we're using the `<Link>` component that we import from the react router. We can use the `to` attribute to specify where we want the link to take the user to. Let's add our new header component to our application. Before we do, let's think about where we should put it. We _could_ put it in our ApplicationViews component, but remember that we want the header present on _all_ routes. For now let's put it in App.js above the ApplicationViews component.

> App.js

```js
import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import "./App.css";
import ApplicationViews from "./components/ApplicationViews";
import Header from "./components/Header";

function App() {
  return (
    <div className="App">
      <Router>
        <Header />
        <ApplicationViews />
      </Router>
    </div>
  );
}

export default App;
```

The `<Link>` component is great for rendering links in our UI, but what about if we want to navigate the user programmatically? For example, on the Video form after a user submits and the new video gets successfully gets processed by our API, we'd like to maybe send the user back to the main feed. We can't do this with a simple `<Link>` component. Fortunately, the react router gives us an easy to use hook to allow us to do this called `useHistory`.

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
    history.push("/");
});
```

To get access to the `history` instance, we need to use the `useHistory` hook

```js
const history = useHistory();
```

Add these two lines of code to your own `VideoForm` component and try adding a new video. You should be taken back to the feed after submitting the form.

## Using URL params in Components

The last thing we want to do with our new routing abilities, is create a `VideoDetails` component and use the route parameter to decide which video's details we should be showing. For example, if a user navigates to `/videos/2`, the component code will have to read the route param of `2` and use that value to make a fetch call to get that video's details.

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
<Link to={`/videos/${video.id}`}>
    <strong>{video.title}</strong>
</Link>
```

## Exercise

1. Add a new route in ApplicationViews whose path is `users/:id` and make a new component called `UserVideos` to go inside that route. If the url is `/users/1`, the app should only show the videos made by the user with the Id of 1
1. Update the `Video` component so the username at the top is a link to your new route
