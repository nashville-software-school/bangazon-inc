# React Context API

In the front-end course you learned a couple of approaches to getting data into your react components.

1. Pass data in as `props`

    ```jsx

    const MyComponent = (props) => {
        return <h1>props.data</h1>;
    };
    ```

1. Call a method on an imported module to get data from an API

    ```jsx
    import ApiManager from './modules/ApiManage';

    // ... Code omitted for brevity ...

    const [data, setDate] = useState();

    useEffect(() => {
        ApiManager
            .getData()
            .then(setData)
    }, []);

    // ... rest of the component ...
    ```

These approaches are perfectly reasonable and widely used. But they're not the only way. React offers us a third way... the context api.

## Example without Context

Before we talk more about React Context, let's look at an application that doesn't use Context.

Take a look at the `no-context` branch of this repo: https://github.com/nss-day-cohort-41/Jokes


```sh
# Clone the repo
git clone https://github.com/nss-day-cohort-41/Jokes

# change directories
cd Jokes/

# checkout the no-context branch
git checkout no-context

# install node_modules
npm install

# run the app
npm start
```

Now open the `Jokes` app in VS Code and take a look at the source code.

### Some highlights of the `no-context` branch

1. The `App` component contains the entire app. It's loaded onto the DOM in the `index.js` file.
1. The `App` component contains state for the app.
1. The `App` component uses the `JokeManager` module to fetch data from the joke api.
1. The `App` component passes several props down to it's children.
1. If you follow those props, you'll find that they are passed through several levels of components before they are used.

## Example with Context

Now switch to the `context` branch.

```sh
git checkout context
```

Take a moment to look through the code.

### Providers and Context

Take a look at the `JokeProvider.js` file

> `src/providers/JokeProvider.js`

```jsx
import React, { useState } from 'react';

export const JokeContext = React.createContext();

export const JokeProvider = (props) => {
  const [selectedType, setSelectedType] = useState();
  const [jokes, setJokes] = useState([]);

  const loadJokesForType = (type) => {
    const url = `https://official-joke-api.appspot.com/jokes/${type}/ten`;
    fetch(url).then(resp => resp.json())
      .then(jokes => {
        setJokes(jokes);
        setSelectedType(type);
      });
  };

  return (
    <JokeContext.Provider value={{ loadJokesForType, jokes, selectedType }}>
      {props.children}
    </JokeContext.Provider>
  );
};
```

Notice that we export two things from this module: a "provider" and a "context".

#### Providers

A "provider" is a special kind of React component that _provides_ data to a "context".

Providers often contain both React state and function that make `fetch` calls to a web API.

A provider exposes this data that other components can access. In the above example, the `JokeProvider` exposes the `loadJokesForType` function, the `jokes` array and the `selectedType` string.

```jsx
return (
  <JokeContext.Provider value={{ loadJokesForType, jokes, selectedType }}>
    {props.children}
  </JokeContext.Provider>
);
```

In order for a provider's data to be made available, it must be inserted into the React component hierarchy. _(remember a provider is a component)_.

In the Jokes app we wrap the entire application in the `JokeProvider` in the `index.js` module. This makes the `loadJokesForType`, `jokes` and `selectedType` values available to the every component in our app.

```jsx
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';

import { JokeProvider } from './providers/JokeProvider';

ReactDOM.render(
  <React.StrictMode>
    <JokeProvider>
      <App />
    </JokeProvider>
  </React.StrictMode>,
  document.getElementById('root')
);
```


#### Context

Data provided by a provide can't just be plucked out of the air. In order to access it, we use a _context object_. Notice the call to `React.createContext();` in the code above. This creates a context object. A context object is an object that's capable of receiving data provided by a _provider_.

An example might help. Take a look at the `JokeList.js` file.

> `src/components/JokeList.js`

```jsx
import React, { useContext } from 'react';
import JokeCard from './JokeCard';

import { JokeContext } from '../providers/JokeProvider';

const JokeList = () => {
  const { jokes } = useContext(JokeContext);

  return (
    <article>
      {jokes.map(joke =>
        <>
          <JokeCard joke={joke} />
          <br />
        </>
      )}
    </article>
  )
}

export default JokeList;
```

The first thing to note is that we import the `JokesContext` at the top of the module.

```js
import { JokeContext } from '../providers/JokeProvider';
```

This gives us the context object, and then we use the context to get data that was provided by the provider. Remember the `jokes` array is one of the things the `JokeProvider` exposed.

```js
const { jokes } = useContext(JokeContext);
```

> **NOTE:** React gives us the `useContext` function for getting data from a context. We `import` it at the top of the module.

## Resources

* [Context Documentation](https://reactjs.org/docs/context.html)
