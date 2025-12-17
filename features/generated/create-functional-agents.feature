Feature: Create Functional Agents

Background:
  Given I am signed in and on the Agents page
  Then I should see the "Create" button with a dropdown

Scenario: Launch Functional flow from dropdown
  When I click the "Create" button and select "Functional"
  Then I should land on the Functional Create Agent wizard
  And I should see steps "Agent Details", "Trigger", "Pipeline", "Finish"

Scenario: Functional - Agent Details UI
  Given I am on the Functional Create Agent wizard at step "Agent Details"
  Then I should see fields "Agent Name", "Description", "Type", and an Icon upload control
  And the "Next" button should be disabled until required fields are filled

Scenario: Functional - Validation on Agent Details
  Given I am on the Functional Create Agent wizard at step "Agent Details"
  When I leave "Agent Name" empty and click "Next"
  Then I should see a validation error "Agent Name is required"
  And I should remain on "Agent Details"

Scenario: User fills Agent Details and selects Functional type
  When I enter "Selenium pipeline" in "Agent Name"
  And I enter "flows CI/CD" in "Description"
  And I select "Autonomous" from the "Type" dropdown
  And I click on "Next"
  Then I should advance to step "Trigger"

Scenario: User sees Trigger step and options
  Given I am on the Trigger step
  Then I should see a dropdown labeled "Trigger Type"
  And I should see options "Schedule" and "API Trigger"
  And I should see "Prev" and "Next" buttons

Scenario: User selects API Trigger
  Given I am on the Trigger step
  When I select "API Trigger"
  Then the selection should be saved
  And the "Next" button should be enabled

Scenario: Trigger selection and back navigation
  And I am creating a "Functional" agent named "Temp Functional"
  And I selected "API Trigger" on the Trigger step
  When I click "Prev"
  Then I should return to "Agent Details" with my entered Agent Name, Description, and Type preserved

Scenario: User sees Pipeline step empty state
  Given I am on the Pipeline step
  Then I should see an "Add Step" control
  And I should see "Prev" and "Submit" buttons
  And no steps should be listed initially

Scenario: User adds a pipeline step
  Given I am on the Pipeline step
  When I click on "Add Step"
  Then a new step row should appear with fields: Input, Agent selector, and Output
  And I should see a delete icon for the step

Scenario: User configures pipeline step
  Given a pipeline step is visible
  When I enter "Analyze" in the Input field
  And I select agent "Selenium Test" from the Agent dropdown
  And I enter an output description
  Then the step should be considered filled

Scenario: User removes a pipeline step
  Given a pipeline step is visible
  When I click the delete icon on the step
  Then the step should be removed
  And the "Submit" button should be disabled if no steps remain

Scenario: User submits Functional wizard
  Given I have at least one pipeline step filled
  When I click on "Submit"
  Then I should see a success toast "Agent created successfully"
  And I should see the deployment screen for "Selenium pipeline" with progress bar
  And I should see a "Back to List" button

Scenario: User completes deployment (Functional)
  Given the deployment is in progress
  When the progress completes
  Then the deployment screen should indicate completion or readiness

Scenario: User verifies created Functional agent appears on Agents dashboard
  Given I have completed creating an agent named "Selenium pipeline"
  When I return to the Agents page
  Then I should see an agent card with name "Selenium pipeline"
  And the card should show type "Autonomous" (Functional) and current status (e.g., Idle/Ready)

Scenario: E2E - Create Functional agent and verify on dashboard
  When I click on the "Create" dropdown on the Agents page
  And I select "Functional"
  Then I should see the Create Agent wizard with steps "Agent Details", "Trigger", "Pipeline", "Finish"
  When I enter "Selenium pipeline" in "Agent Name"
  And I enter "flows CI/CD" in "Description"
  And I select "Autonomous" in the "Type" dropdown
  And I click "Next"
  Then I should be on the "Trigger" step
  When I select trigger type "API Trigger"
  And I click "Next"
  Then I should be on the "Pipeline" step
  When I click "Add Step"
  And I enter "Analyze" as input
  And I select agent "Selenium Test" in the step Agent dropdown
  And I enter output text
  And I click "Submit"
  Then I should see toast "Agent created successfully"
  And I should see the deployment screen for "Selenium pipeline" with progress bar
  And I should see a "Back to List" button
  When I click "Back to List"
  Then I should be returned to the Agents page
  And I should see an agent card named "Selenium pipeline" with type "Autonomous" and current status (e.g., Idle/Ready)

Scenario: E2E - Pipeline empty state, add step, delete step, re-add step
  When I start creating a "Functional" agent
  And I navigate to the "Pipeline" step
  Then I should see an "Add Step" control
  And I should see "Prev" and "Submit" buttons
  When I click "Add Step"
  Then I should see a new pipeline step with fields Input, Agent selector, and Output
  When I fill the step with input text, select agent "Selenium Test", and enter output
  Then the "Submit" button should be enabled
  When I click the delete icon on the pipeline step
  Then the step should be removed
  And the "Submit" button should be disabled
  When I click "Add Step" again
  Then a new pipeline step should appear with fields Input, Agent selector, and Output
  When I fill the new step with input text, select agent "Selenium Test", and enter output
  Then the "Submit" button should be enabled
