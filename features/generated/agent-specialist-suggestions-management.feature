Feature: Agent Specialist Suggestions management

Background: User navigates to Suggestions sub-tab
  Given I am logged in to the dashboard
  When I click on the "Agents" menu item in the left sidebar
  And I click on "View Details" for an agent
  And I click on the "Suggestions" sub-tab in the agent navigation
  Then I should be on the Suggestions page

Scenario: User views Suggestions page elements
  Then I should see the "Suggestions" title
  And I should see the subtitle "Manage agent suggestions and prompts."
  And I should see two tabs: "Auto Generated" and "Frequent"
  And I should see a "Regenerate" button with refresh icon
  And I should see "Auto Generated" tab should be selected by default
  And I should see a search bar with placeholder "Search auto generated suggestions..."
  And I should see a table with columns: "Content", "Created Date", "Updated Date", "Actions"

Scenario: User views Frequent tab
  When I click on the "Frequent" tab
  Then I should see the "Frequent" tab is selected
  And I should see a search bar with placeholder "Search frequent suggestions..."
  And the "Auto Generated" tab should be deselected

Scenario: User views empty state in Frequent tab
  When I click on the "Frequent" tab
  And there are no frequent suggestions
  Then I should see the empty state message "This table is empty. No items found"

Scenario: User views suggestion content format
  And I am on the "Auto Generated" tab
  And there are suggestions displayed
  When I view a suggestion row
  Then I should see the suggestion content text in the "Content" column
  And the content should be readable and properly formatted

Scenario: User views suggestion date format
  And I am on the "Auto Generated" tab
  And there are suggestions displayed
  When I view a suggestion row
  Then I should see the "Created Date" in format "MM/DD/YYYY HH:MM AM/PM"
  And I should see the "Updated Date" in format "MM/DD/YYYY HH:MM AM/PM"

Scenario: E2E - User searches auto generated suggestions then clears data
  And I am on the "Auto Generated" tab
  And there are multiple suggestions displayed
  When I enter a search term in the "Search auto generated suggestions..." search bar
  Then I should see only suggestions matching the search term
  And suggestions not matching the search term should be hidden
  When I clear the search bar
  Then all suggestions should be displayed again

Scenario: E2E - Verify suggestion table structure and data
  And I am on the "Auto Generated" tab
  When I view the suggestions table
  Then I should see the table header with columns: "Content", "Created Date", "Updated Date", "Actions"
  And each row should contain suggestion data
  And the table should be scrollable if there are many suggestions
  And the content should be readable and properly formatted

Scenario: E2E - Navigate between Auto Generated and Frequent tabs
  And I am on the "Auto Generated" tab
  When I click on the "Frequent" tab
  Then I should see the "Frequent" tab is selected
  And the "Auto Generated" tab should be deselected
  When I click back on the "Auto Generated" tab
  Then I should see the "Auto Generated" tab is selected again
  And the "Frequent" tab should be deselected

Scenario: E2E - Verify breadcrumb navigation from Suggestions
  And I am on the Suggestions page for agent "New Package test"
  When I view the breadcrumb navigation
  Then I should see "Pages / Agents" in the breadcrumb
  When I click on "Agents" in the breadcrumb
  Then I should be redirected to the Agents page

Scenario: E2E - Handle empty auto generated suggestions state
  And I am on the "Auto Generated" tab
  And there are no suggestions available
  Then I should see an empty state message
  And the "Regenerate" button should still be visible and clickable
  When I click on the "Regenerate" button
  Then suggestions should be generated
  And the empty state should be replaced with the suggestions table
