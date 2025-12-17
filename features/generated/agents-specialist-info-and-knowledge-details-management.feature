Feature: Agents Specialist Info and Knowledge details management

Background: User is viewing an Agent's detail page
  Given I am viewing the Agents list
  When I click the "View Details" button on an Agent Specialist card (e.g., "Tr? l� ti�u chu?n Logistics demo")
  Then I should be redirected to the Agent detail page
  And I should see the Agent's profile card on the left sidebar (e.g., Name, Type, Status)
  And the default view should be the "Agent Info" tab
  And I should see the navigation tabs: "Agent Info", "Knowledge", "Workflows", "Evaluate", "ACL", "Settings", "Integrations", and "Suggestions"

Scenario: User views Agent Info tab
  And I am viewing the "Agent Info" tab
  Then I should see the "Agent Information" heading
  And I should see an editable "Name" field populated with the Agent's name
  And I should see a non-editable "Agent ID" field
  And I should see an editable "Description" text area
  And I should see a "Save Changes" button (disabled when nothing changed)

Scenario: Editing Agent Info (Specialist)
  Given I am viewing the details for the "Tr? l� ti�u chu?n Logistics demo" Agent (Type: Specialist)
  And the "Agent Info" tab is selected
  When I modify the Description field (e.g., change to "updated flows CICD")
  Then the "Save Changes" button should become enabled
  When I click the "Save Changes" button
  Then the Agent Information should be updated successfully

Scenario: User views Knowledge tab (Default: Documents)
  When I click on the "Knowledge" tab
  Then I should see the "Knowledge Base" heading
  And I should see sub-tabs: "Documents", "Expertise", and "Guidances"
  And the "Documents" sub-tab should be selected
  And I should see an "Update from Library" button
  And I should see a "Save" button
  And I should see a list/table of existing documents

Scenario: User opens Update from Library modal
  When I click on the "Knowledge" tab
  And I continue click on the "Update from Library" button
  Then I should see the "Select New Documents" modal
  And I should see the file/folder structure in the Library
  And I should see a checkbox next to each file/folder
  And I should see a summary of selected files (e.g., "5 file selected (including the current files)")
  And I should see "Cancel" and "Confirm" buttons

Scenario: User selects new documents in the Library modal
  When I click on the "Knowledge" tab
  And I continue click on the "Update from Library" button
  And the "Select New Documents" modal is open
  When I click the checkbox next to a file/document that is not currently in the knowledge base
  Then the file should be marked as selected
  And the summary count should increase accordingly (e.g., "6 file selected")

Scenario: User confirms selection in Library modal
  When I click on the "Knowledge" tab
  And I continue click on the "Update from Library" button
  And the "Select New Documents" modal is open
  And I have selected at least one new document
  When I click the "Confirm" button
  Then the "Select New Documents" modal should be closed
  And the "Documents" list should be updated to reflect the change
  And the "Save" button should become enabled

Scenario: User cancels selection in Library modal
  When I click on the "Knowledge" tab
  And I continue click on the "Update from Library" button
  And the "Select New Documents" modal is open
  When I click the "Cancel" button
  Then the "Select New Documents" modal should be closed
  And the "Documents" list should remain unchanged
  And the "Save" button should remain disabled (if it was initially disabled)

Scenario: User saves pending changes and regenerates suggestions
  When I click on the "Knowledge" tab
  And I continue click on the "Update from Library" button
  And the "Select New Documents" modal is open
  And I have selected at least one new document
  And I have confirmed new document selections from the Library
  And the "Save" button is enabled
  When I click the "Save" button
  Then I should see the "Update Knowledge Base" confirmation popup
  And the popup should confirm the number of items being added (e.g., "add 1 item(s)")
  And the "Regenerate Suggestions" checkbox should be checked by default
  When I click the "Confirm" button in the popup
  Then the knowledge base should be updated successfully
  And the new documents should be fully visible in the Documents list
  And the "Save" button should become disabled

Scenario: E2E - Successfully adding a new document via Update from Library
  When I click on the "Update from Library" button
  Then I should see the "Select New Documents" modal
  When I search for and locate "New Document XYZ" in the modal
  And I click the checkbox next to "New Document XYZ"
  And I click the "Confirm" button in the modal
  Then the "Select New Documents" modal should be closed
  And the "Save" button should become enabled
  When I click the "Save" button
  Then I should see the "Update Knowledge Base" confirmation popup
  When I click the "Confirm" button in the popup
  Then the "Update Knowledge Base" popup should close
  And I should see "New Document XYZ" successfully added to the Documents list
  And the "Save" button should return to a disabled state

