Feature: Create Orchestrator Agents

Background:
  Given I am signed in and on the Agents page
  Then I should see the "Create" button with a dropdown

Scenario: Launch Orchestrator flow from dropdown
  When I click the "Create" button and select "Orchestrator"
  Then I should land on the Orchestrator Create Agent wizard
  And I should see steps "Agent Details", "Choose Workflow", "Assign Specialists", "Finish"

Scenario: Orchestrator - Agent Details UI
  Given I am on the Orchestrator Create Agent wizard at step "Agent Details"
  Then I should see fields "Agent Name", "Description", and an Icon upload control
  And the "Next" button should be disabled until required fields are filled

Scenario: Specialist - Validation on Agent Details
  Given I am on the Specialist Create Agent wizard at step "Agent Details"
  When I leave "Agent Name" empty and click "Next"
  Then I should see a validation error "Agent Name is required"
  And I should remain on "Agent Details"

Scenario: User fills Agent Details and proceeds (Orchestrator)
  When I enter "Autonomous flows" in "Agent Name"
  And I enter "kickoff stage" in "Description"
  And I click on "Next"
  Then I should advance to step "Choose Workflow"

Scenario: User sees empty state on Choose Workflow step
  Given I am on the Choose Workflow step
  Then I should see the title "Select from Workflows"
  And I should see the empty state text "No workflows have been selected yet."
  And I should see "Prev" and "Next" buttons

Scenario: User selects a workflow (Orchestrator)
  Given I am on the Choose Workflow step
  When I select a workflow "WF1.2"
  Then the selection should be highlighted
  And the "Next" button should be enabled

Scenario: Navigate back within Orchestrator wizard
  And I am creating an "Orchestrator" agent named "Temp Orchestrator"
  And I am on the "Choose Workflow" step after selecting a workflow
  When I click "Prev"
  Then I should return to "Agent Details" with my entered Agent Name and Description preserved

Scenario: User sees Assign Specialists step
  Given I am on the Assign Specialists step
  Then I should see a dropdown labeled "Select specialists"
  And I should see available Specialist agents listed with checkboxes
  And I should see "Prev" and "Submit" buttons

Scenario: User selects specialists
  Given I am on the Assign Specialists step
  When I select the specialist "Selenium Test"
  Then the specialist should appear as selected
  And the "Submit" button should be enabled

Scenario: User submits Orchestrator wizard
  Given I have selected at least one specialist
  When I click on "Submit"
  Then I should see a success toast "Agent created successfully"
  And I should see the deployment screen for "Autonomous flows" with progress bar
  And I should see a button "Chat with Agent"

Scenario: User completes deployment (Orchestrator)
  Given the deployment progresses to completion
  Then I should see the message "Agent is ready!"
  And the "Chat with Agent" button should be enabled

Scenario: User opens chat from completion screen (Orchestrator)
  Scenario: User opens chat from completion screen (Orchestrator)
  Given the "Chat with Agent" button is enabled
  When I click on "Chat with Agent"
  Then I should be redirected to the Chat page for the created agent "Autonomous flows"

Scenario: User verifies created Orchestrator agent appears on Agents dashboard
  Given I have completed creating an agent named "Autonomous flows"
  When I return to the Agents page
  Then I should see an agent card with name "Autonomous flows"
  And the card should show type "Orchestrator" and status "Ready"

Scenario: E2E - Assign Specialists empty state and selection
  When I start creating an "Orchestrator" agent
  And I navigate to the "Assign Specialists" step
  Then I should see the dropdown "Select specialists"
  And I should see available specialists listed (e.g., "New Package test", "Tr? l� ti�u chu?n Logistics demo", "Selenium Test")
  When I select "Selenium Test"
  Then the selection should show "1 specialist selected"
  And the "Submit" button should be enabled

Scenario: E2E - Create Orchestrator agent and verify on dashboard
  When I click on the "Create" dropdown on the Agents page
  And I select "Orchestrator"
  Then I should see the Create Agent wizard with steps "Agent Details", "Choose Workflow", "Assign Specialists", "Finish"
  When I enter "Autonomous flows" in "Agent Name"
  And I enter "kickoff stage" in "Description"
  And I click "Next"
  Then I should be on the "Choose Workflow" step
  When I select workflow "WF1.2"
  And I click "Next"
  Then I should be on the "Assign Specialists" step
  When I select specialist "Selenium Test"
  And I click "Submit"
  Then I should see toast "Agent created successfully"
  And I should see the deployment screen for "Autonomous flows" with progress bar
  And I should see the button "Chat with Agent"
  When the deployment completes
  Then I should see "Agent is ready!"
  When I click on "Chat with Agent"
  Then I should be redirected to the Chat page for agent "Autonomous flows"
  When I return to the Agents page
  Then I should see an agent card named "Autonomous flows" with type "Orchestrator" and status "Ready"
