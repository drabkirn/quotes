import React, { useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useSelector, useDispatch } from "react-redux";

import MainHeader from '../Shared/MainHeader';
import Footer from '../Shared/Footer';
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
    dispatch(fetchAllQuotes());
  }, []);

  return (
    <React.Fragment>
      <MainHeader />

      <section>
        <div className="container">
          <p className="mb-20">We usually release a new quote every Tuesday. We're also setting up an API so that developers can integrate our quotes in their applications. Here are all of our quotes: <em>(Click on a quote card to see more...)</em></p>

          {
            allQuotes && allQuotes.map((quote) => {
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