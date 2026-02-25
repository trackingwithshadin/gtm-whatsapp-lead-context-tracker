___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "WhatsApp \u0026 Messenger Lead Context Tracker | Tracking with Shadin",
  "description": "Generate dynamic WhatsApp/Messenger links with product and page context for better lead conversion tracking.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "platform",
    "displayName": "Target Platform",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "whatsapp",
        "displayValue": "WhatsApp"
      },
      {
        "value": "messenger",
        "displayValue": "Messenger"
      }
    ],
    "defaultValue": "whatsapp"
  },
  {
    "type": "TEXT",
    "name": "targetId",
    "displayName": "Phone Number / Username",
    "helpHint": "e.g. 8801712345678 or mypageusername"
  },
  {
    "type": "TEXT",
    "name": "prefix",
    "displayName": "Message Prefix",
    "defaultValue": "Hi, I am interested in "
  },
  {
    "type": "TEXT",
    "name": "productName",
    "displayName": "Product Name",
    "helpHint": "Variable for product title"
  },
  {
    "type": "TEXT",
    "name": "productPrice",
    "displayName": "Product Price",
    "helpHint": "Variable for product price"
  },
  {
    "type": "CHECKBOX",
    "name": "includeUrl",
    "displayName": "Include Link to Page?",
    "defaultValue": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const makeString = require('makeString');
const encodeUriComponent = require('encodeUriComponent');
const getUrl = require('getUrl');

// 1. Target Validation
if (!data.targetId) return undefined;
let target = makeString(data.targetId).trim();

if (data.platform === 'whatsapp') {
  let clean = '';
  for (let i = 0; i < target.length; i++) {
    const c = target[i];
    if (c >= '0' && c <= '9') clean += c;
  }
  target = clean;
}

// 2. EXTRACTION LOGIC (Handle GTM "undefined" strings)
let pName = '';
if (data.productName) {
  pName = makeString(data.productName).trim();
}

// Check for GTM specific empty states
if (!pName || pName === 'undefined' || pName === 'null' || pName === '[object Object]') {
  pName = ''; 
}

let pPrice = '';
if (data.productPrice) {
  pPrice = makeString(data.productPrice).trim();
}

if (!pPrice || pPrice === 'undefined' || pPrice === 'null' || pPrice === '[object Object]') {
  pPrice = '';
}

// 3. Build Sentence
let msg = makeString(data.prefix || 'Hi, I am interested in ');

if (pName) {
  msg += pName;
} else {
  msg += 'this product';
}

if (pPrice) {
  msg += ' at price ' + pPrice;
}

if (data.includeUrl) {
  const url = getUrl();
  if (url) {
    msg += '. Source: ' + url;
  }
}

const finalMsg = encodeUriComponent(msg.trim());

if (data.platform === 'whatsapp') {
  return 'https://wa.me/' + target + '/?text=' + finalMsg;
}

return 'https://m.me/' + target;

return undefined;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Optimized version to fix "Invalid/missing string" error by cleaning up parameter structure and JS logic.


___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.
