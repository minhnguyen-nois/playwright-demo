Feature: User authentication

Background:
  Given I open the login page by URL "https://dev.agentiqai.ai/auth/sign-in"

Scenario: User signs in successfully with valid credentials
  When I sign in by entering at "Email" field with "minhnguyen@agentiqai.ai" and enter at "Password" field with "minhnguyen"
  Then I should be redirected to the AgentIQ dashboard page and I should see a welcome message

Scenario: User signs in successfully with invalid credentials
  When I sign in via LoginPage with email "<email>" and password "<password>"
  Then LoginPage shows an inline error "Invalid email or password"
  And I remain on LoginPage
  Examples:
  | email                     | password      |
  | minhnguyen@agentiqai.ai   | wrongpass     |
  | wronguser@agentiqai.ai    | minhnguyen    |
  | invalid-email             | minhnguyen    |

Scenario: Email and password are required
  When I submit the login form by clicking "Sign In" button without entering any credentials
  Then LoginPage shows required message "Please enter both email and password"

Scenario: Throttling after repeated failures
  Given I attempt to sign in via LoginPage with invalid credentials 5 times
  Then LoginPage shows a rate-limit message
  And further attempts are blocked for a short period

Scenario: Show/hide password toggle
  When I toggle the password visibility on LoginPage
  Then the password field value is visible in plain text
  And toggling again hides the password value
