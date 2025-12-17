Feature: Integrations management

Background: User is logged in and navigates to Integrations page
  Given I am logged in to the dashboard
  When I click on the "Integrations" menu item in the left sidebar
  Then I should be redirected to the Integrations page
  And I should see the breadcrumbs "Pages / Integrations"
  And I should see the page title "Integrations"
  And I should see the "Integrations" menu item highlighted in the sidebar

Scenario: User views Integrations page elements
  Then I should see a search bar with placeholder "Search integrations..."
  And I should see the "New Integration" button in the action bar
  And I should see the empty state message "No integrations available." when none exist

Scenario: User views empty state when no integrations exist
  And no integrations have been created
  Then I should see the empty state message "No integrations available."
  And I should see the "+ New Integration" button

Scenario: User opens Create New Integration panel
  When I click on the "+ New Integration" button
  Then I should see a side panel titled "Create New Integration"
  And I should see the subtitle "Fill in the details below to create a new Integration."
  And I should see a close "X" button in the top right corner of the panel

Scenario: User views Create New Integration form elements
  And the "Create New Integration" panel is open
  Then I should see a "Name" input field with placeholder "Integration Name"
  And I should see a "Description" text area with placeholder "Integration Description"
  And I should see a "Type" dropdown with placeholder "Select Type"
  And I should see the text "No configuration" when no type is selected
  And I should see buttons "Cancel", "Test Connectivity", and "Create"

Scenario: User validation when required fields are missing on Create
  And the "Create New Integration" panel is open
  And the "Name" field is empty
  And the "Type" field is empty
  When I click on the "Create" button
  Then I should see validation error "Name is required."
  And I should see validation error "Type is required."
  And the integration should not be created

Scenario: User validation when required fields are missing on Test Connectivity
  And the "Create New Integration" panel is open
  And the "Name" field is empty
  And the "Type" field is empty
  When I click on the "Test Connectivity" button
  Then I should see validation error "Name is required." if applicable
  And I should see validation error "Type is required."
  And the connectivity check should not run

Scenario: User cancels creating an integration
  And the "Create New Integration" panel is open
  When I click on the "Cancel" button
  Then the panel should be closed
  And no integration should be created

Scenario: User closes Create New Integration panel with X button
  And the "Create New Integration" panel is open
  When I click on the "X" close button
  Then the panel should be closed
  And no integration should be created

Scenario: User creates a new integration successfully
  And the "Create New Integration" panel is open
  When I enter "Brain Tool" in the "Name" field
  And I enter "Tool integration" in the "Description" text area
  And I select "TOOL" from the "Type" dropdown
  And I click on the "Create" button
  Then the integration should be created successfully
  And the panel should be closed
  And I should see the new integration card named "Brain Tool" in the Integrations page
  And the empty state should disappear

Scenario: User searches for integrations
  And there are existing integrations
  When I enter "Test" in the search bar
  Then I should see integration cards matching "Test"
  And I should not see cards that do not match the search text

Scenario: User views integration card details on list
  And there is an existing integration card named "Test"
  Then I should see the integration name on the card
  And I should see a badge for the type (e.g., "TOOL")
  And I should see "Last Updated" text on the card
  And I should see "View Details" link
  And I should see a red "Delete" icon on the card

Scenario: User sees installed packages listed as integrations
  And packages have been installed from the Marketplace
  When I view the Integrations page
  Then I should see cards for each installed package
  And each card should show the package name, type badge (e.g., TOOL), and "Last Updated" date
  And each card should include "View Details" and "Delete" actions

Scenario: User opens View Details for an integration
  And there is an existing integration card
  When I click on "View Details" on the card
  Then I should see an "Edit Integration" side panel
  And I should see fields: Name, Description, Type (disabled or selectable), url, username, password, headers
  And I should see buttons "Cancel", "Test Connectivity", and "Save Changes"

Scenario: User edits integration details and saves
  And I am viewing the "Edit Integration" panel for an existing integration
  When I update the "Description" field
  And I update the "url" field
  And I update the "username" field
  And I update the "password" field
  And I add a header with key "Authorization" and value "Bearer 123"
  And I toggle "Secret" off for the header
  And I click on the "Save Changes" button
  Then the changes should be saved successfully
  And the panel should close or show a success message
  And the integration card should reflect the updated data where applicable

Scenario: User tests connectivity from Edit Integration
  And I am viewing the "Edit Integration" panel for an existing integration
  When I click on the "Test Connectivity" button
  Then a connectivity test should run
  And I should see success or failure feedback

Scenario: User manages headers in Edit Integration
  And I am viewing the "Edit Integration" panel for an existing integration
  When I click on "Add headers"
  Then I should see a new header row with fields for Key and Value
  And I should see a "Secret" checkbox to mask the value if enabled
  When I enter "api-key" in the Key field
  And I enter "secret-value" in the Value field
  And I toggle "Secret" on
  Then the value should be masked or stored securely
  When I toggle "Secret" off
  Then the value should be visible in the field
  When I click the delete icon for the header row
  Then the header row should be removed

Scenario: User cancels editing an integration
  And I am viewing the "Edit Integration" panel
  When I click on the "Cancel" button
  Then the panel should be closed
  And no changes should be saved

Scenario: User deletes an integration from card
  And there is an existing integration card named "Test"
  When I click the delete icon on the card
  Then I should see a confirmation dialog titled "Delete Integration"
  And I should see the message 'Are you sure you want to delete "Test"? This action cannot be undone.'
  And I should see "Cancel" and red "Delete" buttons and a close "X" icon
  When I click on the "Delete" button
  Then the integration should be deleted successfully
  And the confirmation dialog should close
  And the integration card should no longer appear

Scenario: User cancels deleting an integration
  And there is an existing integration card
  When I click the delete icon on the card
  Then I should see the delete confirmation dialog
  When I click on the "Cancel" button
  Then the dialog should close
  And the integration should remain

Scenario: User closes delete confirmation with X
    And there is an existing integration card
  And there is an existing integration card
  When I click the delete icon on the card
  Then I should see the delete confirmation dialog
  When I click on the "X" close button in the dialog
  Then the dialog should close
  And the integration should remain
