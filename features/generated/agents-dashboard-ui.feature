Feature: Agents dashboard UI

Background:
  Given I navigate to the URL "https://dev.agentiqai.ai/auth/sign-in"
  When I enter "Email" field with "minhnguyen@agentiqai.ai" and "Password" field with "minhnguyen"
  And I click on the "Sign In" button
  Then I should be redirected dashboard page and see a welcome message

Scenario: Core dashboard shell renders
  Then I should see the top navigation bar with logo and avatar icon
  And I should see the left sidebar with main menu items
  And I should see the main dashboard content area visible

Scenario: Sidebar menu items present and ordered
  Then the sidebar should list items "Home", "Projects", "Notifications", "Profile", "Settings", "Help", "Sign Out"
  And "Home" should be highlighted as active
  And each menu item should display its corresponding icon

Scenario: Top bar quick actions present
  Then I should see a search input in the top bar
  And I should see a notifications bell icon with a badge (or zero count)
  And I should see the avatar icon on the top right corner

Scenario: Dashboard widgets/cards load
  Then I should see the "Overview" card
  And I should see the "Recent activity" card
  And I should see the "Shortcuts" card
  And each card should have a title and body content visible

Scenario: Empty state for notifications (if none)
  Given there are no unread notifications
  When I click the notifications bell icon
  Then I should see a dropdown with text "No notifications yet"

Scenario: Notifications list (if exists)
  Given there are unread notifications
  When I click the notifications bell icon
  Then I should see a list of notifications with timestamp and description
  And unread notifications should be visually highlighted

Scenario: Change language preference
  When I select "English" from the "Language" dropdown
  Then I should see english text
  And the "Language" selection should remain "English" after refresh

Scenario: Search bar interaction
  When I focus the search input in the top bar
  Then a placeholder text "Search agents..." should be visible
  When I type "project agents" into the search input
  Then I should see agent cards filtered by the search term if agent is available
  And I should see "No results" message if there are no available agents

Scenario: Responsive layout check (desktop)
  Given the viewport width is at least 1280px
  Then the sidebar should be expanded by default
  And the dashboard content should be centered with proper padding

Scenario: Responsive layout check (tablet)
  Given the viewport width is 768px
  Then the sidebar should be collapsible or hidden behind a menu button
  And the top bar should show the hamburger/menu icon

Scenario: Theme toggle visibility
  When I click on the settings icon
  And I select Dark mode
  Then the website should be switched to dark theme
  When I click on the Close button
  Then the configurator modal should be closed
