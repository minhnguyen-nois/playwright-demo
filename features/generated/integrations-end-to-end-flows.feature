Feature: Integrations - End-to-End Flows

Scenario: E2E - Create integration and view details
  Given I am logged in to the dashboard
  When I click on the "Integrations" menu item in the left sidebar
  And I click on the "+ New Integration" button
  And I enter "Brain Tool" in the "Name" field
  And I enter "Tool integration" in the "Description" text area
  And I select "TOOL" from the "Type" dropdown
  And I click on the "Create" button
  Then the integration should be created successfully
  When I click on "View Details" on the "Brain Tool" card
  Then I should see the "Edit Integration" panel
  And I should see the fields populated with the created data

Scenario: E2E - Edit integration and save changes
  Given I am logged in to the dashboard
  And there is an integration named "Test"
  When I click on the "Test" integration card "View Details"
  Then I should see the "Edit Integration" panel
  When I update the "Description" to "Updated description"
  And I update the "url" to "https://google.com"
  And I update the "username" to "user@example.com"
  And I update the "password" field
  And I click on "Add headers"
  And I enter "Authorization" in the header Key field
  And I enter "Bearer 123" in the header Value field
  And I toggle "Secret" off for this header
  And I click on the "Save Changes" button
  Then the integration should be updated successfully
  And the panel should close or show a success message

Scenario: E2E - Test connectivity from Edit Integration
  Given I am logged in to the dashboard
  And there is an integration named "Test"
  When I click on "View Details" for "Test"
  Then I should see the "Edit Integration" panel
  When I click on the "Test Connectivity" button
  Then a connectivity test should run
  And I should see success or failure feedback

Scenario: E2E - Cancel editing integration
  Given I am logged in to the dashboard
  And there is an integration named "Test"
  When I click on "View Details" for "Test"
  Then I should see the "Edit Integration" panel
  When I change the "Description" field
  And I click on the "Cancel" button
  Then the panel should close
  And the original integration data should remain unchanged

Scenario: E2E - Delete integration from card with confirmation
  Given I am logged in to the dashboard
  And there is an integration named "Test"
  When I click the delete icon on the "Test" card
  Then I should see a confirmation dialog titled "Delete Integration"
  And I should see the message 'Are you sure you want to delete "Test"? This action cannot be undone.'
  When I click on the "Delete" button
  Then the integration should be deleted successfully
  And the dialog should close
  And the "Test" card should no longer appear

Scenario: E2E - Cancel deletion from confirmation dialog
  Given I am logged in to the dashboard
  And there is an integration named "Test"
  When I click the delete icon on the "Test" card
  Then I should see the delete confirmation dialog
  When I click on the "Cancel" button
  Then the dialog should close
  And the integration should remain

Scenario: E2E - Search integrations and verify results
  Given I am logged in to the dashboard
  And there are multiple integrations including "Brain Tool" and "Another Integration"
  When I enter "Brain" in the search bar
  Then I should see "Brain Tool" in the results
  And I should not see "Another Integration"

Scenario: E2E - New integration appears in Agent settings
  Given I am on the Integrations page
  When I click "New Integration"
  And I enter "Web Search Tool 3" in "Name"
  And I enter "Search tool" in "Description"
  And I select "TOOL" from "Type"
  And I click "Create"
  Then the integration should be created successfully
  And I navigate to Agents and open agent "New Package test"
  And I click the "Integrations" tab (or Settings section if it lists integrations)
  Then I should see "Web Search Tool 3" listed with type "TOOL"

Scenario: E2E - Create, edit, test connectivity, and delete integration
  Given I am logged in to the dashboard
  When I create an integration named "Lifecycle Integration" with type "TOOL"
  Then "Lifecycle Integration" should appear on the Integrations page
  When I click "View Details" for "Lifecycle Integration"
  And I update the "Description" to "Lifecycle updated"
  And I click on "Test Connectivity"
  Then I should see connectivity feedback
  When I click "Save Changes"
  Then the changes should be saved successfully
  When I click the delete icon on the "Lifecycle Integration" card
  And I confirm deletion
  Then the integration should be deleted
  And it should no longer appear on the Integrations page
