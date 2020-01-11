import React from 'react';
import { Route, Switch } from 'react-router-dom';

import Home from './Home/Home';
import Quotes from './Quotes/Quotes';
import Quote from './Quotes/Quote';
import Dash from './Dash/Dash';

import 'desityle/dist/css/desityle.min.css';
import './Assets/css/quotes.css';

function App() {
  return (
    <Switch>
      <Route exact path="/quotes/:id" component={ Quote } />
      <Route exact path="/quotes" component={ Quotes } />
      <Route exact path="/dash" component={ Dash } />
      <Route path="/" component={ Home } />
    </Switch>
  );
}

export default App;