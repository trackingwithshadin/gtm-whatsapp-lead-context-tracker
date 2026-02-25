___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "WhatsApp & Messenger Lead Context Tracker | Tracking with Shadin",
  "description": "Generate dynamic WhatsApp/Messenger links that include product name, price, and page URL. Perfect for tracking which item leads were interested in.",
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
    "simpleValueType": true,
    "defaultValue": "whatsapp"
  },
  {
    "type": "TEXT",
    "name": "targetId",
    "displayName": "Phone Number (WA) / Username (Messenger)",
    "simpleValueType": true,
    "helpHint": "e.g. 8801712345678 (WA) or yourfacebookusername (Messenger)"
  },
  {
    "type": "GROUP",
    "name": "messageSettings",
    "displayName": "Message Context Settings",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "prefix",
        "displayName": "Message Prefix",
        "simpleValueType": true,
        "defaultValue": "Hi, I am interested in "
      },
      {
        "type": "TEXT",
        "name": "productName",
        "displayName": "Product Name Variable",
        "simpleValueType": true,
        "helpHint": "e.g. {{dlv - product name}} or {{Page Title}}"
      },
      {
        "type": "CHECKBOX",
        "name": "includePrice",
        "displayName": "Include Price in Message?",
        "simpleValueType": true,
        "defaultValue": true
      },
      {
        "type": "TEXT",
        "name": "productPrice",
        "displayName": "Product Price Variable",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "elementName": "includePrice",
            "type": "EQUALS",
            "checkType": "EQUALS",
            "value": true
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "includeUrl",
        "displayName": "Include Page URL?",
        "simpleValueType": true,
        "defaultValue": true
      }
    ]
  }
]


___SANDBOX_JS_FOR_WEB_TEMPLATE___

const makeString = require('makeString');
const encodeUriComponent = require('encodeUriComponent');
const queryPermission = require('queryPermission');
const getUrl = require('getUrl');

// 1. Target ID Cleanup
let target = makeString(data.targetId || '').trim();
if (!target) return undefined;

// For WhatsApp: remove all non-digits (except maybe +)
if (data.platform === 'whatsapp') {
  let cleanWa = '';
  for (let i = 0; i < target.length; i++) {
    const char = target[i];
    if (char >= '0' && char <= '9') cleanWa += char;
  }
  target = cleanWa;
}

// 2. Build Message
let message = makeString(data.prefix || '');
const product = makeString(data.productName || '');
const price = makeString(data.productPrice || '');

if (product) {
  message += product;
}

if (data.includePrice && price) {
  message += ' priced at ' + price;
}

if (data.includeUrl) {
  const currentUrl = getUrl();
  if (currentUrl) {
    message += '. Reference URL: ' + currentUrl;
  }
}

// 3. Construct Final URL
const encodedMessage = encodeUriComponent(message.trim());

if (data.platform === 'whatsapp') {
  return 'https://wa.me/' + target + '/?text=' + encodedMessage;
}

if (data.platform === 'messenger') {
  // Messenger doesn't support pre-filled text in same way as WA natively via URL
  // But we return a clean link. If context is needed, usually it's better via ref or just the link.
  return 'https://m.me/' + target;
}

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
        },
        {
          "key": "queries",
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

Dynamic Lead Context Tracker for WhatsApp and Messenger. Helps business owners know exactly which product sparked user interest.


___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.
