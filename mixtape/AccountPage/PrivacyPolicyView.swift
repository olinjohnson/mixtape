//
//  PrivacyPolicyView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/19/24.
//

import SwiftUI
import MarkdownUI

struct PrivacyPolicyView: View {
    
    let str = """
    # Privacy Policy
     
    ### Effective Date: 8/19/2024

    ### 1. Introduction

    Welcome to Mixtape. We value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application Mixtape (the “App”), including when you interact with our App’s features such as authentication, image uploads, and music service integrations.

    ### 2. Information We Collect

    Personal Information: When you use our App, we collect personal information that you provide directly, including but not limited to:

    - Auth0 Authentication: Your email address and any other information you provide during authentication.
    - Image Uploads: Any images you upload through the App.
    - Music Service Integration: Information from your Spotify, Apple Music, Deezer, or Tidal accounts if you choose to connect them.

    ### 3. How We Use Your Information

    We use your information to:

    - Provide, operate, and maintain the App.
    - Authenticate your account and manage user sessions.
    - Process and manage your image uploads.
    - Integrate with music services to enhance your user experience.

    ### 4. How We Share Your Information

    We do not sell your personal information. However, we may share your information with:

    - Service Providers: We may engage third-party service providers (like Auth0) to assist with authentication, data storage, and other functions.
    - Music Service Providers: If you connect your music accounts, your information may be shared with Spotify, Apple Music, Deezer, or Tidal in accordance with their respective privacy policies.
    - Legal Requirements: We may disclose your information if required by law or in response to valid requests by public authorities.

    ### 5. Data Security

    We implement reasonable technical and organizational measures to protect your personal information from unauthorized access, use, or disclosure. However, no security measures are entirely foolproof, and we cannot guarantee absolute security.

    ### 6. Your Rights

    Depending on your jurisdiction, you may have certain rights regarding your personal information, such as:

    - Accessing, updating, or deleting your personal information.
    - Opting out of certain data collection or processing activities.
    - Withdrawing consent for data processing where applicable.

    ### 7. Changes to This Privacy Policy

    We may update this Privacy Policy from time to time. When we make changes, we will notify you by updating the effective date at the top of this policy and, where appropriate, through other communication channels.

    ### 8. Contact Us

    If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:
    [help@themixtapeapp.com](mailto:help@themixtapeapp.com)
    """
    
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Markdown(str)
                    .padding()
                    .toolbar {
                        ToolbarItem(placement:.confirmationAction) {
                            Button(action:{dismiss()}) {
                                Text("Done")
                            }
                        }
                    }
            }
        }
    }
}

/*
 Privacy Policy

 Effective Date: 8/19/2024

 1. Introduction

 Welcome to Mixtape. We value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application Mixtape (the “App”), including when you interact with our App’s features such as authentication, image uploads, and music service integrations.

 2. Information We Collect

 Personal Information: When you use our App, we collect personal information that you provide directly, including but not limited to:

 Auth0 Authentication: Your email address and any other information you provide during authentication.
 Image Uploads: Any images you upload through the App.
 Music Service Integration: Information from your Spotify, Apple Music, Deezer, or Tidal accounts if you choose to connect them.

 3. How We Use Your Information

 We use your information to:

 Provide, operate, and maintain the App.
 Authenticate your account and manage user sessions.
 Process and manage your image uploads.
 Integrate with music services to enhance your user experience.

 4. How We Share Your Information

 We do not sell your personal information. However, we may share your information with:

 Service Providers: We may engage third-party service providers (like Auth0) to assist with authentication, data storage, and other functions.
 Music Service Providers: If you connect your music accounts, your information may be shared with Spotify, Apple Music, Deezer, or Tidal in accordance with their respective privacy policies.
 Legal Requirements: We may disclose your information if required by law or in response to valid requests by public authorities.
 
 5. Data Security

 We implement reasonable technical and organizational measures to protect your personal information from unauthorized access, use, or disclosure. However, no security measures are entirely foolproof, and we cannot guarantee absolute security.

 6. Your Rights

 Depending on your jurisdiction, you may have certain rights regarding your personal information, such as:

 Accessing, updating, or deleting your personal information.
 Opting out of certain data collection or processing activities.
 Withdrawing consent for data processing where applicable.
 
 7. Changes to This Privacy Policy

 We may update this Privacy Policy from time to time. When we make changes, we will notify you by updating the effective date at the top of this policy and, where appropriate, through other communication channels.

 8. Contact Us

 If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:
 help@themixtapeapp.com
 
 */

//#Preview {
//    PrivacyPolicyView()
//}
