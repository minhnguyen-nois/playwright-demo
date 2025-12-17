Feature: Log out

Scenario: User logs out successfully
  Given I am signed in via LoginPage with valid credentials
  When I log out from DashboardPage
  Then I am redirected to LoginPage
  And LoginPage shows the sign-in form
