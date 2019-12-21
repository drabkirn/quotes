import React from 'react';
import ReactDOM from 'react-dom';
import { Router, BrowserRouter } from 'react-router-dom';
import history from '../history/history';
import PiwikReactRouter from 'piwik-react-router';

import App from '../components/App';

import rootReducer from '../store/reducers/rootReducer';

import { createStore, applyMiddleware } from 'redux';
import { Provider } from 'react-redux';
import thunk from 'redux-thunk';

const store = createStore(rootReducer, applyMiddleware(thunk));

if(process.env.NODE_ENV === "production"){
  // Self-hosted analytics Setup
  const piwik = PiwikReactRouter({
    url: 'https://analytics.cdadityang.xyz',
    siteId: 3
  });

  document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
      <Provider store={ store }>
        <Router history={piwik.connectToHistory(history)}>
          <App />
        </Router>
      </Provider>,
      document.getElementById('root')
    );
  });
} else{
  document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
      <Provider store={ store }>
        <BrowserRouter>
          <App />
        </BrowserRouter>
      </Provider>,
      document.getElementById('root')
    );
  });
}