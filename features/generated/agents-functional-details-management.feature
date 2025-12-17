Feature: Agents Functional details management

Background: User is viewing an Agent Functional detail page
  Given I am viewing the Agents list
  When I click the "View Details" button on an Agent Funcational card (e.g., "Selenium pipeline")
  Then I should be redirected to the Agent Orchestrator detail page
  And I should see the Agent's profile card on the left sidebar (e.g., Name, Type, Status)
  And the default view should be the "Agent Info" tab
  And I should see the navigation tabs: "Agent Info", "Workflows", "Evaluate", "ACL", "Settings", "Assign Specialist", and "Suggestions"

Scenario: Viewing Agent Info (Autonomous)
  Given I am viewing the details for the "Selenium pipeline" Agent (Type: Autonomous)
  And the "Agent Info" tab is selected
  Then I should see the Agent Name field pre-populated with "Selenium pipeline"
  And I should see the Description field pre-populated with "flows CICD"
  And I should see the "Save Changes" button

Scenario: Editing Agent Info (Autonomous)
  Given I am viewing the details for the "Selenium pipeline" Agent (Type: Autonomous)
  And the "Agent Info" tab is selected
  When I modify the Description field (e.g., change to "updated flows CICD")
  Then the "Save Changes" button should become enabled
  When I click the "Save Changes" button
  Then the Agent Information should be updated successfully

Scenario: Navigate to Trigger tab from default tab
  Given I am on the "Agent Info" tab
  When I click on the "Trigger" tab
  Then the "Trigger" tab should be selected
  And I should see the "Execution Mode" setting
  And the URL should reflect the "Trigger" section

Scenario: Viewing Trigger tab
  Given I am viewing the details for the "Selenium pipeline" Agent
  When I click on the "Trigger" tab
  Then I should see the "Execution Mode" setting
  And I should see the "Trigger Type" dropdown
  And the "Trigger Type" should show the option "API Trigger"
  And I should see a read-only API Endpoint URL displayed
  And I should see the "Save Configuration" button

Scenario: Configuring Agent Trigger (Schedule)
  Given I am viewing the "Trigger" tab
  When I select "Schedule" from the "Trigger Type" dropdown
  Then I should see the "Auto Trigger" section
  And I should see options to set the schedule (e.g., "every day at every hour")
  And I should see the "Next Run Date" displayed
  When I modify the schedule settings
  Then the "Save Configuration" button should become enabled
  When I click the "Save Configuration" button
  Then the new trigger configuration should be saved successfully

Scenario: Navigate to Pipeline tab from default tab
  Given I am on the "Agent Info" tab
  When I click on the "Pipeline" tab
  Then the "Pipeline" tab should be selected
  And I should see the pipeline configuration interface
  And the URL should reflect the "Pipeline" section

Scenario: Viewing Existing Pipeline Stages
  Given I am on the "Agent Info" tab
  When I click on the "Pipeline" tab
  Then I should see a sequence of pipeline stages
  And the first stage should be named "Analyze"
  And the second stage should be named "Selenium Test"
  And each stage should have a dropdown to select the next action or condition (e.g., "Can run")
  And the "Save Pipeline" button should be visible

Scenario: Successfully Adding a New Pipeline Stage
  Given I am on the "Agent Info" tab
  When I click on the "Pipeline" tab
  Then I click the "Add Step" button
  Then a new, empty pipeline step should be added to the sequence
  When I configure the new step (e.g., selecting "Another Specialist Agent")
  And I configure the condition for the new step
  Then the "Save Pipeline" button should become enabled

Scenario: Successfully Deleting a Pipeline Stage
  Given I am on the "Agent Info" tab
  When I click on the "Pipeline" tab
  And the pipeline has multiple stages (e.g., "Analyze" and "Selenium Test")
  When I click the delete icon (trashcan) next to the "Selenium Test" stage
  Then the "Selenium Test" stage should be removed from the pipeline sequence

Scenario: Saving the Modified Pipeline Configuration
  Given I am on the "Agent Info" tab
  When I click on the "Pipeline" tab
  And I have added or deleted a pipeline stage (the "Save Pipeline" button is enabled)
  When I click the "Save Pipeline" button
  Then the pipeline configuration should be saved successfully
  And I should see a success notification (e.g., "Pipeline saved successfully")
  And the "Save Pipeline" button should become disabled

