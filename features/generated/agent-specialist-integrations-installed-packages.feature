Feature: Agent Specialist Integrations (installed packages)

Background: User is on the agent�s Integrations sub-tab
  Given I am logged in to the dashboard
  And I navigate to the Agents page
  And I open agent "New Package test" by clicking "View details"
  And I click the "Integrations" tab in the left sidebar

Scenario: Integrations tab layout
  Then I should see the title "Integrations" and subtitle "Manage agent integrations"
  And I should see a search bar with placeholder "Search for an integration"
  And I should see a table with columns: checkbox, Name, Type, Actions
  And I should see an "Export" button
  And I should see a disabled "Save Changes" button

Scenario: List installed integrations (packages)
  Given packages have been installed for this agent
  When I view the table
  Then I should see rows for each package with name and type (e.g., TOOL)
  And the Actions column should show a delete icon for each row

Scenario: Empty state when no integrations
  Given no integrations are installed for this agent
  When I view the table
  Then I should see an empty state message (or no rows) and an "Export" button disabled or hidden
  And the "Save Changes" button should remain disabled

Scenario: Search integrations
  Given there are integrations listed
  When I type "Web Search" in the search bar
  Then I should see only rows whose name matches "Web Search"
  And non-matching rows should be hidden

Scenario: Select all integrations via header checkbox
  When I click the header checkbox
  Then all row checkboxes should be checked
  And the "Save Changes" button should become enabled

Scenario: Toggle single integration selection
  When I check the row checkbox for "Admin"
  Then only that row is selected
  And the "Save Changes" button should become enabled
  When I uncheck it
  Then no rows are selected
  And the "Save Changes" button should be disabled

Scenario: Delete an integration (confirmation)
  When I click the delete icon for "test tool"
  Then I should see a confirmation dialog to delete that integration
  When I confirm delete
  Then the integration "test tool" should be removed from the table
  And a success message should appear

Scenario: Export integrations list
  When I click the "Export" button
  Then an export should start (file download or success toast)
  And selections should remain unchanged

Scenario: Save Changes enabled only with selection
  Given no rows are selected
  Then "Save Changes" is disabled
  When I select at least one row
  Then "Save Changes" becomes enabled

Scenario: Save Changes applies selection
  Given I have selected multiple integrations
  When I click "Save Changes"
  Then selections should be saved (e.g., persisted state or success toast)
  And the button should remain enabled/disabled according to the resulting selection state