Scenario: User is viewing the Agent Knowledge Base Expertise tab
  And I click on the "Knowledge" tab
  And I click on the "Expertise" sub-tab
  Then I should see the sub-sub-tabs: "Feedbacks" and "Technical Notes"

Scenario: User views Feedbacks sub-sub-tab (Empty State)
  And I click on the "Knowledge" tab
  And the "Feedbacks" sub-sub-tab is selected
  Then I should see a search bar with placeholder "Search feedbacks..."
  And I should see the table empty state message "This table is empty."
  And I should see the message "No items found"

Scenario: User searches for feedbacks within Agent Expertise
  And I click on the "Knowledge" tab
  And the "Feedbacks" sub-sub-tab is selected
  When I enter text in the search bar "Search feedbacks..."
  Then I should see feedback rows filtered based on the entered text

Scenario: User views Technical Notes sub-sub-tab (Empty State)
  And I click on the "Knowledge" tab
  And the "Feedbacks" sub-sub-tab is selected
  When I click on the "Technical Notes" sub-sub-tab
  Then I should see a search bar with placeholder "Search technical notes..."
  And I should see the "Status" filter dropdown
  And I should see the "Add technical note" button
  And I should see the table empty state message "This table is empty."
  And I should see a prominent "Add technical note" button in the empty state

Scenario: User searches for technical notes within Agent Expertise
  And I click on the "Knowledge" tab
  And the "Feedbacks" sub-sub-tab is selected
  When I click on the "Technical Notes" sub-sub-tab
  And the "Technical Notes" sub-sub-tab is selected
  When I enter text in the search bar "Search technical notes..."
  Then I should see technical note rows filtered based on the entered text

Scenario: User opens Create New Technical Note modal
  And the "Technical Notes" sub-sub-tab is selected
  When I click on the "Add technical note" button in the action bar
  Then I should see the "Create New Technical Note" modal
  And I should see the required fields "Question *" and "Answer *"
  And I should see "Cancel" and "Create Note" buttons

Scenario: E2E - Successfully creating a New Technical Note
  Given I am viewing the "Knowledge" tab for an Agent (e.g., "New Package test")
  And I have clicked on the "Expertise" sub-tab
  And the "Technical Notes" sub-sub-tab is selected
  When I click on the "Add technical note" button in the action bar
  Then I should see the "Create New Technical Note" modal
  And I should see the required fields "Question *" and "Answer *"
  When I enter valid text in the "Question *" field (e.g., "HOW")
  And I enter valid text in the "Answer *" field (e.g., "This is because")
  And I click on the "Create Note" button
  Then the "Create New Technical Note" modal should be closed
  And I should see a new row added to the Technical Notes table
  And the new row should show the "Question" as "HOW"
  And the new row should show the "Answer" as "This is because"
  And the new row should show the "Status" as "PENDING

Scenario: User views Technical Notes list when notes exist
  And I am viewing the "Technical Notes" sub-sub-tab
  And at least one Technical Note exists (e.g., has just been created)
  Then I should see a table with columns: "Question", "Answer", "Status", and "Actions"
  And I should see the Technical Note row displayed in the table
  And the row should show the entered "Question"
  And the row should show the entered "Answer"
  And the row should show the "Status" as "PENDING"
  And the row should have an action control (e.g., a delete icon) under the "Actions" column

Scenario: User interacts with existing Technical Note
  And a Technical Note exists in the list (e.g., Status: PENDING)
  When I click the delete icon on the Technical Note row
  Then I should see a confirmation modal to delete the note
  When I confirm the deletion
  Then the Technical Note should be removed from the list

Scenario: E2E - Technical Note created in Agent Detail appears on Main Technical Notes menu
  And I am viewing the "Knowledge" tab for an Agent (e.g., "New Package test")
  Then I click on the "Expertise" sub-tab
  Then I click on the "Technical Notes" sub-sub-tab
  When I click on the "Add technical note" button in the action bar
  Then I should see the "Create New Technical Note" modal
  When I enter "Check E2E Flow" in the "Question *" field
  And I enter "Verification of cross-menu sync." in the "Answer *" field
  And I click on the "Create Note" button
  Then the modal should be closed
  And the new Technical Note should be visible in the Agent's Technical Notes list
  When I click on the "Technical Notes" menu item in the left sidebar
  Then I should be redirected to the Technical Notes page
  And the "Technical Notes" menu item should show an updated notification badge (e.g., number increments)
  Then I should see a table with columns: "Question", "Answer", "Status", "Agent", and "Actions"
  And I should see the row with "Question" = "Check E2E Flow" displayed in the table
  And the row should show "Answer" = "Verification of cross-menu sync."
  And the row should show the "Status" as "PENDING"
  And the row should show the associated "Agent" ID/Name

