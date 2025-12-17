Feature: Import Agents

Background:
  Given I am signed in and on the Agents page
  Then I should see the "Create" button with a dropdown

Scenario: Open Import Agent modal UI
  When I click the "Import Agent" button
  Then I should see the Import Agent modal
  And I should see helper text "Upload a ZIP file containing agent configuration"
  And I should see a dropzone labeled "Drag & drop agent ZIP file here"
  And I should see a "Browse Files" button, a "Cancel" button, and a disabled "Import Agent" button

Scenario: Close Import Agent modal via X
  Given the Import Agent modal is open
  When I click the X close icon
  Then the Import Agent modal should close

Scenario: Cancel Import Agent
  Given the Import Agent modal is open
  When I click the "Cancel" button
  Then the Import Agent modal should close
  And no file should be selected

Scenario: Import agent via Browse Files with valid ZIP
  When I click the "Import Agent" button
  And I click "Browse Files" and select "C:\Users\MinhNguyenThanh\Downloads\Agent-Test.zip"
  Then the selected file "Agent-Test.zip" with size should appear in the modal
  And the "Import Agent" button should become enabled
  When I enter "Agent Name" as "Agent-Test"
  And I optionally enter "Password" as "optional-pass"
  And I click the "Import Agent" button
  Then I should see a success toast "Agent imported successfully"
  And the imported agent "Agent-Test" should appear in the agents list

Scenario: Import agent via drag and drop with valid ZIP
  When I click the "Import Agent" button
  And I drag and drop "C:\Users\MinhNguyenThanh\Downloads\Agent-Test.zip" into the dropzone
  Then the selected file "Agent-Test.zip" with size should appear in the modal
  And the "Import Agent" button should become enabled
  When I enter "Agent Name" as "Agent-Test"
  And I click the "Import Agent" button
  Then I should see a success toast "Agent imported successfully"
  And the imported agent "Agent-Test" should appear in the agents list

Scenario: Import agent rejected for non-ZIP file
  When I click the "Import Agent" button
  And I click "Browse Files" and select "C:\Users\MinhNguyenThanh\Downloads\agent-config.json"
  Then I should see an error toast "Please select a ZIP file"
  And the selected file should not be accepted
  And the "Import Agent" button should remain disabled
  And no agent should be imported

Scenario: Import agent rejected for missing file
  When I click the "Import Agent" button
  And I click the "Import Agent" button without selecting a file
  Then I should see an error toast "Please select a ZIP file"
  And the modal should remain open awaiting a valid ZIP

Scenario: Remove selected file before import
  Given the Import Agent modal shows a selected file "Agent-Test.zip"
  When I click the remove (X) icon next to the file name
  Then the file selection should clear
  And the "Import Agent" button should become disabled
  And the dropzone should show "Drag & drop agent ZIP file here"
