import UIKit
import MessageUI

struct EmailContent {
    let type, mailto, emailSubject, emailBody: String
    let timestamp: String
    
    enum CodingKeys: String, CodingKey {
        case type, mailto
        case emailSubject = "email_subject"
        case emailBody = "email_body"
        case timestamp
    }
}

enum StringConstants {
    static let alertTitle = "Mail Not Configured"
    static let message = "Please configure a Mail account on your device."
    static let cancel = "Mail cancelled"
    static let save = "Mail saved"
    static let sent = "Mail sent"
    static let fail = "Mail failed"
}

class MailComposerViewController: UIViewController, MFMailComposeViewControllerDelegate {
    let mail = EmailContent(
        type: "Email",
        mailto: "anukriti.jain@coditas.com",
        emailSubject: "User Issue Escalation – Data Not Syncing in App (User ID: e4c733cb-cbbd-4e3a-89c7-93291aa7538e)",
        emailBody: "Hi Team,\n\n**User Details:**\n- User ID: e4c733cb-cbbd-4e3a-89c7-93291aa7538e\n- Tenant ID: c5f66516-b6e2-4ce1-bffa-b828541b369d\n\n**Summary of the Issue:**\nThe user is experiencing persistent issues with their data not reflecting in the app despite multiple troubleshooting attempts. They have tried checking the device connection, syncing data manually, restarting the app, checking for app updates, rebooting the device, clearing the app cache, reinstalling the app, checking permissions, and verifying their account login. The issue remains unresolved, and further assistance is required.\n\n**User's Messages:**\n\"My data is not getting reflecting in the app\"\n\"after restarting the app data is not there\"\n\n**Action Needed:**\nPlease investigate the issue further and reach out to the user with the next steps or resolution.",
        timestamp: "2025-12-17"
    )
    
    @IBAction func sendMail(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else {
            showErrorMessage()
            return
        }
        
        let composePicker = MFMailComposeViewController()
        let htmlBody = convertToHTML(from: mail.emailBody)
        composePicker.mailComposeDelegate = self
        composePicker.setToRecipients([mail.mailto])
        composePicker.setSubject(mail.emailSubject)
        composePicker.setMessageBody(htmlBody, isHTML: true)
        
        present(composePicker, animated: true)
    }
    
    func showErrorMessage() {
        let alert = UIAlertController(
            title: StringConstants.alertTitle,
            message: StringConstants.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ) {
        controller.dismiss(animated: true) {
            let title: String
            let message: String

            switch result {
            case .cancelled:
                title = "Mail Cancelled"
                message = "You cancelled the email."

            case .saved:
                title = "Mail Saved"
                message = "Your email was saved as a draft."

            case .sent:
                title = "Mail Sent"
                message = "Your email has been sent successfully."

            case .failed:
                title = "Mail Failed"
                message = error?.localizedDescription ?? "Failed to send email."

            @unknown default:
                return
            }

            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    func convertToHTML(from text: String) -> String {
        
        var html = text
        
        // Convert **Heading** to <h3>
        let headingRegex = "\\*\\*(.*?)\\*\\*"
        html = html.replacingOccurrences(
            of: headingRegex,
            with: "<h3>$1</h3>",
            options: .regularExpression
        )
        
        // Convert list items (- item)
        html = html.replacingOccurrences(
            of: "- (.*)",
            with: "<li>$1</li>",
            options: .regularExpression
        )
        
        // Wrap list items inside <ul>
        if html.contains("<li>") {
            html = html.replacingOccurrences(of: "(<li>.*?</li>)",
                                             with: "<ul>$1</ul>",
                                             options: .regularExpression)
        }
        
        // Convert quoted messages to blockquote
        html = html.replacingOccurrences(
            of: "\"(.*?)\"",
            with: "<blockquote>$1</blockquote>",
            options: .regularExpression
        )
        
        // Convert line breaks
        html = html.replacingOccurrences(of: "\n", with: "<br/>")
        
        return """
        <html>
        <body style="font-family: -apple-system; font-size: 15px; color: #000;">
            \(html)
        </body>
        </html>
        """
    }
    
}


