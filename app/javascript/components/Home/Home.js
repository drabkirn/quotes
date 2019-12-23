import React, { useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useSelector, useDispatch } from "react-redux";
import { Helmet } from "react-helmet";

import MainHeader from '../Shared/MainHeader';
import Footer from '../Shared/Footer';
import { fetchAllQuotes } from '../../store/actions/quotesActions';

function Home() {
  // Get the Redux state
  const store = useSelector(store => store);
  
  const allQuotes = store.quotes.quotes;
  const allQuotesError = store.quotes.err;

  let randomNumber;
  if(allQuotes){
    randomNumber = Math.floor(Math.random() * allQuotes.length)
  }

  // Get the Redux Dispatch
  const dispatch = useDispatch();

  // React Hook for ComponentDidMount
  useEffect(() => {
    if(!allQuotes) {
      dispatch(fetchAllQuotes());
    }
  }, []);

  return (
    <React.Fragment>
      <Helmet>
        <title>Drabkirn Quotes - Redefined inspiration in some words</title>

        <meta name="description" content="Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life. We write about anything, anywhere for anyone." />

        {/* Facebook Meta */}
        <meta property="og:url" content="https://drabkirn.quotes.cdadityang.xyz" />
        <meta property="og:image" content="https://drabkirn.quotes.cdadityang.xyz/content/images/drabkirn-logo-180x180.png" />
        <meta property="og:description" content="Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life. We write about anything, anywhere for anyone." />
        <meta property="og:title" content="Drabkirn Quotes - Redefined inspiration in some words" />
        <meta property="og:site_name" content="Drabkirn Quotes - Redefined inspiration in some words" />
        <meta property="og:see_also" content="https://drabkirn.quotes.cdadityang.xyz" />

        {/* G+ Meta tags */}
        <meta itemprop="name" content="Drabkirn Quotes - Redefined inspiration in some words" />
        <meta itemprop="description" content="Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life. We write about anything, anywhere for anyone." />
        <meta itemprop="image" content="https://drabkirn.quotes.cdadityang.xyz/content/images/drabkirn-logo-180x180.png" />

        {/* Twitter Meta Tags */}
        <meta name="twitter:card" content="summary" />
        <meta name="twitter:url" content="https://drabkirn.quotes.cdadityang.xyz" />
        <meta name="twitter:title" content="Drabkirn Quotes - Redefined inspiration in some words" />
        <meta name="twitter:description" content="Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life. We write about anything, anywhere for anyone." />
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
          <p>
            We usually release a new quote every Tuesday. We're also setting up an API so that developers can integrate our quotes in their applications. Here's a random quote for you to get started:
          </p>

          {
            allQuotes ? (
              <blockquote>
                {
                  allQuotes && allQuotes[randomNumber].content
                }
              </blockquote>
            ) : ("")
          }

          {
            allQuotesError ? (
              <div className="mt-20">
                <div className="jumbo error-jumbo mt-30">
                  <p>{ allQuotesError.message }</p>
                </div>
              </div>
            ) : ("")
          }

          <div className="align-center mt-50">
            <Link to={"/quotes"} className="btn wide-btn mb-20">All Quotes</Link>
          </div>
        </div>
      </section>

      <Footer />
    </React.Fragment>
  );
}

export default Home;