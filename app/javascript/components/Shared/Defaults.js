export const DRABKRIN_QUOTES_BASE_URL = "https://drabkirn.quotes.cdadityang.xyz";

let authnaURL = "";
let authnaAppzaID = 1;
if(process.env.NODE_ENV == "development") {
  authnaURL = "http://192.168.225.128:3002";
  authnaAppzaID = 1;
} else {
  authnaURL = "https://drabkirn.authna.cdadityang.xyz";
  authnaAppzaID = 1;
}

export const DRABKRIN_AUTHNA_BASE_URL = authnaURL;

export const DRABKRIN_AUTHNA_APPZA_ID = authnaAppzaID;