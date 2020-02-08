import React, { useEffect } from 'react';
import { Link, Redirect } from 'react-router-dom';
import { useSelector, useDispatch } from "react-redux";

import MainHeader from '../Shared/MainHeader';
import Footer from '../Shared/Footer';
import { DRABKRIN_AUTHNA_BASE_URL, DRABKRIN_AUTHNA_APPZA_ID } from '../Shared/Defaults';

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

      <section>
        <div className="container">
          <div className="dash-heading align-center mb-40">
            <h1>Dashboard</h1>
            <u class="u-gold italic">Manage your content and API access, all in one place.</u>
          </div>

          <div className="dash-content align-center">
            {
              user ? (
                <React.Fragment>
                  <table class="table-inside-container">
                    <thead>
                      <tr>
                        <th>Name</th>
                        <th>Value</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td>User ID</td>
                        <td>{ user.id }</td>
                      </tr>
                      <tr>
                        <td>Username</td>
                        <td>{ user.username }</td>
                      </tr>
                      <tr>
                        <td>Quotes Token</td>
                        <td>{ user.quotes_token }</td>
                      </tr>
                      <tr>
                        <td>Your API Count</td>
                        <td>{ user.quotes_api_count }</td>
                      </tr>
                    </tbody>
                  </table>

                  <div className="dash-signout mt-50">
                    <button className="btn wide-btn" onClick={ (e) => {
                      localStorage.removeItem("quotes_user_token");
                      window.location.href = "/dash";
                    }}>Sign out local</button>
                  </div>
                </React.Fragment>
              ) : (
                <div>
                  <a href={ DRABKRIN_AUTHNA_BASE_URL + "?appza_id=" +  DRABKRIN_AUTHNA_APPZA_ID} className="btn wide-btn">Login</a>
                </div>
              )
            }
          </div>
        </div>

        <div className="container align-center mt-30">
          <Link to={"/"} className="btn wide-btn">Back</Link>
        </div>
      </section>
      
      <Footer />
    </React.Fragment>
  );
}

export default Dash;