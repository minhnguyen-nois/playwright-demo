Feature: Agent Specialist Evaluate details management

Background: User is viewing an Agent's detail page
  Given I am viewing the Agents list
  When I click the "View Details" button on an Agent card (e.g., "Tr? l� ti�u chu?n Logistics demo")
  Then I should be redirected to the Agent detail page
  And I should see the Agent's profile card on the left sidebar (e.g., Name, Type, Status)
  And the default view should be the "Agent Info" tab
  And I should see the navigation tabs: "Agent Info", "Knowledge", "Workflows", "Evaluate", "ACL", "Settings", "Integrations", and "Suggestions"

Scenario: User is viewing the Agent Evaluate tab
  When I click the "View Details" button on an Agent card (e.g., "New Package test")
  And I click on the "Evaluate" tab
  Then I should see the "Evaluate model" heading
  And I should see sub-tabs: "Datasets" and "History"
  And the "Datasets" sub-tab is selected
  Then I should see the search bar with placeholder "Search files/folders..."
  And I should see the "Upload" button
  And I should see the "Download Template" hyperlink
  And I should see the table empty state message "This folder is empty"

Scenario: User views Datasets sub-tab when files exist
  When I click the "View Details" button on an Agent card (e.g., "New Package test")
  And I click on the "Evaluate" tab
  And the "Datasets" sub-tab is selected
  And a dataset has been successfully uploaded (e.g., "evaluation_dataset.csv")
  Then I should see a table with columns: "Name" and "Created At"
  And the row for "evaluation_dataset.csv" should be displayed
  And the row should show the "Created At" date
  And the row should have an action control (e.g., a delete icon)
  And the row should have an action control to start the evaluation (e.g., a play icon or arrow)

Scenario: User views History sub-tab (Empty State)
  When I click the "View Details" button on an Agent card (e.g., "New Package test")
  And I click on the "Evaluate" tab
  And the "Datasets" sub-tab is selected
  When I click on the "History" sub-tab
  Then I should see the search bar with placeholder "Search history..."
  And I should see the empty state message "This table is empty."

Scenario: User downloads the Evaluation Template
  When I click the "View Details" button on an Agent card (e.g., "New Package test")
  And I click on the "Evaluate" tab
  Then I click on the "Download Template" hyperlink
  Then the system should initiate the download of the evaluation template file (e.g., a CSV file)

Scenario: User opens New Documents (Upload) modal
  When I click the "View Details" button on an Agent card (e.g., "New Package test")
  And I click on the "Evaluate" tab
  And the "Datasets" sub-tab is selected
  When I click on the "Upload" button
  Then I should see the "New Documents" modal
  And the modal should show the drag and drop area
  And I should see the "Browse Files" button
  And I should see the "Tips for Uploading Data" section
  And the supported file type is CSV
  And the maximum file size is 20MB per file

Scenario: User uploads a valid dataset file
  When I click the "View Details" button on an Agent card (e.g., "New Package test")
  And I click on the "Evaluate" tab
  Then i click on the "Upload" button
  And the "New Documents" modal is open
  When I drag and drop a valid CSV file (e.g., "evaluation_dataset.csv") into the upload area
  Then I should see the file "evaluation_dataset.csv" listed in the modal
  When I click the "Upload" button
  Then the "New Documents" modal should close
  And I should see the success notification "Datasets uploaded successfully" and "Files uploaded successfully"

Scenario: E2E - Successfully uploading a new dataset for evaluation
  When I click the "View Details" button on an Agent card (e.g., "New Package test")
  And I click on the "Evaluate" tab
  When I click on the "Upload" button
  Then I should see the "New Documents" modal
  When I select the file "test_evaluation_data.csv" (a valid CSV file)
  And the file "test_evaluation_data.csv" appears in the modal
  And I click the "Upload" button
  Then the "New Documents" modal should close
  And I should see the success notification "Datasets uploaded successfully"
  And I should see the file "test_evaluation_data.csv" successfully added to the Datasets list
  And the row should include the Created At date and Action controls

Scenario: User initiates deletion of an uploaded dataset
  Given I am viewing the "Evaluate" tab for an Agent
  And the "Datasets" sub-tab is selected
  And a dataset file "evaluation_dataset.csv" exists in the list
  When I click the delete icon (trashcan) on the "evaluation_dataset.csv" row
  Then I should see the "Delete File" confirmation modal
  And the modal should display the warning: "Are you sure you want to delete evaluation_dataset.csv? This action cannot be undone."
  And I should see "Cancel" and a red "Confirm" button
  When I click the red "Confirm" button in the modal
  Then the "Delete File" modal should close
  And I should see a success notification (e.g., "Dataset deleted successfully")
  And the file "e2e_delete_data.csv" should be removed from the Datasets list
  And I should see the empty state message "This folder is empty"

