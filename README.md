# WhatsApp & Messenger Lead Context Tracker | Tracking with Shadin

The **WhatsApp & Messenger Lead Context Tracker** is a Google Tag Manager variable template that helps business owners and sales teams understand exactly which product or page a user was interested in when they clicked the chat button.

## The Problem
Normally, when a user clicks a WhatsApp button, the message is generic: *"Hi, I want to know more."* The sales team then has to ask which product they are talking about, leading to delays and lost interest.

## The Solution
This template dynamically generates a link that auto-fills a detailed message like:  
> *"Hi, I am interested in **iPhone 15 Pro** priced at **$999**. Reference URL: https://myshop.com/iphone-15-pro"*

## Key Features

- **Standardized Links**: Handles phone number formatting automatically.
- **Dynamic Context**: Appends Product Name, Price, and the exact Page URL to the message.
- **URL Safe**: Automatically encodes the message for reliable link behavior across all browsers.
- **Multi-Platform**: Supports both WhatsApp and Facebook Messenger (m.me).

## How to Use

1. **Target ID**: Enter your WhatsApp number (with country code) or Messenger username.
2. **Product Name**: Map your Product Name variable (e.g., `{{Page Title}}` or `{{dlv - product name}}`).
3. **Price Settings**: Optional. Map your product price variable.
4. **Implementation**: Use this variable in your WhatsApp Button's "Link URL" field.

## Developed By

**Md Sadikul Islam Shadin**  
[LinkedIn Profile](https://www.linkedin.com/in/sadikulshadin/)
