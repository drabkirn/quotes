// Initial state
let initState = {
  quotes: null,
  isFetching: true,
  err: null
};

const quotesReducer = (state = initState, action) => {
  // Change the state as per actions it receives.
  switch (action.type){
    case 'GET_ALL_QUOTES_SUCCESS':
      return {
        ...state,
        err: null,
        quotes: action.payload.data,
        isFetching: false
      };
    case 'GET_ALL_QUOTES_API_ERROR':
      return {
        ...state,
        err: action.err.error ? action.err.error : action.err.errors,
        quotes: null,
        isFetching: false
      };
    case 'GET_ALL_QUOTES_ERROR':
      return {
        ...state,
        err: action.err.message
      };
    default:
      return state;
  }
};


export default quotesReducer;