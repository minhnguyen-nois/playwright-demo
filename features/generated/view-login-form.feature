Feature: View login form

Scenario: User views login form
  Given I navigate to "https://dev.agentiqai.ai/auth/sign-in"
  Then I should see the page title "Sign In" and it should be visable and enable
  And I should see the text "Enter your email and password to sign in!" under the page title
  And I should see the field "Email" and "Password"
  And I should see the "Sign In" button is visable and enable
