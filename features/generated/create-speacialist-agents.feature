Feature: Create Speacialist Agents

Background:
  Given I am signed in and on the Agents page
  Then I should see the "Create" button with a dropdown

Scenario: Launch Specialist flow from dropdown
  When I click the "Create" button and select "Specialist"
  Then I should land on the Specialist Create Agent wizard
  And I should see steps "Agent Details", "Knowledge Base", "Choose Workflow", "Integration", "Finish"

Scenario: Specialist - Agent Details UI
  Given I am on the Specialist Create Agent wizard at step "Agent Details"
  Then I should see fields "Agent Name", "Description", and an Icon upload control
  And the "Next" button should be disabled until required fields are filled

Scenario: Specialist - Validation on Agent Details
  Given I am on the Specialist Create Agent wizard at step "Agent Details"
  When I leave "Agent Name" empty and click "Next"
  Then I should see a validation error "Agent Name is required"
  And I should remain on "Agent Details"

Scenario: User fills Agent Details and proceed
  When I enter "Selenium Test" in "Agent Name"
  And I enter "This Agent created for deploying new solutions" in "Description"
  And I click on "Next"
  Then I should advance to step "Knowledge Base"

Scenario: User sees empty state on Knowledge Base step
  Given I am on the Knowledge Base step
  Then I should see the title "Select from Library"
  And I should see the empty state text "No files have been added yet."
  And I should see "Prev" and "Next" buttons

Scenario: User selects a knowledge base file
  Given I am on the Knowledge Base step
  When I select a file named "[New Package test] ISO 28000.pdf"
  Then the file should appear in the selected list with its size
  And the "Next" button should be enabled

Scenario: Navigate back within wizard
  And I am creating a "Specialist" agent named "Temp Agent"
  And I am on the "Knowledge Base" step after selecting a file
  When I click "Prev"
  Then I should return to "Agent Details" with my entered Agent Name and Description preserved

Scenario: Wizard shows empty state when no knowledge base files
  When I start creating a "Specialist" agent
  And I navigate to the "Knowledge Base" step
  Then I should see the empty state text "No files have been added yet."
  And the "Next" button should be disabled until a file is selected

Scenario: User selects a workflow
  Given I am on the Choose Workflow step
  Then I should see the title "Select from Workflows"
  And I should see workflow options listed (e.g., "WF1.1")
  When I select a workflow "WF1.1"
  Then the selection should be highlighted
  And the "Next" button should be enabled

Scenario: User selects integrations
  Given I am on the Integration step
  Then I should see the title "Select Integrations"
  And I should see a search bar with placeholder "Search for an integration"
  And I should see integration rows with columns "Name" and "Type"
  When I check the integration "Admin"
  Then the checkbox for "Admin" should be selected
  And the "Submit" button should be enabled

Scenario: User submits the wizard
  Given I am on the Integration step
  And I have selected at least one integration
  When I click on "Submit"
  Then I should see a progress state "Deploying AI Agent: <name>" with a progress bar
  And I should see a button "Chat with Agent"

Scenario: User completes wizard and agent is ready
  Given the deployment progress completes
  Then I should see the message "Agent is ready!"
  And the "Chat with Agent" button should be enabled

Scenario: User opens chat from completion screen
  Given the "Chat with Agent" button is enabled
  When I click on "Chat with Agent"
  Then I should be redirected to the Chat page for the created agent

Scenario: User verifies created agent appears on Agents dashboard
  Given I have completed creating an agent named "Selenium Test"
  When I return to the Agents page
  Then I should see an agent card with name "Selenium Test"
  And the card should show type "Specialist" and status "Ready"

Scenario: E2E - Create Specialist agent through wizard and verify on dashboard
  When I click on the "Create" dropdown on the Agents page
  And I select "Specialist"
  Then I should see the Create Agent wizard with stepper showing steps "Agent Details", "Knowledge Base", "Choose Workflow", "Integration", "Finish"
  When I enter "Selenium Test" in "Agent Name"
  And I enter "This Agent created for deploying new solutions" in "Description"
  And I click "Next"
  Then I should be on the "Knowledge Base" step
  When I select the file "[New Package test] ISO 28000.pdf"
  And I click "Next"
  Then I should be on the "Choose Workflow" step
  When I select workflow "WF1.1"
  And I click "Next"
  Then I should be on the "Integration" step
  When I select integration "Admin"
  And I click "Submit"
  Then I should see the deployment screen for "Selenium Test" with progress bar
  And I should see the button "Chat with Agent"
  When the deployment completes
  Then I should see "Agent is ready!"
  When I click on "Chat with Agent"
  Then I should be redirected to the Chat page for agent "Selenium Test"
  When I return to the Agents page
  Then I should see an agent card named "Selenium Test" with type "Specialist" and status "Ready"
