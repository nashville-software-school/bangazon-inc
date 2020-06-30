# React Router

Lets add different routes to our Gifter application so that we can have certain components on different views and at different URLs. In this chapter we'll set up the following routes:

- `/` Main feed for all posts
- `/posts/add` Form for adding a new post
- `/posts/{id}` Details for a single post with all comments

Start by installing the React router package from npm. `cd` into your client directory and run

```sh
npm i react-router-dom
```

We can use the React router to only render certain views when a user is on a specific URL. Lets create a component that will specify this. Make a new file in your components directory and name it `ApplicationViews.js`

```js
import React from "react";
import { Switch, Route } from "react-router-dom";
import PostList from "./PostList";
import PostForm from "./PostForm";

const ApplicationViews = () => {
  return (
    <Switch>
      <Route path="/" exact>
        <PostList />
      </Route>

      <Route path="/posts/add">
        <PostForm />
      </Route>

      <Route path="/posts/:id">{/* TODO: Post Details Component */}</Route>
    </Switch>
  );
};

export default ApplicationViews;
```

A few things to note here. First, the `<Switch>` and `<Route>` components are ones we get from the npm module we just installed. The `Switch` component is going to look at the url and render the first route that is a match.

Second thing to note is the presence of the `exact` attribute on the home route. Technically "/" will match every single route in our application since they all start like that. The `exact` attribute specifies that we only want to render this component then the url is _exactly_ `/`

Second thing to note is the `<Route>` component. If a url matches the value of the `path` attribute, the children of that `<Route>` will be what gets rendered. As we've seen before, URLs often have _route params_ in them. The third route here is an example of a path with a route param: `/posts/:id`. Using the colon, we can tell the react router that this will be some `id` parameter. These are all examples of paths that would match this route:

**/posts/5** 

**/posts/12345**

**/posts/foo**


To be able to use this `ApplicationViews` component, we have to import it into our `App.js` file and also wrap our entire app in a `<Router>` component.

> App.js

```js
import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import "./App.css";
import ApplicationViews from "./components/ApplicationViews";
import { PostProvider } from "./providers/PostProvider";

function App() {
  return (
    <div className="App">
      <Router>
        <PostProvider>
          <ApplicationViews />
        </PostProvider>
      </Router>
    </div>
  );
}

export default App;
```

Run the app and go to `localhost/3000` and `localhost/3000/posts/add`

## Adding a Header Component

We don't expect our users to manually type into their url bar every time they want to navigate through the app so lets create a navbar component. Add a `Header.js` file to your components directory.

> Header.js

```js
import React from "react";
import { Link } from "react-router-dom";

const Header = () => {
  return (
    <nav className="navbar navbar-expand navbar-dark bg-info">
      <Link to="/" className="navbar-brand">
        GiFTER
      </Link>
      <ul className="navbar-nav mr-auto">
        <li className="nav-item">
          <Link to="/" className="nav-link">
            Feed
          </Link>
        </li>
        <li className="nav-item">
          <Link to="/posts/add" className="nav-link">
            New Post
          </Link>
        </li>
      </ul>
    </nav>
  );
};

export default Header;
```

Notice that instead of `<a>` tags to navigate we're using the `<Link>` component that we import from the react router. We can use the `to` attribute to specify where we want the link to take the user to. Lets add our new header component to our application. Before we do, lets think about where we should put it. We _could_ put it in our ApplicationViews component, but remember that we want the header present on _all_ routes. For now lets put it in App.js above the ApplicationViews component.

> App.js

```js
import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import "./App.css";
import ApplicationViews from "./components/ApplicationViews";
import { PostProvider } from "./providers/PostProvider";
import Header from "./components/Header";

function App() {
  return (
    <div className="App">
      <Router>
        <Header />
        <PostProvider>
          <ApplicationViews />
        </PostProvider>
      </Router>
    </div>
  );
}

export default App;
```

The `<Link>` component is great for rendering links in our UI, but what about if we want to navigate the user programmatically? For example, on the Post form after a user submits and the new post gets successfully gets processed by our API, we'd like to maybe send the user back to the main feed. We can't do this with a simple `<Link>` component. Fortunately, the react router gives us an easy to use hook to allow us to do this called `useHistory`.

In the last chapter you added a `PostForm` component that saves new posts. Your component may look a little different than this, but there's only a couple lines of code that need to be added to make this work.

```js
import React, { useState, useContext } from "react";
import {
  Form,
  FormGroup,
  Card,
  CardBody,
  Label,
  Input,
  Button,
} from "reactstrap";
import { PostContext } from "../providers/PostProvider";
import { useHistory } from "react-router-dom";

const PostForm = () => {
  const { addPost } = useContext(PostContext);
  const [userProfileId, setUserProfileId] = useState("");
  const [imageUrl, setImageUrl] = useState("");
  const [title, setTitle] = useState("");
  const [caption, setCaption] = useState("");

  // Use this hook to allow us to programatically redirect users
  const history = useHistory();

  const submit = (e) => {
    const post = {
      imageUrl,
      title,
      caption,
      userProfileId: +userProfileId,
    };

    addPost(post).then((p) => {
      // Navigate the user back to the home route
      history.push("/");
    });
  };

  return (
    <div className="container pt-4">
      <div className="row justify-content-center">
        <Card className="col-sm-12 col-lg-6">
          <CardBody>
            <Form>
              <FormGroup>
                <Label for="userId">User Id (For Now...)</Label>
                <Input
                  id="userId"
                  onChange={(e) => setUserProfileId(e.target.value)}
                />
              </FormGroup>
              <FormGroup>
                <Label for="imageUrl">Gif URL</Label>
                <Input
                  id="imageUrl"
                  onChange={(e) => setImageUrl(e.target.value)}
                />
              </FormGroup>
              <FormGroup>
                <Label for="title">Title</Label>
                <Input id="title" onChange={(e) => setTitle(e.target.value)} />
              </FormGroup>
              <FormGroup>
                <Label for="caption">Caption</Label>
                <Input
                  id="caption"
                  onChange={(e) => setCaption(e.target.value)}
                />
              </FormGroup>
            </Form>
            <Button color="info" onClick={submit}>
              SUBMIT
            </Button>
          </CardBody>
        </Card>
      </div>
    </div>
  );
};

export default PostForm;
```

Again, your Add form will likely look different than this, but there's only two sections to call out in this example. This code says to send the user back to the home (or `/`) route after the post has been successfully added.

```js
addPost(post).then((p) => {
    // Navigate the user back to the home route
    history.push("/");
});
```

To get access to the `history` instance, we need to use the `useHistory` hook

```js
const history = useHistory();
```

Add these two lines of code to your own `PostForm` component and try adding a new post. You should be taken back to the feed after submitting the form.