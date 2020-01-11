// Fetch User Info - GET /users/show
export const fetchUserInfo = (authToken) => {
  return (dispatch) => {
    var myHeaders = {
      'Content-Type': 'application/json',
      'User-Agent': 'Drabkirn Quotpa : Website : NA',
      'Accept': 'application/drabkirn.quotes.v1',
      'Authorization': authToken
    };
    
    fetch('/users/show', { method: 'GET', headers: myHeaders })
      .then((response) => {
        return response.json();
      }).then((res) => {
        if(res.errors){
          dispatch({
            type: 'FETCH_USER_INFO_ERROR',
            err: res
          });
        } else {
          dispatch({
            type: 'FETCH_USER_INFO_SUCCESS',
            payload: res
          });
        }
      }).catch((err) => {
        console.log(err);
        dispatch({
          type: 'FETCH_USER_INFO_ERROR',
          err: {
            message: err
          }
        });
      });
  };
};