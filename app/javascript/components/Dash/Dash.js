import React, { useEffect } from 'react';
import { Link, Redirect } from 'react-router-dom';
import { useSelector, useDispatch } from "react-redux";

import MainHeader from '../Shared/MainHeader';
import Footer from '../Shared/Footer';

import { fetchUserInfo } from '../../store/actions/usersActions';

function Dash() {
  // Working on User object URL Param
  const urlLocation = window.location.href;
  const url = new URL(urlLocation);
  const urlAuthTokenParam = url.searchParams.get("auth_token");

  // If there is AuthToken, then take it, store it, then remove that param from URL
  if(urlAuthTokenParam) {
    localStorage.setItem("quotes_user_token", urlAuthTokenParam);
    return <Redirect to="/dash" />;
  }

  const quotesUserToken = localStorage.getItem("quotes_user_token");

  // Get the Redux state
  const store = useSelector(store => store);
  const { user } = store.users;

  // Get the Redux Dispatch
  const dispatch = useDispatch();

  // React Hook for ComponentDidMount
  useEffect(() => {
    if(quotesUserToken) {
      dispatch(fetchUserInfo(quotesUserToken));
    }
  }, [quotesUserToken]);

  return (
    <React.Fragment>
      <MainHeader />

      <div>
        <p>Dash</p>
      </div>

      {
        user ? (
          <div>
            <p>User ID: { user.id }</p>
            <p>Username: { user.username }</p>
            <button onClick={ (e) => {
              localStorage.removeItem("quotes_user_token");
              window.location.href = "/dash";
            }}>Sign out local</button>
          </div>
        ) : (
          <div>
            <a href="http://192.168.225.128:3002?appza_id=1">Login</a>
          </div>
        )
      }
      
      <Footer />
    </React.Fragment>
  );
}

export default Dash;