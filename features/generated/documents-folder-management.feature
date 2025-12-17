Feature: Documents folder management

Background:
  Given I am logged in to the dashboard
  When I click on the "Library" menu item in the left sidebar
  And I click on the "Documents" folder card
  Then I should be navigated to the Documents folder contents

Scenario: User views Documents page elements
  Then I should see a search bar with placeholder "Search files/folders..."
  And I should see the "+ New" button
  And I should see a table with headers "Name" and "Created At"
  And I should see a checkbox in the table header for selecting all items
  And I should see the "Move" button with folder and arrow icon
  And I should see the "Delete" button with trash can icon
  And I should see the "Name A-Z" sorting option with up/down arrow
  And I should see the "Size" sorting option with up/down arrow
  And I should see view toggle icons (list view and grid view)
  And I should see the summary text showing item count

Scenario: User views empty Documents state
  And no documents or folders exist
  Then I should see the summary text "0 item � 0 folder � 0 file"

Scenario: User views Documents page with existing folders
  And there are existing folders in the Documents page
  Then I should see a table with columns "Name", "Size", "Type", and "Created At"
  And I should see folder rows displayed in the table
  And each folder row should display a yellow folder icon
  And each folder row should display the folder name
  And each folder row should display "Folder" in the Type column
  And each folder row should display the creation date in "Created At" column
  And each folder row should have a checkbox for selection
  And each folder row should have a blue pencil icon for editing
  And each folder row should have a red trash can icon for deleting
  And I should see the summary text showing the correct count of items, folders, and files

Scenario: User selects an individual folder
  And there are existing folders in the Documents page
  When I click on the checkbox for a specific folder
  Then that folder should be selected
  And the "Move" and "Delete" buttons should be enabled

Scenario: User selects multiple folders
  And there are multiple folders in the Documents page
  When I click on the checkbox for the first folder
  And I click on the checkbox for the second folder
  Then both folders should be selected
  And the "Move" and "Delete" buttons should be enabled
  And the summary should show the number of selected items

Scenario: User selects all documents
  When I click on the checkbox in the table header
  Then all documents should be selected
  And the "Move" and "Delete" buttons should be enabled

Scenario: User searches for files in Documents page
  When I enter text in the search bar "Dxfact-Lab1"
  Then I should see search results filtered based on the entered text

Scenario: User sorts documents by name
  When I click on the "Name A-Z" sorting option
  Then the documents should be sorted by name in ascending order

Scenario: User sorts documents by size
  When I click on the "Size" sorting option
  Then the documents should be sorted by size

Scenario: User toggles between list and grid view
  When I click on the grid view icon
  Then the documents should be displayed in grid view
  When I click on the list view icon
  Then the documents should be displayed in list view

Scenario: User moves selected documents
  And I have selected one or more documents
  When I click on the "Move" button
  Then I should see a modal dialog titled "Move X Item(S) To"
  And I should see a close "X" button in the top right corner of the modal
  And I should see a path/breadcrumb navigation with a home icon
  And I should see destination folder options
  And I should see a "Cancel" button
  And I should see a "Move Here" button

Scenario: User selects a destination folder in move dialog
  When I click on a destination folder in the move dialog
  Then that folder should be highlighted or selected
  And the path should update to show the selected folder location

Scenario: User navigates path in move dialog
  When I click on the home icon in the path
  Then I should see the root directory folders
  When I click on a folder in the breadcrumb path
  Then I should navigate to that folder location
  And I should see the folders within that location

Scenario: User moves items to selected destination
  And I have selected a destination folder
  When I click on the "Move Here" button
  Then the items should be moved to the selected destination folder
  And the modal should be closed
  And I should see a success message or confirmation
  And the items should no longer appear in the current location
  And the items should appear in the destination folder

Scenario: User cancels moving items
  When I click on the "Cancel" button in the move dialog
  Then the modal should be closed
  And no items should be moved
  And the selected items should remain in their original location

Scenario: User closes move dialog using X button
  When I click on the "X" close button in the move dialog
  Then the modal should be closed
  And no items should be moved
  And the selected items should remain in their original location

Scenario: User edits a folder using edit icon
  And there are existing folders in the Documents page
  When I click on the blue pencil edit icon for a folder
  Then I should see an edit dialog or form open
  And I should see the current folder name in the input field
  When I update the folder name
  And I use the Enter keyboard to save
  Then the folder name should be updated successfully
  And I should see the updated folder name in the Documents list

Scenario: User deletes selected documents
  And I have selected one or more documents
  When I click on the "Delete" button
  Then I should see a confirmation dialog
  And when I confirm the deletion
  Then the selected documents should be deleted

Scenario: User deletes a folder using delete icon
  And there are existing folders in the Documents page
  When I click on the red trash can delete icon for a folder
  Then I should see a confirmation dialog
  When I confirm the deletion
  Then the folder should be deleted successfully
  And the folder should no longer appear in the Documents list
  And the summary count should be updated

Scenario: User cancels deleting a folder
  And there are existing folders in the Documents page
  When I click on the red trash can delete icon for a folder
  Then I should see a confirmation dialog
  When I cancel the deletion
  Then the folder should remain in the Documents list
  And no changes should be made

Scenario: User clicks on New button to create new folder
  When I click on the "New" button
  Then I should see a modal dialog open
  And I should see two tabs: "New Folder" and "Upload File"
  And I should see the "New Folder" tab selected by default

Scenario: User creates a new folder
  When I enter a folder name in the "Folder Name" input field
  And I click on the "Create" button
  Then the folder should be created successfully
  And the modal should be closed
  And I should see the new folder in the Documents list

