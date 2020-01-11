import quotesReducer from './quotesReducer';
import usersReducer from './usersReducer';

import { combineReducers } from 'redux';

const rootReducer = combineReducers({
  quotes: quotesReducer,
  users: usersReducer
});

export default rootReducer;