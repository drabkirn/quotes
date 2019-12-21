import React, { useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useSelector, useDispatch } from "react-redux";

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
    dispatch(fetchAllQuotes());
  }, []);

  return (
    <React.Fragment>
      <MainHeader />

      <section>
        <div className="container">
          <p>
            We usually release a new quote every Tuesday. We're also setting up an API so that developers can integrate our quotes in their applications. Here's a random quote for you to get started:
          </p>

          <blockquote>
            {
              allQuotes && allQuotes[randomNumber].content
            }
            
            {
              allQuotesError && allQuotesError.message
            }
          </blockquote>

          <div className="align-center">
            <Link to={"/quotes"} className="btn wide-btn mb-20">All Quotes</Link>
            <br /><br />
            <a href="https://drabkirn.cdadityang.xyz" target="_blank" rel="noopener noreferrer" className="btn wide-btn">Drabkirn</a>
          </div>
        </div>
      </section>

      <Footer />
    </React.Fragment>
  );
}

export default Home;