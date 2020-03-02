import quotesReducer from './quotesReducer';
import usersReducer from './usersReducer';

import { combineReducers } from 'redux';

// Combine both the reducers to give them back as one API in state
const rootReducer = combineReducers({
  quotes: quotesReducer,
  users: usersReducer
});

export default rootReducer;