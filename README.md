# WhatsApp & Messenger Lead Context Tracker | Tracking with Shadin

The **WhatsApp & Messenger Lead Context Tracker** is a Google Tag Manager variable template that helps business owners and sales teams understand exactly which product or page a user was interested in when they clicked the chat button.

## The Problem
Normally, when a user clicks a WhatsApp button, the message is generic: *"Hi, I want to know more."* The sales team then has to ask which product they are talking about, leading to delays and lost interest.

## The Solution
This template dynamically generates a link that auto-fills a detailed message like:  
> *"Hi, I am interested in **iPhone 15 Pro** at price **$999**. Source: https://yourshop.com/product/iphone-15-pro"*

## Key Features

- **Standardized Links**: Handles phone number formatting automatically.
- **Dynamic Context**: Appends Product Name, Price, and the exact Page URL to the message.
- **Auto-Detection Support**: Works with Page Titles or Data Layer variables.
- **URL Safe**: Automatically encodes the message for reliable link behavior across all browsers.
- **Multi-Platform**: Supports both WhatsApp and Facebook Messenger (m.me).

## How to Use

1. **Create Variable**: Create a new variable using this template in GTM.
2. **Configure**: Enter your phone number and map your Product Name/Price variables.
3. **Trigger**: Use the variable in your tags or via the automatic script below.

---

## 🚀 Automatic Implementation (GTM Custom HTML Tag)

If you want to apply this smart link to **all WhatsApp buttons** on your website automatically, follow these steps:

1. Create a **Custom HTML Tag** in GTM.
2. Paste the following script:

```html

<script>
  (function() {
    function updateWALinks() {
      var smartLink = "{{WhatsApp & Messenger Lead Context Tracker | Tracking with Shadin 1}}";
      var waButtons = document.querySelectorAll('a[href*="wa.me"], a[href*="whatsapp.com"]');
      
      if (smartLink && smartLink.indexOf('this%20product') === -1 && waButtons.length > 0) {
        for (var i = 0; i < waButtons.length; i++) {
          waButtons[i].href = smartLink;
        }
      }
    }

    updateWALinks();

    window.addEventListener('message', function(event) {});
    
    setTimeout(updateWALinks, 2000);
    setTimeout(updateWALinks, 5000);
  })();
</script>
```

3. Set the trigger to **Custom Event: view_item** (or All Pages if view_item is not available).
4. **Publish!** Your WhatsApp messages are now smart and context-aware.

---

## Developed By

**Md Sadikul Islam Shadin**  
[LinkedIn Profile](https://www.linkedin.com/in/sadikulshadin/)
