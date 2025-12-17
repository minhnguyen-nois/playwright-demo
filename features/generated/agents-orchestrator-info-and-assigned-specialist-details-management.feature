Feature: Agents Orchestrator Info and Assigned Specialist details management

Background: User is viewing an Agent Orchestrator detail page
  Given I am viewing the Agents list
  When I click the "View Details" button on an Agent Orchestrator card (e.g., "Autonomous flows")
  Then I should be redirected to the Agent Orchestrator detail page
  And I should see the Agent's profile card on the left sidebar (e.g., Name, Type, Status)
  And the default view should be the "Agent Info" tab
  And I should see the navigation tabs: "Agent Info", "Workflows", "Evaluate", "ACL", "Settings", "Assign Specialist", and "Suggestions"

Scenario: Viewing Agent Info for Orchestrator
  And the "Agent Info" tab is selected
  Then I should see the Agent's Name field pre-populated with "Autonomous flows"
  And I should see the Agent ID (read-only)
  And I should see the Description field pre-populated with "kickoff stage"
  And I should see the "Save Changes" button

Scenario: Editing Agent Info (Orchestrator)
  Given I am viewing the details for the "Autonomous flows" Agent (Type: Orchestrator)
  And the "Agent Info" tab is selected
  When I modify the Description field (e.g., change to "updated flows CICD")
  Then the "Save Changes" button should become enabled
  When I click the "Save Changes" button
  Then the Agent Information should be updated successfully

Scenario: Viewing Assigned Specialists tab
  When I click on the "Assigned Specialists" tab
  Then I should see the heading "Assigned Specialists"
  And I should see a search bar with placeholder "Search assigned specialists..."
  And I should see the "Add Specialists" button
  And I should see the list of currently assigned specialists

Scenario: Assigned Specialists List Content
  And the "Assigned Specialists" tab is selected
  Then the list should contain a specialist named "Selenium Test"
  And the list should only display the specialist's "Name"
  And the row for "Selenium Test" should have an action control (e.g., a delete icon)

Scenario: Search Assigned Specialists
  And the "Assigned Specialists" tab is selected
  When I enter "Selenium" into the search bar
  Then the list should be filtered to only show "Selenium Test"
  When I enter "Non-existent Specialist" into the search bar
  Then the list should display an empty state or "No results found"

Scenario: Removing an Assigned Specialist
  And the "Assigned Specialists" tab is selected
  When I click the delete icon (trashcan) on the "Selenium Test" row
  Then I should see a confirmation modal to remove the specialist
  When I confirm the removal
  Then the specialist "Selenium Test" should be removed from the list
  And the "Assigned Specialists" tab should revert to the empty state if no others remain

Scenario: Assigned Specialists tab (Empty State)
  When I click on the "Assigned Specialists" tab
  And no specialists are currently assigned
  Then I should see the heading "Assigned Specialists"
  And I should see a search bar with placeholder "Search assigned specialists..."
  And I should see the "Add Specialists" button
  And I should see the table area displaying an empty state message (e.g., "This table is empty." or "No items found")
  And I should see a clear call-to-action to "Add Specialists" within the empty state area

Scenario: E2E - Successfully assigning a new Specialist to the Orchestrator
  Given I am viewing the "Assigned Specialists" tab for the "Autonomous flows" Orchestrator Agent
  And the Specialist "New Test Specialist" is not currently assigned
  When I click the "Add Specialists" button
  Then I should see the "Assign Specialists" modal (or similar wizard)
  When I select "New Test Specialist" from the available Specialists list
  And I click the "Confirm" or "Assign" button in the modal
  Then the "Assign Specialists" modal should close
  And I should see the success notification (e.g., "Specialist assigned successfully")
  And the "Assigned Specialists" list should now contain the row for "New Test Specialist"
