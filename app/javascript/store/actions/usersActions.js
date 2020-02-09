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
            type: 'FETCH_USER_INFO_API_ERROR',
            err: res
          });
        } else {
          dispatch({
            type: 'FETCH_USER_INFO_SUCCESS',
            payload: res
          });
        }
      }).catch((err) => {
        dispatch({
          type: 'FETCH_USER_INFO_ERROR',
          err: {
            message: err
          }
        });
      });
  };
};

// Delete User Account - DELETE /users/destroy
export const deleteUserAccount = (authToken, csrfToken) => {
  return (dispatch) => {
    var myHeaders = {
      'Content-Type': 'application/json',
      'User-Agent': 'Drabkirn Quotpa : Website : NA',
      'Accept': 'application/drabkirn.quotes.v1',
      'X-CSRF-Token': csrfToken,
      'Authorization': authToken
    };
    
    fetch('/users/destroy', { method: 'DELETE', headers: myHeaders })
      .then((response) => {
        return response.json();
      }).then((res) => {
        if(res.errors){
          dispatch({
            type: 'DELETE_USER_ACCOUNT_API_ERROR',
            err: res
          });
        } else {
          dispatch({
            type: 'DELETE_USER_ACCOUNT_SUCCESS',
            payload: res
          });
        }
      }).catch((err) => {
        dispatch({
          type: 'DELETE_USER_ACCOUNT_ERROR',
          err: {
            message: err
          }
        });
      });
  };
};
