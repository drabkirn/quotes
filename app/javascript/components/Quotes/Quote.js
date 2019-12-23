import React, { useEffect } from 'react';
import { Link, Redirect } from 'react-router-dom';
import { useSelector, useDispatch } from "react-redux";
import { Helmet } from "react-helmet";

import MainHeader from '../Shared/MainHeader';
import Footer from '../Shared/Footer';
import { fetchAllQuotes } from '../../store/actions/quotesActions';

function Quote(props) {
  const quoteId = parseInt(props.match.params.id);
  if(!quoteId){
    return <Redirect to="/quotes" />;
  }

  // Get the Redux state
  const store = useSelector(store => store);

  const allQuotes = store.quotes.quotes;
  const allQuotesError = store.quotes.err;

  // Get the Redux Dispatch
  const dispatch = useDispatch();

  // React Hook for ComponentDidMount
  useEffect(() => {
    if(!allQuotes) {
      dispatch(fetchAllQuotes());
    }
  }, []);

  if(allQuotes) {
    const allQuotesLength = allQuotes.length;
    if(quoteId < 0 || quoteId > allQuotesLength) return <Redirect to="/quotes" />;
  }

  return (
    <React.Fragment>
      <Helmet>
        <title>{ allQuotes ? (allQuotes[quoteId - 1].title + ` | Quote ${quoteId}`) : (`Drabkirn Quote ${quoteId}`) }</title>

        <meta name="description" content={ allQuotes ? (allQuotes[quoteId - 1].content) : ("Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life. We write about anything, anywhere for anyone.") } />

        {/* Facebook Meta */}
        <meta property="og:url" content={ `https://drabkirn.quotes.cdadityang.xyz/quotes/${quoteId}` } />
        <meta property="og:image" content="https://drabkirn.quotes.cdadityang.xyz/content/images/drabkirn-logo-180x180.png" />
        <meta property="og:description" content={ allQuotes ? (allQuotes[quoteId - 1].content) : ("Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life. We write about anything, anywhere for anyone.") } />
        <meta property="og:title" content={ allQuotes ? (allQuotes[quoteId - 1].title + ` | Quote ${quoteId}`) : (`Drabkirn Quote ${quoteId}`) } />
        <meta property="og:site_name" content={ allQuotes ? (allQuotes[quoteId - 1].title + ` | Quote ${quoteId}`) : (`Drabkirn Quote ${quoteId}`) } />
        <meta property="og:see_also" content="https://drabkirn.quotes.cdadityang.xyz/quotes" />

        {/* G+ Meta tags */}
        <meta itemprop="name" content={ allQuotes ? (allQuotes[quoteId - 1].title + ` | Quote ${quoteId}`) : (`Drabkirn Quote ${quoteId}`) } />
        <meta itemprop="description" content={ allQuotes ? (allQuotes[quoteId - 1].content) : ("Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life. We write about anything, anywhere for anyone.") } />
        <meta itemprop="image" content="https://drabkirn.quotes.cdadityang.xyz/content/images/drabkirn-logo-180x180.png" />

        {/* Twitter Meta Tags */}
        <meta name="twitter:card" content="summary" />
        <meta name="twitter:url" content={ `https://drabkirn.quotes.cdadityang.xyz/quotes/${quoteId}` } />
        <meta name="twitter:title" content={ allQuotes ? (allQuotes[quoteId - 1].title + ` | Quote ${quoteId}`) : (`Drabkirn Quote ${quoteId}`) } />
        <meta name="twitter:description" content={ allQuotes ? (allQuotes[quoteId - 1].content) : ("Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life. We write about anything, anywhere for anyone.") } />
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
        <div className="container mt-50">
          {
            allQuotesError ? (
              <React.Fragment>
                <div className="jumbo error-jumbo">
                  <p>{ allQuotesError.message }</p>
                </div>
              </React.Fragment>
            ) : (
              <React.Fragment>
                <h3 className="align-center mb-35">{ allQuotes && allQuotes[quoteId - 1].title }</h3>
                <blockquote>{allQuotes && allQuotes[quoteId - 1].content}</blockquote>
                <p className="align-right"><b><em>- { allQuotes && allQuotes[quoteId - 1].author }</em></b></p>
              </React.Fragment>
            )
          }
        </div>

        <div className="container align-center mt-60">
          <Link to={"/quotes"} className="btn wide-btn">Back</Link>
        </div>
      </section>

      <Footer />
    </React.Fragment>
  );
}

export default Quote;