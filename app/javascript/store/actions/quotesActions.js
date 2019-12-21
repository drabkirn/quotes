// Get all the Quotes - /quotes
export const fetchAllQuotes = () => {
  return (dispatch) => {
    var myHeaders = {
      'Content-Type': 'application/json',
      'User-Agent': 'Drabkirn Quotpa : Website : NA',
      'Accept': 'application/drabkirn.quotes.v1'
    };
    
    fetch('/quotes', { method: 'GET', headers: myHeaders })
      .then((response) => {
        return response.json();
      }).then((res) => {
        if(res.errors){
          dispatch({
            type: 'GET_ALL_QUOTES_API_ERROR',
            err: res
          });
        } else {
          dispatch({
            type: 'GET_ALL_QUOTES_SUCCESS',
            payload: res
          });
        }
      }).catch((err) => {
        dispatch({
          type: 'GET_ALL_QUOTES_ERROR',
          err: err
        });
      });
  };
};

// Get Quote with ID the Quotes - /quote/:id
export const fetchQuote = (quoteId) => {
  return (dispatch) => {
    var myHeaders = {
      'Content-Type': 'application/json',
      'User-Agent': 'Drabkirn Quotpa : Website : NA',
      'Accept': 'application/drabkirn.quotes.v1'
    };
    
    fetch(`/quotes/${quoteId}`, { method: 'GET', headers: myHeaders })
      .then((response) => {
        return response.json();
      }).then((res) => {
        if(res.errors){
          dispatch({
            type: 'GET_QUOTE_API_ERROR',
            err: res
          });
        } else {
          dispatch({
            type: 'GET_QUOTE_SUCCESS',
            payload: res
          });
        }
      }).catch((err) => {
        dispatch({
          type: 'GET_QUOTE_ERROR',
          err: err
        });
      });
  };
};