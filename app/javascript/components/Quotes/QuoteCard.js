import React from 'react';
import { Link } from 'react-router-dom';

import { QUOTPA_BASE_URL } from '../Shared/Defaults';

function QuoteCard(props) {
  const twitterShareURL = `https://twitter.com/intent/tweet?text=${ props.quoteContent }&hashtags=quotpa,quote&url=${QUOTPA_BASE_URL}/quotes/${props.quoteId}&via=brinkirn`;

  const whatsAppShareURL = `https://api.whatsapp.com/send?text=${ props.quoteContent }. See more at ${QUOTPA_BASE_URL}`

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
        </div>
      </div>
    </React.Fragment>
  );
}

export default QuoteCard;