Feature: Agents Specialist Settings management

Background: User is on Agent Settings tab
  Given I am logged in to the dashboard
  And I navigate to the Agents page
  And I open agent "New Package test"
  And I click the "Settings" tab in the left sidebar

Scenario: Settings page layout
  Then I should see the section title "Agent Settings"
  And I should see the field label "Chunk size"
  And I should see the Save Settings button
  And I should see the "Export Agent" section with the Export Agent button
  And I should see the "Archive this agent" section with the Archive agent button

Scenario: Chunk size input default/help text
  Then the chunk size input should be visible with default value "0" or empty
  And I should see helper text about default chunk size when left empty

Scenario: E2E - Update chunk size and save
  Given I am on the Settings tab for agent "New Package test"
  When I change chunk size to "1"
  And I click "Save Settings"
  Then I should see success toasts for settings and chunk size
  And the chunk size field should persist value "1" after a page refresh

Scenario: Save Settings success
  When I set chunk size to "1"
  And I click "Save Settings"
  Then I should see a success toast "Agent settings saved successfully!"
  And I should see a success toast "Agent chunk file size updated successfully"

Scenario: Save Settings validation for non-numeric
  When I enter "abc" in chunk size
  And I click "Save Settings"
  Then I should see a validation error indicating invalid number
  And settings should not be saved

Scenario: Save Settings validation for negative
  When I enter "-1" in chunk size
  And I click "Save Settings"
  Then I should see a validation error for negative value
  And settings should not be saved

Scenario: Open Export Agent modal
  When I click the "Export Agent" button
  Then I should see the "Export Agent" modal
  And I should see the optional password field with placeholder "Leave empty for no password"
  And I should see buttons "Cancel" and "Export"

Scenario: Export Agent without password
  And the Export Agent modal is open
  When I leave password empty
  And I click "Export"
  Then an export should start (or success toast/download prompt appears)
  And the modal should close

Scenario: Export Agent with password
  And the Export Agent modal is open
  When I enter "P@ssw0rd!" as password
  And I click "Export"
  Then an export should start using the password
  And the modal should close

Scenario: Cancel Export Agent
  And the Export Agent modal is open
  When I click "Cancel"
  Then the modal should close
  And no export should start

Scenario: Open Archive agent confirmation
  When I click the "Archive agent" button
  Then I should see the confirmation dialog titled "Archive agent"
  And I should see the message "Are you sure you want to archive this agent?"
  And I should see buttons "Cancel" and red "Archive"

Scenario: Confirm Archive agent
  And the Archive agent dialog is open
  When I click "Archive"
  Then the agent should be archived (status changes or success toast)
  And the dialog should close

Scenario: Cancel Archive agent
  And the Archive agent dialog is open
  When I click "Cancel"
  Then the dialog should close
  And the agent should remain active

Scenario: E2E - Archive agent flow
  Given I am on the Settings tab for agent "New Package test"
  When I click "Archive agent"
  And I confirm "Archive"
  Then the agent should move to archived state (or disappear from active list)
  And a success message should appear

Scenario: E2E - Archive agent cancel
  Given I am on the Settings tab for agent "New Package test"
  When I click "Archive agent"
  And I click "Cancel"
  Then the dialog should close
  And the agent should remain active
