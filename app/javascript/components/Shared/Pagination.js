import React from 'react';
import { Link } from 'react-router-dom';

function Pagination({ quotesPerPage, totalQuotes, tag, paginate }) {
  const pageNumbers = [];

  for(let i = 1; i <= Math.ceil(totalQuotes / quotesPerPage); i++) {
    pageNumbers.push(i);
  }

  return (
    <React.Fragment>
      <ul className="pagination fs-1-6 align-center mb-50 mt-50">
        {pageNumbers.map(number => {
          return(
            number === 1 ? (
              tag ? (
                <li key={number}><Link to={"?tag=" + tag} onClick={() => paginate(number)} className="pagination-active">{number}</Link></li>
              ) : (
                <li key={number}><Link to="#" onClick={() => paginate(number)} className="pagination-active">{number}</Link></li>
              )
            ) : (
              tag ? (
                <li key={number}><Link to={"?tag=" + tag} onClick={() => paginate(number)}>{number}</Link></li>
              ) : (
                <li key={number}><Link to="#" onClick={() => paginate(number)}>{number}</Link></li>
              )
            )
          );
        })}
      </ul>
    </React.Fragment>
  );
}

export default Pagination;