Scenario: User views Guidances tab elements (Empty State)
  Then I click on the "Knowledge" tab
  And I click on the "Guidances" tab
  Then I should see the "Guidances" heading
  And no guidances have been created
  Then I should see a search bar with placeholder "Search guidances..."
  And I should see the "Add guidance" button in the action bar
  And I should see the table empty state message "This table is empty."
  And I should see a prominent "Add guidance" button in the empty state

Scenario: User views Guidance list when items exist
  Then I click on the "Knowledge" tab
  And I click on the "Guidances" tab
  And at least one Guidance exists
  Then I should see a table with columns: "Name", "Description", "Created Date", "Updated Date", and "Actions"
  And the row should show the "Name" (e.g., "X? l� document")
  And the row should show the "Description" (e.g., "handled")
  And the row should show the creation and update dates
  And the row should have an action control (e.g., delete icon)

Scenario: User opens Add New Guidance modal
  Then I click on the "Knowledge" tab
  And I click on the "Guidances" tab
  And I click on the "Add guidance" button
  Then I should see the "Add New Guidance" modal
  And I should see the required field "Name *"
  And I should see the required field "Description *"
  And I should see the "Create Guidance" button

Scenario: User successfully creates a new Guidance
  Then I click on the "Knowledge" tab
  And I click on the "Guidances" tab
  When I click on the "Add guidance" button
  Then the "Add New Guidance" modal is open
  When I enter valid text in the "Name *" field (e.g., "X? l� document")
  And I enter valid text in the "Description *" field (e.g., "handled")
  When I click on the "Create Guidance" button
  Then the modal should be closed
  And I should see the success notification "Guidance created successfully"
  And the new Guidance should be successfully added to the list

Scenario: User opens Edit Guidance modal
  Then I click on the "Knowledge" tab
  And I click on the "Guidances" ta
  And a Guidance exists in the list
  When I click on the row "Guidancename" (e.g., Handle document)
  Then I should see the "Edit Guidance" modal
  And the fields "Name *" and "Description *" should be pre-populated with current values
  And I should see the "Save Changes" button

Scenario: User successfully edits and saves a Guidance
  Then I click on the "Knowledge" tab
  And I click on the "Guidances" ta
  And a Guidance exists in the list
  When I click on the row "Guidancename" (e.g., Handle document)
  And the "Edit Guidance" modal is open
  When I modify the "Description *" field (e.g., change from "handled" to "fully handled")
  And I click the "Save Changes" button
  Then the modal should be closed
  And I should see the success notification "Guidance updated successfully"
  And the Guidance list should update with the new "Description"
  And the "Updated Date" should reflect the change

Scenario: User deletes a Guidance
  Then I click on the "Knowledge" tab
  And I click on the "Guidances" ta
  And a Guidance exists in the list
  When I click the delete icon under the "Actions" column
  Then I should see a confirmation modal for deletion
  When I confirm the deletion
  Then the Guidance should be removed from the list
  And I should see the success notification "Guidance deleted successfully"
  And the Guidance list should revert to the empty state if no other items exist

Scenario: E2E - Full lifecycle of Guidance management
  Then I click on the "Knowledge" tab
  And I click on the "Guidances" ta
  When I click on the "Add guidance" button
  And I enter "E2E Test Guidance" in the "Name *" field
  And I enter "First version of description" in the "Description *" field
  And I click on the "Create Guidance" button
  Then I should see the success notification "Guidance created successfully"
  And the new Guidance "E2E Test Guidance" should be displayed in the list
  When I click on the "E2E Test Guidance" row to open the details
  Then I should see the "Edit Guidance" modal
  When I change the "Description *" to "Updated version of description"
  And I click the "Save Changes" button
  Then I should see the success notification "Guidance updated successfully"
  And the list should update, showing "Updated version of description" for "E2E Test Guidance"
  When I click the delete icon on the "E2E Test Guidance" row
  And I confirm the deletion in the modal
  Then I should see the success notification "Guidance deleted successfully"
  And the "E2E Test Guidance" should be removed from the list
  And the list should revert to the empty state
