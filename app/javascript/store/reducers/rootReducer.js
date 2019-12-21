import quotesReducer from './quotesReducer';

import { combineReducers } from 'redux';

const rootReducer = combineReducers({
  quotes: quotesReducer
});

export default rootReducer;