Scenario: User cancels creating a new folder
  When I click on the "Cancel" button
  Then the modal should be closed
  And no new folder should be created

Scenario: E2E - Complete flow to create a new document folder from scratch
  Then I should be navigated to the Documents folder contents
  And I should see the sub-navigation "Library > Documents" with "Documents" highlighted
  And I should see the "New" button
  When I click on the "New" button
  Then I should see a modal dialog open
  And I should see two tabs: "New Folder" and "Upload File"
  And I should see the "New Folder" tab selected by default
  When I enter "Project Documents" in the "Folder Name" input field
  And I click on the "Create" button
  Then the folder should be created successfully
  And the modal should be closed
  And I should see the new folder "Project Documents" in the Documents list
  And the folder should display a yellow folder icon
  And the folder should display "Folder" in the Type column
  And the summary count should be updated to include the new folder

Scenario: E2E - Create nested document folder structure
  Then I should be navigated to the Documents folder contents
  When I click on the "+ New" button
  And I enter "2024 Projects" in the "Folder Name" input field
  And I click on the "Create" button
  Then the folder "2024 Projects" should be created successfully
  And I should see "2024 Projects" in the Documents list
  When I click on the "2024 Projects" folder
  Then I should be navigated to the "2024 Projects" folder contents
  And I should see the sub-navigation "Library > Documents > 2024 Projects"
  When I click on the "+ New" button
  And I enter "Q1 Reports" in the "Folder Name" input field
  And I click on the "Create" button
  Then the folder "Q1 Reports" should be created successfully
  And I should see "Q1 Reports" in the current folder list
  When I click on the parent directory row with ellipsis "..."
  Then I should be navigated back to the Documents folder
  And I should see the "2024 Projects" folder in the list
  When I click on the "2024 Projects" folder again
  Then I should see the "Q1 Reports" folder in the nested structure

Scenario: E2E - Create multiple document folders and verify organization
  Then I should be navigated to the Documents folder contents
  When I click on the "+ New" button
  And I enter "Marketing Materials" in the "Folder Name" input field
  And I click on the "Create" button
  Then the folder "Marketing Materials" should be created successfully
  When I click on the "New" button
  And I enter "Sales Documents" in the "Folder Name" input field
  And I click on the "Create" button
  Then the folder "Sales Documents" should be created successfully
  When I click on the "New" button
  And I enter "HR Files" in the "Folder Name" input field
  And I click on the "Create" button
  Then the folder "HR Files" should be created successfully
  When I view the Documents list
  Then I should see all three folders: "Marketing Materials", "Sales Documents", and "HR Files"
  And each folder should display a yellow folder icon
  And the summary count should show "3 item � 3 folder � 0 file"
  When I click on the "Name A-Z" sorting option
  Then the folders should be sorted alphabetically: "HR Files", "Marketing Materials", "Sales Documents"

Scenario: E2E - Create document folder, edit it, and verify changes
  Then I should be navigated to the Documents folder contents
  When I click on the "New" button
  And I enter "Draft Folder" in the "Folder Name" input field
  And I click on the "Create" button
  Then the folder "Draft Folder" should be created successfully
  When I click on the blue pencil edit icon for the "Draft Folder"
  Then I should see an edit dialog or form open
  And I should see "Draft Folder" in the input field
  When I update the folder name to "Final Folder"
  And I click on the "Save" button
  Then the folder name should be updated successfully
  And I should see "Final Folder" in the Documents list
  And the folder "Draft Folder" should no longer appear
  When I click on the "Final Folder"
  Then I should be navigated to the "Final Folder" contents
  And I should see the sub-navigation "Library > Documents > Final Folder"

Scenario: User closes the new folder modal
  When I click on the "X" close button in the modal
  Then the modal should be closed

Scenario: User views Upload File tab
  Then I should see a drag and drop area with text "Drag and drop files here"
  And I should see the text "or click to select files (PDF, DOC, DOCX, XLS, XLSX, CSV)"
  And I should see a "Browse Files" button
  And I should see a "No files added" section
  And I should see the "Tips for Uploading Data" section

Scenario: User uploads files via drag and drop
  When I drag and drop a file into the drag and drop area
  Then the file should appear in the "Files Added" section
  And I should see the "Upload" button enabled

Scenario: User uploads files via Browse Files button
  When I click on the "Browse Files" button
  And I select a file from the file picker
  Then the file should appear in the "Files Added" section
  And I should see the "Upload" button enabled

Scenario: User completes file upload
  And I have added files to upload
  When I click on the "Upload" button
  Then the files should be uploaded successfully
  And the modal should be closed
  And I should see the uploaded files in the Documents list

Scenario: E2E - Create document folder, upload files, and organize
  Then I should be navigated to the Documents folder contents
  When I click on the "New" button
  And I enter "Client Contracts" in the "Folder Name" input field
  And I click on the "Create" button
  Then the folder "Client Contracts" should be created successfully
  When I click on the "Client Contracts" folder
  Then I should be navigated to the "Client Contracts" folder contents
  When I click on the "New" button
  And I click on the "Upload File" tab
  Then I should see the "Upload File" tab selected
  And I should see a drag and drop area
  When I click on the "Browse Files" button
  And I select a PDF file from the file picker
  Then the file should appear in the "Files Added" section
  And I should see the "Upload" button enabled
  When I click on the "Upload" button
  Then the files should be uploaded successfully
  And the modal should be closed
  And I should see the uploaded file in the "Client Contracts" folder list
  And the file should display the correct file type icon
  And the summary count should show the uploaded file

Scenario: User cancels file upload
  When I click on the "Cancel" button
  Then the modal should be closed
  And no files should be uploaded
