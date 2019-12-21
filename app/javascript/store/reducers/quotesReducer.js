let initState = {
    quotes: null,
    quote: null,
    isFetching: false,
    err: null
  };

const quotesReducer = (state = initState, action) => {
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
        quotes: null
      };
    case 'GET_ALL_QUOTES_ERROR':
      return {
        ...state,
        err: action.err.message,
        quote: null
      };
    case 'GET_QUOTE_SUCCESS':
      return {
        ...state,
        err: null,
        quote: action.payload.data,
        isFetching: false
      };
    case 'GET_QUOTE_API_ERROR':
      return {
        ...state,
        err: action.err.error ? action.err.error : action.err.errors,
        quotes: null
      };
    case 'GET_QUOTE_ERROR':
      return {
        ...state,
        err: action.err.message,
        quotes: null
      };
    default:
      return state;
  }
};


export default quotesReducer;