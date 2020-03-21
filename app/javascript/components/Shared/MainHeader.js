import React from 'react';
import { Link } from 'react-router-dom';

function MainHeader() {
  return (
    <React.Fragment>
      <header>
        <div className="header-intro-dsk">
          <div className="header-intro-dsk-logo col-dsk-4 align-center mt-50 mb-20">
            <Link to={"/"}><img src="/content/images/drabkirn-logo-180x180.png" alt="Drabkirn Logo" /></Link>
          </div>
          <div className="header-intro-dsk-content col-dsk-8">
            <h1>Drabkirn</h1>
            <h2>Quotes</h2>
            <p className="fs-1-6">We write thoughts in the form to redefine inspiration in a few words. Change your mindset to achieve more, get inspired, and improve your life along with us.</p>
          </div>
        </div>

        <div className="float-clearfix"></div>

        <div className="header-intro-mob align-center">
          <div className="header-intro-mob-logo mt-30">
            <Link to={"/"}><img src="/content/images/drabkirn-logo-180x180.png" alt="Drabkirn Logo" /></Link>
          </div>
          <div className="container header-intro-mob-content">
            <h1>Drabkirn</h1>
            <h2>Quotes</h2>
            <p>We write thoughts in the form to redefine inspiration in a few words. Change your mindset to achieve more, get inspired, and improve your life along with us.</p>
          </div>
        </div>

        <hr />
        
      </header>
    </React.Fragment>
  );
}

export default MainHeader;