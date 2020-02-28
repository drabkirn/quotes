// Get all the Quotes - /quotes
export const fetchAllQuotes = () => {
  return (dispatch) => {
    let quotesToken;
    if(process.env.NODE_ENV == "production") {
      quotesToken = "0e43c5454eea8458f6b405c9db077a";
    } else {
      quotesToken = "b725726d5dc3fa438037cda0d89cac"
    }

    var myHeaders = {
      'Content-Type': 'application/json',
      'User-Agent': 'Drabkirn Quotpa : Website : NA',
      'Accept': 'application/drabkirn.quotes.v1',
      'QuotesToken': quotesToken
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
          err: {
            message: err
          }
        });
      });
  };
};