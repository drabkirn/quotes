let initState = {
  user: null,
  isFetching: true,
  err: null
};

const quotesReducer = (state = initState, action) => {
switch (action.type){
  case 'FETCH_USER_INFO_SUCCESS':
    return {
      ...state,
      err: null,
      user: action.payload.data,
      isFetching: false
    };
  case 'GET_ALL_QUOTES_API_ERROR':
    return {
      ...state,
      err: action.err.error ? action.err.error : action.err.errors,
      user: null,
      isFetching: true
    };
  case 'GET_ALL_QUOTES_ERROR':
    return {
      ...state,
      err: action.err.message,
      user: null,
      isFetching: true
    };
  default:
    return state;
}
};


export default quotesReducer;