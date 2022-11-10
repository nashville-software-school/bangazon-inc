# Adding a React Client

> **NOTE:** Even though there isn't _technically_ a lot of new material in the next couple of chapters, at first all this is going to seem pretty foreign. You may find yourself looking over it and saying "Hmmm.... This looks vaguely familiar. Did we cover this? Did I used to understand this? Did I dream it? Did I see it in a vision? Are these memories even mine?". You may find yourself scouring the dusty attic of your mind, looking under sheets, opening boxes...pausing now and again to reflect on your past and the array of choices that have led you to this time and place...trying to pinpoint exactly where things went wrong.  
> 
> Don't worry. This is all perfectly natural.  
> 
> You're gonna be fine.

---

The cool thing about exposing a Web API is that any client capable of making HTTP requests can communicate with it. You can create web apps in React, Angular, or Vue and they could all talk to the same API. It even extends past browser based clients. You could make a mobile or desktop app and they could talk to the API. Maybe even IOT devices ([Internet of Things](https://en.wikipedia.org/wiki/Internet_of_things)) like microwaves or refrigerators want to make requests to your API.

## Create React App
 
Programming refrigerators may come in a later chapter. For now, lets build a react client that will make requests to our API. Open your Gifter project and make a directory called `client`. This is where we'll put our React code. In your terminal, `cd` into the client directory and run `npx create-react-app .`

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

## Adding Post API Manager

Make two directories under the `src` folder: `components` and `modules`. In the `modules` directory create a file called `PostManager.js` and give it the following code

> `src/modules/PostManager.js`

```js
import React from "react";

const baseUrl = '/api/post';

export const getAllPosts = () => {
  return fetch(baseUrl)
    .then((res) => res.json())
};

export const addPost = (singlePost) => {
  return fetch(baseUrl, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(singlePost),
  });
};
```

This module contains functions for getting all posts and adding a new post. 

> **NOTE:** The URL in the `baseUrl` variable is a relative url -- it doesn't look anything like `https://localhost:5001/api/post`. This is a benefit of adding the `proxy` attribute in our package.json file.

## Adding a Posts List Component

Inside the components directory, create a file called `PostList.js` and add the following code

```js
import React, { useState, useEffect } from "react";
import { getAllPosts } from "../modules/PostManager";

const PostList = () => {
  const [posts, setPosts] = useState([]);

 const getPosts = () => {
    getAllPosts().then(allPosts => setPosts(allPosts));
  };


  useEffect(() => {
    getPosts();
  }, []);

  return (
    <div>
      {posts.map((singlePost) => (
        <div key={singlePost.id}>
          <img src={singlePost.imageUrl} alt={singlePost.title} />
          <p>
            <strong>{singlePost.title}</strong>
          </p>
          <p>{singlePost.caption}</p>
        </div>
      ))}
    </div>
  );
};

export default PostList;
```

Nothing too fancy here. When the component loads, it will call the `getAllPosts` method it recieves from the provider and render a list of posts.

## Wiring It Up

We have our nice manager and component so lets use them. Replace App.js with the following code

```js
import React from "react";
import "./App.css";
import PostList from "./components/PostList";

function App() {
  return (
    <div className="App">
        <PostList />
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

#### Making a Post Component

Our posts might get a little more complex so it's probably a good idea to separate it out into it's own component. Create a `Post.js` file in the components directory with the following code

```js
import React from "react";
import { Card, CardImg, CardBody } from "reactstrap";

const Post = ({ post }) => {
  return (
    <Card className="m-4">
      <p className="text-left px-2">Posted by: {post.userProfile.name}</p>
      <CardImg top src={post.imageUrl} alt={post.title} />
      <CardBody>
        <p>
          <strong>{post.title}</strong>
        </p>
        <p>{post.caption}</p>
      </CardBody>
    </Card>
  );
};

export default Post;
```

Again, nothing fancy here; we're just using the Card component that comes with reactstrap to organize some of the post details.

Now lets update the `PostList` component to use the new `Post` component

```js
import React, { useState, useEffect } from "react";
import Post from './Post';
import { getAllVideos } from "../modules/videoManager";

const PostList = () => {
  const [posts, getAllPosts] = useState([]);

  const getPosts = () => {
    getAllPosts().then(allPosts => setPosts(allPosts));
  };


  useEffect(() => {
    getPosts();
  }, []);

  return (
    <div className="container">
      <div className="row justify-content-center">
        <div className="cards-column">
          {posts.map((post) => (
            <Post key={post.id} post={post} />
          ))}
        </div>
      </div>
    </div>
  );
};

export default PostList;
```

## Exercise

1. Allow the user to add a new post. Create a `PostForm` component in the components directory and include it in App.js so that it shows up above the list of posts. Ex:

```js
function App() {
  return (
    <div className="App">
        {/* <AwesomeNewPostComponent/> */}
        <PostList />
    </div>
  );
}
``` 

2. Add a "Search Posts" feature to your app that uses the `/api/post/search` API endpoint.

3. Update the Post component so that it includes the comments on each post.
