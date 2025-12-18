---
````md
# 📧 Mail Composer Demo App (iOS)

A simple iOS demo application showcasing how to compose and send emails using  
`MFMailComposeViewController` from the **MessageUI** framework.

This project demonstrates best practices for:

- Sending pre-filled emails
- Handling mail composer results
- Using HTML-formatted email bodies
- Working with real devices (Mail app integration)

---

## 🚀 Features

- ✅ Compose email using native iOS Mail UI
- ✅ Pre-fill recipient, subject, and body
- ✅ Support for **HTML-formatted email body**
- ✅ Handles mail states: Sent, Saved, Cancelled, Failed
- ✅ Graceful fallback when Mail is not configured
- ✅ Clean and reusable email data model

---

## 🛠 Tech Stack

- **Language:** Swift
- **Framework:** UIKit
- **API:** MessageUI (`MFMailComposeViewController`)
- **Architecture:** MVC (Demo-focused)

---

## 📱 Requirements

- iOS 13+
- Xcode 14+
- **Real iOS device required** (Mail Composer does NOT work on Simulator)
- Mail app configured with at least one email account

---

## 📂 Project Structure

```text
MailComposerDemo
│
├── MailComposerViewController.swift
├── EmailContent.swift
├── StringConstants.swift
└── README.md
````

---

## 🧩 How It Works

1. User taps **Send Mail**
2. App checks if Mail services are available using:

```swift
MFMailComposeViewController.canSendMail()
```

3. Mail composer opens with pre-filled content
4. User sends, saves, or cancels the email
5. Result is handled via delegate callback

---

## ✉️ Sample Code

### Presenting Mail Composer

```swift
let composer = MFMailComposeViewController()
composer.mailComposeDelegate = self
composer.setToRecipients(["support@example.com"])
composer.setSubject("Support Request")
composer.setMessageBody(htmlBody, isHTML: true)
present(composer, animated: true)
```

---

### Handling Result

```swift
func mailComposeController(
    _ controller: MFMailComposeViewController,
    didFinishWith result: MFMailComposeResult,
    error: Error?
) {
    controller.dismiss(animated: true)

    switch result {
    case .sent:
        print("Mail sent")
    case .saved:
        print("Mail saved")
    case .cancelled:
        print("Mail cancelled")
    case .failed:
        print("Mail failed")
    @unknown default:
        break
    }
}
```

---

## 🌐 HTML Email Support

The app demonstrates converting plain-text or markdown-like content into
Mail-safe HTML before sending:

```swift
composer.setMessageBody(htmlBody, isHTML: true)
```

This allows:

* Headings
* Lists
* Structured support emails

---

## ⚠️ Important Notes

* ❌ Mail Composer **cannot be tested on Simulator**
* ❌ `.sent` does not guarantee delivery, only that the user tapped **Send**
* ❌ UI customization of Mail Composer is not allowed by Apple
* ✅ Always dismiss the composer in the delegate method

---

## 🎯 Use Cases

* Contact Support
* Bug Reporting
* Feedback Submission
* Enterprise / Internal Escalation Emails
* QA & Debug Tools

---

## 🧠 Learnings

* iOS uses system-controlled UI for email to ensure user privacy
* Apps cannot send emails silently
* Proper delegate handling is critical for good UX
* HTML emails must use valid, lightweight markup

---

## 📌 Future Improvements

* Attach logs or screenshots
* Add Share Sheet fallback (`UIActivityViewController`)
* Add analytics tracking for mail actions
* Convert implementation to SwiftUI

---

## 👩‍💻 Author

**Anukriti Jain**
iOS Developer | Swift | UIKit

```

---

If you want, I can also:
- Add **badges**
- Add a **screenshots section**
- Create a **SwiftUI version**
- Optimize this README for **job applications**

Just say the word 🚀
```
