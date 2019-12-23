import React, { useEffect } from 'react';
import { Link, Redirect } from 'react-router-dom';
import { useSelector, useDispatch } from "react-redux";

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