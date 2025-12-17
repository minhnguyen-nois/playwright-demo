Feature: Agent Specialist Workflow details management

Background: User is viewing an Agent's detail page
  Given I am viewing the Agents list
  When I click the "View Details" button on an Agent card (e.g., "Tr? l� ti�u chu?n Logistics demo")
  Then I should be redirected to the Agent detail page
  And I should see the Agent's profile card on the left sidebar (e.g., Name, Type, Status)
  And the default view should be the "Agent Info" tab
  And I should see the navigation tabs: "Agent Info", "Knowledge", "Workflows", "Evaluate", "ACL", "Settings", "Integrations", and "Suggestions"

Scenario: User views Workflow tab (Empty State)
  And I click on the "Workflow" tab
  And no workflows have been added
  Then I should see a search bar with placeholder "Search files/folders..."
  And I should see the "Update from Library" button and the "Save" button
  And the "Save" button should be disabled
  And I should see the empty state message

Scenario: User views Workflows list when items exist
  When I click on the "Workflow" tab
  And at least one workflow has been added
  Then I should see a table with columns: "Name" and "Created At"
  And the row should show the workflow "Name" (e.g., "[New Package test] Logisti...")
  And the row should show the "Created At" date
  And the row should have an action control (e.g., a delete icon)

Scenario: User opens Update from Library modal for Workflows
  And I click on the "Workflow" tab
  And I click on the "Update from Library" button
  Then I should see the "Select New Workflows" modal
  And the modal should display the Library structure containing Workflows
  And I should see a checkbox next to each workflow/folder
  And I should see "Cancel" and "Confirm" buttons

Scenario: User selects new Workflows in the Library modal
  And I click on the "Workflow" tab
  And I click on the "Update from Library" button
  And the "Select New Workflows" modal is open
  When I click the checkbox next to an unselected Workflow (e.g., "WF1.1")
  Then the Workflow should be marked as selected
  And the selection count should update accordingly

Scenario: User confirms selection and enables Save button
  And I click on the "Workflow" tab
  And I click on the "Update from Library" button
  And the "Select New Workflows" modal is open
  And I have selected at least one new workflow
  When I click the "Confirm" button
  Then the "Select New Workflows" modal should be closed
  And the "Workflows" list should be updated to reflect the selection
  And the "Save" button should become enabled

Scenario: User cancels selection in Library modal
  And I click on the "Workflow" tab
  And I click on the "Update from Library" button
  And the "Select New Workflows" modal is open
  When I click the "Cancel" button
  Then the modal should be closed
  And the "Workflows" list should remain unchanged
  And the "Save" button should remain disabled (if it was initially disabled)

Scenario: User revokes an existing Workflow (using delete icon)
  And I click on the "Workflow" tab
  And I click on the "Update from Library" button
  And a Workflow exists in the list
  When I click the delete icon on the existing Workflow row
  Then the Workflow should be removed from the list
  And the "Save" button should become enabled

Scenario: E2E - Successfully adding and saving a new Workflow via Update from Library
  And I click on the "Workflow" tab
  When I click on the "Update from Library" button
  Then I should see the "Select New Workflows" modal
  # STEP 3: Select Workflow
  When I click any one the checkbox next to a Workflow row in the Library
  And I click the "Confirm" button in the modal
  Then the "Select New Workflows" modal should be closed
  And the "Save" button should become enabled
  When I click the "Save" button
  Then I should see the confirmation popup (e.g., "Update Knowledge Base")
  When I click the "Confirm" button in the popup
  Then the confirmation popup should close
  And I should see that workdlow successfully added to the Workflows list
  And the "Save" button should return to a disabled state