Scenario: User cancels deletion of a dataset
  Given I am viewing the "Evaluate" tab for an Agent
  And the "Datasets" sub-tab is selected
  And a dataset file "evaluation_dataset.csv" exists in the list
  When I click the delete icon (trashcan) on the "evaluation_dataset.csv" row
  Then I should see the "Delete File" confirmation modal
  And the modal should display the warning: "Are you sure you want to delete evaluation_dataset.csv? This action cannot be undone."
  And I should see "Cancel" and a red "Confirm" button
  When I click the "Cancel" button
  Then the modal should close
  And the dataset "evaluation_dataset.csv" should remain in the Datasets list

Scenario: User initiates evaluation for an uploaded dataset
  When I click the "View Details" button on an Agent card (e.g., "New Package test")
  And I click on the "Evaluate" tab
  And a dataset file "evaluation_dataset.csv" exists in the list
  When I hover over the action controls for the "evaluation_dataset.csv" row
  Then I should see the "Run Evaluation" icon (or similar action control)
  When I click the "Run Evaluation" icon
  Then I should see the "Evaluate Dataset" confirmation modal
  And the modal should ask: "Are you sure you want to evaluate this agent with this file: evaluation_dataset.csv?"
  And I should see "Cancel" and "Confirm" buttons

Scenario: User successfully confirms and starts the evaluation
  When I click the "View Details" button on an Agent card (e.g., "New Package test")
  And I click on the "Evaluate" tab
  And a dataset file "evaluation_dataset.csv" exists in the list
  When I click the "Run Evaluation" icon on the Dataset row
  And the "Evaluate Dataset" confirmation modal is open
  When I click the "Confirm" button
  Then the modal should close
  And I should see the success notification "Evaluation started successfully"

Scenario: User views evaluation results in History tab
  When I click the "View Details" button on an Agent card (e.g., "New Package test")
  And I click on the "Evaluate" tab
  And a dataset file "evaluation_dataset.csv" exists in the list
  When I click the "Run Evaluation" icon on the Dataset row
  And the "Evaluate Dataset" confirmation modal is open
  When I click the "Confirm" button
  Then the modal should close
  And I should see the success notification "Evaluation started successfully"
  When I click on the "History" sub-tab
  And I should see the row for "evaluation_dataset.csv" in the table
  And the row should show the "Status" as "Done"
  And the row should show the "Created at" date/time

Scenario: User views Evaluation Details modal in History sub-tab
  Given I am viewing the "Evaluate" tab for an Agent
  And the "History" sub-tab is selected
  And a completed evaluation for "evaluation_dataset.csv" exists in the table
  When I click on the row or the view details action for "evaluation_dataset.csv"
  Then I should see the "Evaluation Details" modal
  And the modal should display the overall "Accuracy" score
  And I should see a search bar with placeholder "Search questions..."
  And I should see a table detailing the individual questions with columns: "User Question", "Expected Answer", "AI Answer", and "Score"
  And the table should contain the row with "User Question" as "Hi"
  And the row should show "Expected Answer" as "Hello! How can I assist you today?"
  And the row should show "AI Answer" as "[ERROR: Failed to process]"
  And the row should show the "Score" as "0"

Scenario: User searches within the Evaluation Details modal
  Given I am viewing the "Evaluate" tab for an Agent
  And the "History" sub-tab is selected
  And a completed evaluation for "evaluation_dataset.csv" exists in the table
  When I click on the row or the view details action for "evaluation_dataset.csv"
  Then I should see the "Evaluation Details" modal
  When I enter text (e.g., "Hello") in the "Search questions..." bar
  Then the individual question rows in the table should be filtered based on the search text

Scenario: E2E - Full lifecycle of Evaluation (Upload -> Run -> History)
  Given I am viewing the "Evaluate" tab for an Agent
  And I have successfully uploaded the file "e2e_test_data.csv"
  When I click the "Run Evaluation" icon for "e2e_test_data.csv"
  And I click the "Confirm" button in the "Evaluate Dataset" modal
  Then I should see the success notification "Evaluation started successfully"
  When the evaluation process for "e2e_test_data.csv" is completed
  When I click on the "History" sub-tab
  Then I should see the row for "e2e_test_data.csv" in the History table
  And the "Status" for "e2e_test_data.csv" should be "Done"
