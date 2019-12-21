import React from 'react';
import { Link } from 'react-router-dom';

function MainHeader() {
  return (
    <React.Fragment>
      <header>
        <div className="header-intro-dsk">
          <div className="header-intro-dsk-logo col-dsk-4 align-center mt-30 mb-20">
            <Link to={"/"}><img src="/content/images/drabkirn-logo-180x180.png" alt="Drabkirn Logo" /></Link>
          </div>
          <div className="header-intro-dsk-content col-dsk-8">
            <h1>Drabkirn Quotes</h1>
            <p className="fs-1-6">Redefined inspiration in some words. Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life.</p>
          </div>
        </div>

        <div className="float-clearfix"></div>

        <div className="header-intro-mob">
          <div className="header-intro-mob-logo align-center mt-30">
            <Link to={"/"}><img src="/content/images/drabkirn-logo-180x180.png" alt="Drabkirn Logo" /></Link>
          </div>
          <div className="container header-intro-mob-content">
            <h1 className="align-center">Drabkirn Quotes</h1>
            <p>Redefined inspiration in some words. Collection of quotes from Drabkirn to change your mindset to achieve more, get inspired, and improve your life.</p>
          </div>
        </div>

        <hr />
        
      </header>
    </React.Fragment>
  );
}

export default MainHeader;