import React, { useEffect } from 'react';
import { Link, Redirect } from 'react-router-dom';
import { useSelector, useDispatch } from "react-redux";
import { Helmet } from "react-helmet";

import MainHeader from '../Shared/MainHeader';
import Footer from '../Shared/Footer';
import { DRABKRIN_QUOTES_BASE_URL } from '../Shared/Defaults';
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

  let formattedPubDate;
  if(allQuotes && allQuotes[quoteId - 1]) {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    const pubDate = new Date((allQuotes[quoteId - 1]).created_at)
    formattedPubDate = pubDate.toLocaleDateString("en-US", options);
  }

  // Sharing URLS
  const twitterCharLimit = 220;
  let twitterTruncatedText;
  let twitterShareURL;
  let whatsAppShareURL;
  const facebookShareURL = `https://www.facebook.com/sharer/sharer.php?u=https%3A//drabkirn.quotes.cdadityang.xyz/quotes/${quoteId}`;
  const linkedinShareURL = `https://www.linkedin.com/sharing/share-offsite/?url=https://drabkirn.quotes.cdadityang.xyz/quotes/${quoteId}`;
  if(allQuotes && allQuotes[quoteId - 1]) {
    twitterTruncatedText = textTruncate(allQuotes[quoteId - 1].content, twitterCharLimit); 
    twitterShareURL = `https://twitter.com/intent/tweet?text=${ twitterTruncatedText }%0A&hashtags=drabkirn,quote&url=${DRABKRIN_QUOTES_BASE_URL}/quotes/${quoteId}&via=drabkirn`;
    whatsAppShareURL = `https://api.whatsapp.com/send?text=${ allQuotes[quoteId - 1].content }%0A%0A See more at ${DRABKRIN_QUOTES_BASE_URL}`;
  }

  return (
    <React.Fragment>
      <Helmet>
        <title>{ allQuotes ? (allQuotes[quoteId - 1].title + ` | Quote ${quoteId} | Drabkirn Quotes`) : (`Drabkirn Quote ${quoteId}`) }</title>

        <meta name="description" content={ allQuotes ? (allQuotes[quoteId - 1].content) : ("We write thoughts in the form to redefine inspiration in a few words. Change your mindset to achieve more, get inspired, and improve your life along with us.") } />

        {/* Facebook Meta */}
        <meta property="og:url" content={ `https://drabkirn.quotes.cdadityang.xyz/quotes/${quoteId}` } />
        <meta property="og:image" content="https://drabkirn.quotes.cdadityang.xyz/content/images/drabkirn-logo-180x180.png" />
        <meta property="og:description" content={ allQuotes ? (allQuotes[quoteId - 1].content) : ("We write thoughts in the form to redefine inspiration in a few words. Change your mindset to achieve more, get inspired, and improve your life along with us.") } />
        <meta property="og:title" content={ allQuotes ? (allQuotes[quoteId - 1].title + ` | Quote ${quoteId} | Drabkirn Quotes`) : (`Drabkirn Quote ${quoteId}`) } />
        <meta property="og:site_name" content={ allQuotes ? (allQuotes[quoteId - 1].title + ` | Quote ${quoteId} | Drabkirn Quotes`) : (`Drabkirn Quote ${quoteId}`) } />
        <meta property="og:see_also" content="https://drabkirn.quotes.cdadityang.xyz/quotes" />

        {/* G+ Meta tags */}
        <meta itemprop="name" content={ allQuotes ? (allQuotes[quoteId - 1].title + ` | Quote ${quoteId} | Drabkirn Quotes`) : (`Drabkirn Quote ${quoteId}`) } />
        <meta itemprop="description" content={ allQuotes ? (allQuotes[quoteId - 1].content) : ("We write thoughts in the form to redefine inspiration in a few words. Change your mindset to achieve more, get inspired, and improve your life along with us.") } />
        <meta itemprop="image" content="https://drabkirn.quotes.cdadityang.xyz/content/images/drabkirn-logo-180x180.png" />

        {/* Twitter Meta Tags */}
        <meta name="twitter:card" content="summary" />
        <meta name="twitter:url" content={ `https://drabkirn.quotes.cdadityang.xyz/quotes/${quoteId}` } />
        <meta name="twitter:title" content={ allQuotes ? (allQuotes[quoteId - 1].title + ` | Quote ${quoteId} | Drabkirn Quotes`) : (`Drabkirn Quote ${quoteId}`) } />
        <meta name="twitter:description" content={ allQuotes ? (allQuotes[quoteId - 1].content) : ("We write thoughts in the form to redefine inspiration in a few words. Change your mindset to achieve more, get inspired, and improve your life along with us.") } />
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
                <h2 className="align-center mb-35"><u className="u-quotes-pink">{ allQuotes && allQuotes[quoteId - 1].title }</u></h2>
                <blockquote>{allQuotes && allQuotes[quoteId - 1].content}</blockquote>
                <p className="align-right p-badgetag p-quotes-by"><span className="badgetag badgetag-quotes-pink"><b><em>- { allQuotes && allQuotes[quoteId - 1].author }</em></b></span></p>

                <p className="p-badgetag mt-40"><span className="badgetag badgetag-orange">Published on: { formattedPubDate && formattedPubDate }</span></p>

                <div className="mt-40 align-center">
                  {
                    allQuotes && allQuotes[quoteId - 1].tags.map((tag) => {
                      return (
                        <p className="p-badgetag" key={tag}><Link to={"/quotes?tag=" + tag} className="badgetag badgetag-quotes-pink">{ tag }</Link></p>
                      );
                    })
                  }
                </div>

                <div className="mt-50">
                  <h2>Share em:</h2>
                  <p>
                    Hey, did you know, you can share our quotes directly from below, we save you from heavy-lifting COPY-PASTING them:
                  </p>
                </div>

                <div className="quote-share-btns mt-50">
                  <a className="ml-15" href={ twitterShareURL } target="_blank" rel="noopener noreferrer"><img src="/content/icons/if-twitter-50x50.svg" alt="twtr-share-icon" /></a>
                  <a className="ml-15" href={ whatsAppShareURL } target="_blank" rel="noopener noreferrer"><img src="/content/icons/if-whatsapp-50x50.svg" alt="wapp-share-icon" /></a>
                  <a className="ml-15" href={ facebookShareURL } target="_blank" rel="noopener noreferrer"><img src="/content/icons/if-facebook-50x50.svg" alt="fb-share-icon" /></a>
                  <a className="ml-15" href={ linkedinShareURL } target="_blank" rel="noopener noreferrer"><img src="/content/icons/if-linkedin-50x50.svg" alt="linkedin-share-icon" /></a>
                </div>
              </React.Fragment>
            )
          }
        </div>

        <div className="container align-center mt-60">
          { quoteId === 1 ? ("") : (
            <Link to={`/quotes/${quoteId - 1}`} className="btn">&#60;==</Link>
          )}
          <Link to={"/quotes"} className="btn wide-btn">Back</Link>
          { !allQuotes ? ("") : (
            quoteId === allQuotes.length ? ("") : (
              <Link to={`/quotes/${quoteId + 1}`} className="btn">==&#62;</Link>
            )
          ) }
        </div>
      </section>

      <Footer />
    </React.Fragment>
  );
}

function textTruncate(text, textLimit) {
  if(text.length > textLimit) {
    return text.substring(0, textLimit) + "...";
  } else {
    return text;
  }
}

export default Quote;