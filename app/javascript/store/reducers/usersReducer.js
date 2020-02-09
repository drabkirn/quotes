let initState = {
  user: null,
  isFetching: true,
  err: null
};

const usersReducer = (state = initState, action) => {
switch (action.type){
  case 'FETCH_USER_INFO_SUCCESS':
    return {
      ...state,
      err: null,
      user: action.payload.data,
      isFetching: false
    };
  case 'FETCH_USER_INFO_API_ERROR':
    return {
      ...state,
      err: action.err.error ? action.err.error : action.err.errors,
      user: null,
      isFetching: true
    };
  case 'FETCH_USER_INFO_ERROR':
    return {
      ...state,
      err: action.err.message,
      user: null,
      isFetching: true
    };
  case 'DELETE_USER_ACCOUNT_SUCCESS':
    return {
      ...state,
      err: null,
      user: null,
      isFetching: true
    };
  case 'DELETE_USER_ACCOUNT_API_ERROR':
    return {
      ...state,
      err: action.err.error ? action.err.error : action.err.errors,
      user: null,
      isFetching: true
    };
  case 'DELETE_USER_ACCOUNT_ERROR':
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

export default usersReducer;