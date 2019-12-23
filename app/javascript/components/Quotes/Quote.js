import React, { useEffect } from 'react';
import { Link, Redirect } from 'react-router-dom';
import { useSelector, useDispatch } from "react-redux";

import MainHeader from '../Shared/MainHeader';
import Footer from '../Shared/Footer';
import { fetchQuote } from '../../store/actions/quotesActions';

function Quote(props) {
  const quoteId = parseInt(props.match.params.id);
  if(!quoteId){
    return <Redirect to="/quotes" />;
  }

  // Get the Redux state
  const store = useSelector(store => store);

  const myQuote = store.quotes.quote;
  const myQuoteError = store.quotes.err;
  console.log(store)

  // Get the Redux Dispatch
  const dispatch = useDispatch();

  // React Hook for ComponentDidMount
  useEffect(() => {
    dispatch(fetchQuote(quoteId));
  }, []);

  return (
    <React.Fragment>
      <MainHeader />

      <section>
        <div className="container mt-50">
          {
            myQuoteError ? (
              <React.Fragment>
                <div className="jumbo error-jumbo">
                  <p>{ myQuoteError.message }</p>
                </div>
              </React.Fragment>
            ) : (
              <React.Fragment>
                <h3 className="align-center mb-35">{ myQuote && myQuote.title }</h3>
                <blockquote>{myQuote && myQuote.content}</blockquote>
                <p className="align-right"><b><em>- { myQuote && myQuote.author }</em></b></p>
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