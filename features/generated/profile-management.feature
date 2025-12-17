Feature: Profile management

Background:
  Given I navigate to the URL "https://dev.agentiqai.ai/auth/sign-in"
  When I enter "Email" field with "minhnguyen@agentiqai.ai" and "Password" field with "minhnguyen"
  And I click on the "Sign In" button
  Then I should be redirected dashboard page and see a welcome message
  When I click on avatar icon on the top right corner
  Then I should land to the Profile page

Scenario: Avatar menu UI renders correctly
  When I click on the avatar icon on the top right corner
  Then I should see a dropdown containing "Profile", "Settings", "Usage Overview" and "Sign Out" options
  And the avatar menu should close when I click outside it

Scenario: View current profile details
  Then I should see my profile email pre-filled as "minhnguyen@agentiqai.ai"
  And I should see non-empty values for "Full name" and "Role"
  And I should see the current avatar displayed

Scenario: Update display name
  When I clear the "Full name" field and enter "Minh Nguyen QA"
  And I click on the "Save" button in Account settings
  Then I should see a success message "Profile updated successfully"
  And the "Full name" field should show "Minh Nguyen QA" after refresh

Scenario: Change password successfully
  When I enter "Current password" with "minhnguyen"
  And I enter "New password" with "StrongPass!123"
  And I enter "Confirm new password" with "StrongPass!123"
  And I click on the "Change Password" button
  Then I should see a success message "Password changed successfully"
  And I can sign out and sign back in with "StrongPass!123"

Scenario: Reject mismatched password confirmation
  When I enter "Current password" with "minhnguyen"
  And I enter "New password" with "StrongPass!123"
  And I enter "Confirm new password" with "WrongPass!123"
  And I click on the "Change Password" button
  Then I should see an error message "Passwords don't match"
  And the password should not be changed

Scenario: Reject weak new password
  When I enter "Current password" with "minhnguyen"
  And I enter "New password" with "123"
  And I enter "Confirm new password" with "123"
  And I click on the "Change Password" button
  Then I should see an error message "Password does not meet complexity requirements"
  And the password should not be changed

Scenario: Validate required fields on save
  When I clear the "Full name" field
  And I click on the "Save" button in Account settings
  Then I should see an error message "Full name is required"
  And no changes should be saved
