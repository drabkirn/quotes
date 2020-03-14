import React from 'react';
import { Link } from 'react-router-dom';

import { DRABKRIN_QUOTES_BASE_URL } from '../Shared/Defaults';

function QuoteCard(props) {
  const twitterCharLimit = 220;
  const twitterTruncatedText = textTruncate(props.quoteContent, twitterCharLimit);
  const facebookShareURL = `https://www.facebook.com/sharer/sharer.php?u=https://drabkirn.quotes.cdadityang.xyz/quotes/${props.quoteId}`;
  const linkedinShareURL = `https://www.linkedin.com/sharing/share-offsite/?url=https://drabkirn.quotes.cdadityang.xyz/quotes/${props.quoteId}`;

  const twitterShareURL = `https://twitter.com/intent/tweet?text=${ twitterTruncatedText }%0A&hashtags=drabkirn,quote&url=${DRABKRIN_QUOTES_BASE_URL}/quotes/${props.quoteId}&via=drabkirn`;

  const whatsAppShareURL = `https://api.whatsapp.com/send?text=${ props.quoteContent }%0A%0A See more at ${DRABKRIN_QUOTES_BASE_URL}`

  return (
    <React.Fragment>
      <div className="card col-dsk-6 col-mob-12 mt-20 ml-10">
        <div className="card-header align-center pb-5">
          <h3><Link to={ "/quotes/" + props.quoteId }>{props.quoteId}. { props.quoteTitle }</Link></h3>
        </div>
        <div className="card-content pt-5 pb-5">
          <p><Link to={ "/quotes/" + props.quoteId }>{ props.quoteContent }</Link></p>
        </div>
        <div className="card-footer align-center pt-10 pb-5">
          <a className="ml-5" href={ twitterShareURL } target="_blank" rel="noopener noreferrer"><img src="/content/icons/if-twitter-50x50.svg" alt="twtr-share-icon" /></a>
          <a className="ml-5" href={ whatsAppShareURL } target="_blank" rel="noopener noreferrer"><img src="/content/icons/if-whatsapp-50x50.svg" alt="wapp-share-icon" /></a>
          <a className="ml-5" href={ facebookShareURL } target="_blank" rel="noopener noreferrer"><img src="/content/icons/if-facebook-50x50.svg" alt="fb-share-icon" /></a>
          <a className="ml-5" href={ linkedinShareURL } target="_blank" rel="noopener noreferrer"><img src="/content/icons/if-linkedin-50x50.svg" alt="linkedin-share-icon" /></a>
        </div>
      </div>
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

export default QuoteCard;