Scenario: E2E - Full lifecycle of Pipeline management (Edit, Save, Run)
  And I am viewing the "Pipeline" tab for the "Selenium pipeline" Agent
  When I click "Add Step"
  And I configure the new step as "Documentation Agent" with condition "Can run"
  Then the "Save Pipeline" button should be enabled
  When I click the "Save Pipeline" button
  Then the pipeline should be saved successfully (and I see a success notification)
  When I navigate to the Agent's main view
  And I click the "Run manual" button
  Then the Agent run should be initiated successfully
  When I click on the "Logs" tab
  And I wait for the run to complete
  Then I should see the latest log entry
  And the detailed log output should confirm the execution of all steps, including the newly added "Documentation Agent" step

Scenario: Navigate to Logs tab from default tab
  Given I am on the "Agent Info" tab
  When I click on the "Logs" tab
  Then the "Logs" tab should be selected
  And I should see the list of recent "Run at" timestamps
  And the URL should reflect the "Logs" section

Scenario: Viewing Agent Execution Logs
  Given I am viewing the details for the "Selenium pipeline" Agent
  When I click on the "Logs" tab
  Then I should see the "Review recent executions and monitor activity" heading
  And I should see a list of recent "Run at" timestamps on the left
  And I should see the detailed output for a selected run on the right (e.g., Run at 2025-12-15 08:32:45 UTC)
  And the detailed output should include:
  * Step details (e.g., "Step 1/1: Selenium Test Output")
  * Analysis Performed
  * Summary with objectives
  * Status (e.g., "Can run - Selenium Test step has successfully completed the pipeline as required.")
  And I should see the Agent's chat interface at the bottom for further interaction

Scenario: Manual Run Action is Logged Successfully
  When I navigate to the "Agent Info" tab
  And I click the "Run manual" button
  Then the Agent run should be initiated successfully
  # Verification in Logs
  When I click back on the "Logs" tab
  # The new log entry might appear immediately or after a short delay
  Then I should see a new log entry appear in the list with a "Run at" timestamp close to T0
  And the new log entry should be displayed at the top of the list (assuming reverse chronological order)
  And the detailed output on the right should correspond to the execution of the pipeline, showing the "Analysis Performed" and "Status"
  And the detailed output should confirm the Agent running is "Selenium pipeline"

Scenario: Repeated Manual Runs Generate Multiple Log Entries
  Given the "Logs" tab contains existing log entries
  When I execute the "Run manual" action two times sequentially
  Then I should see two new log entries added to the "Run at" list
  And the timestamps of the two new entries should be sequential and recent

Scenario: Navigate to Settings tab from default tab
  Given I am on the "Agent Info" tab
  When I click on the "Settings" tab
  Then the "Settings" tab should be selected
  And I should see the "Export Agent" section
  And the URL should reflect the "Settings" section

Scenario: Viewing and Exporting Agent Settings
  Given I am viewing the details for the "Selenium pipeline" Agent
  When I click on the "Settings" tab
  Then I should see the "Agent Settings" heading
  And I should see the "Export Agent" section
  And the description should state: "Export this agent as a ZIP file containing all its configuration and knowledge base."
  And I should see the "Export Agent" button
  When I click the "Export Agent" button
  Then the system should initiate the download of the Agent's configuration and knowledge base in a ZIP file

Scenario: E2E - Configuring Pipeline and running it manually
  Given I am on the "Agent Info" tab
  When I click on the "Pipeline" tab
  Then the "Pipeline" tab should be selected
  And the current pipeline has one step: "Analyze" handoff to "Selenium Test"
  When I click "Add Step" to add a new step
  And I configure the new step (e.g., assign it to "Another Specialist" and set condition "Can run")
  And I click "Save Pipeline"
  Then the pipeline should be saved successfully
  When I navigate to the "Agent Info" tab (or any tab showing the run button)
  And I click the "Run manual" button (or similar action on the Agent card)
  Then the Agent run should be initiated successfully
  When I click on the "Logs" tab
  And I wait for the run to complete (simulated wait)
  Then I should see a new "Run at" entry in the logs list corresponding to the manual run
  And the detailed log for the new run should show the successful execution of the entire pipeline, including the newly added step

Scenario: Agent Status changes to Running after Manual Run
  And I am on the "Selenium pipeline" Agent details site
  And the status is currently "Ready"
  When I click the "Run manual" button
  Then the Agent's status should immediately change from "Ready" to "Running"
  # Post-condition (Simulated Completion)
  When the pipeline execution completes
  Then the Agent's status should change back to "Ready" (or equivalent idle state)
