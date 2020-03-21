import React, { useEffect } from 'react';
import { Link, Redirect } from 'react-router-dom';
import { useSelector, useDispatch } from "react-redux";
import { Helmet } from "react-helmet";

import MainHeader from '../Shared/MainHeader';
import Footer from '../Shared/Footer';
import { DRABKRIN_AUTHNA_BASE_URL, DRABKRIN_AUTHNA_APPZA_ID } from '../Shared/Defaults';

import { fetchUserInfo, deleteUserAccount } from '../../store/actions/usersActions';

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
  const { user, err } = store.users;

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
      <Helmet>
        <title>Dashboard | Drabkirn Quotes</title>

        <meta name="description" content="A dashboard that manages your content and gives you access keys to our Quotes API, all in one place with secure login from Authna." />

        {/* Facebook Meta */}
        <meta property="og:url" content="https://drabkirn.quotes.cdadityang.xyz" />
        <meta property="og:image" content="https://drabkirn.quotes.cdadityang.xyz/content/images/drabkirn-logo-180x180.png" />
        <meta property="og:description" content="A dashboard that manages your content and gives you access keys to our Quotes API, all in one place with secure login from Authna." />
        <meta property="og:title" content="Dashboard | Drabkirn Quotes" />
        <meta property="og:site_name" content="Dashboard | Drabkirn Quotes" />
        <meta property="og:see_also" content="https://drabkirn.quotes.cdadityang.xyz" />

        {/* G+ Meta tags */}
        <meta itemprop="name" content="Dashboard | Drabkirn Quotes" />
        <meta itemprop="description" content="A dashboard that manages your content and gives you access keys to our Quotes API, all in one place with secure login from Authna." />
        <meta itemprop="image" content="https://drabkirn.quotes.cdadityang.xyz/content/images/drabkirn-logo-180x180.png" />

        {/* Twitter Meta Tags */}
        <meta name="twitter:card" content="summary" />
        <meta name="twitter:url" content="https://drabkirn.quotes.cdadityang.xyz" />
        <meta name="twitter:title" content="Dashboard | Drabkirn Quotes" />
        <meta name="twitter:description" content="A dashboard that manages your content and gives you access keys to our Quotes API, all in one place with secure login from Authna." />
        <meta name="twitter:image" content="https://drabkirn.quotes.cdadityang.xyz/content/images/drabkirn-logo-180x180.png" />
        
        {/* Themes Meta */}
        <meta name="theme-color" content="#A53860" />
        <meta name="msapplication-navbutton-color" content="#A53860" />
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="#A53860" />
        
        {/* icons meta */}
        <link rel="apple-touch-icon" sizes="180x180" href="/content/images/apple-touch-icon.png" />
        <link rel="icon" type="image/png" href="/content/images/favicon-32x32.png" sizes="32x32" />
        <link rel="icon" type="image/png" href="/content/images/favicon-16x16.png" sizes="16x16" />
      </Helmet>

      <MainHeader />

      <section>
        <div className="container">
          <div className="dash-heading align-center mb-40">
            <h1>Dashboard</h1>
            <u className="u-gold italic">Manage your content and API access, all in one place with secure login from Authna. Before continuing, it is said that it's good to check our <a href="https://drabkirn.cdadityang.xyz/legal/privacy_policy" target="_blank" rel="noopener noreferrer">Privacy Policy</a> and <a href="https://drabkirn.cdadityang.xyz/legal/terms_conditions" target="_blank" rel="noopener noreferrer">Terms & Conditions</a>.</u>
          </div>

          <div className="dash-content align-center">
            {
              err ? (
                <div className="jumbo error-jumbo">
                  <p>{ err.message }.</p>
                </div>
              ) : ("")
            }

            {
              user ? (
                <React.Fragment>
                  <table className="table-inside-container">
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
                    <br />
                    <button className="btn wide-btn" onClick = { (e) => {
                      let confirmDeletion = confirm('Are you sure you want to delete your account? This deletion will not have any impact on your Authna instance. Click "Ok" to confirm, or "Cancel" to cancel deletion.');
                      if(confirmDeletion){
                        const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');
                        dispatch(deleteUserAccount(quotesUserToken, csrfToken));
                        localStorage.removeItem("quotes_user_token");
                      }
                    }}>Delete Account</button>
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