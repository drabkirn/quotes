import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useSelector, useDispatch } from "react-redux";
import { Helmet } from "react-helmet";

import MainHeader from '../Shared/MainHeader';
import Footer from '../Shared/Footer';
import Pagination from '../Shared/Pagination';
import QuoteCard from './QuoteCard';
import { fetchAllQuotes } from '../../store/actions/quotesActions';

function Quotes() {
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

  // Setting defaults for pagination
  const [currentPage, setCurrentPage] = useState(1);
  const [quotesPerPage] = useState(10);

  // Get the listings for quotes
  const indexOfLastQuote = currentPage * quotesPerPage;
  const indexOfFirstQuote = indexOfLastQuote - quotesPerPage;

  // Show only first 10 quotes, then show pagination, so we slice the quotes
  let currentQuotes = [];
  if(allQuotes){
    currentQuotes = allQuotes.slice(indexOfFirstQuote, indexOfLastQuote);
  }

  // When user clicks on a paginate number, this will run.
  const paginate = (pageNumber) => {
    setCurrentPage(pageNumber);

    const paginationLiATags = document.querySelectorAll('.pagination li a');
    paginationLiATags.forEach((aTag) => aTag.className = "");
    paginationLiATags[pageNumber - 1].className = "pagination-active";

    window.location.href="#quotesintro";
  }

  return (
    <React.Fragment>
      <Helmet>
        <title>All Drabkirn Quotes - Redefined inspiration in some words</title>

        <meta name="description" content="Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life. We write about anything, anywhere for anyone." />

        {/* Facebook Meta */}
        <meta property="og:url" content="https://drabkirn.quotes.cdadityang.xyz/quotes" />
        <meta property="og:image" content="https://drabkirn.quotes.cdadityang.xyz/content/images/drabkirn-logo-180x180.png" />
        <meta property="og:description" content="Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life. We write about anything, anywhere for anyone." />
        <meta property="og:title" content="All Drabkirn Quotes - Redefined inspiration in some words" />
        <meta property="og:site_name" content="All Drabkirn Quotes - Redefined inspiration in some words" />
        <meta property="og:see_also" content="https://drabkirn.quotes.cdadityang.xyz" />

        {/* G+ Meta tags */}
        <meta itemprop="name" content="All Drabkirn Quotes - Redefined inspiration in some words" />
        <meta itemprop="description" content="Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life. We write about anything, anywhere for anyone." />
        <meta itemprop="image" content="https://drabkirn.quotes.cdadityang.xyz/content/images/drabkirn-logo-180x180.png" />

        {/* Twitter Meta Tags */}
        <meta name="twitter:card" content="summary" />
        <meta name="twitter:url" content="https://drabkirn.quotes.cdadityang.xyz" />
        <meta name="twitter:title" content="All Drabkirn Quotes - Redefined inspiration in some words" />
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
          <p className="mb-20">We usually release a new quote once a week, but in case we are very imaginative, we may come up with a couple of them per week. If you wish to, we've also set up an API so that you can integrate our quotes in your applications. You should check out our docs on how to work on our API.</p>

          <hr className="hr-center" />

          <p id="quotesintro">
            Anyways, enough of the introduction; Here are all the quotes straight from our database <em>(Click on a quote card to see more and don't forget to share)</em>
          </p>

          {
            currentQuotes && currentQuotes.map((quote) => {
              return(
                <React.Fragment key={ quote.id }>
                  <QuoteCard
                    quoteId={ quote.id }
                    quoteTitle={ quote.title }
                    quoteContent={ quote.content } />
                </React.Fragment>
              )
            })
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

          <div className="float-clearfix"></div>

          <div>
            <Pagination quotesPerPage={quotesPerPage} totalQuotes={allQuotes && allQuotes.length} paginate={paginate} />
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

export default Quotes;