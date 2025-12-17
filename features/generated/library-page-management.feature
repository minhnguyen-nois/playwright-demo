Feature: Library page management

Background:
  Given I am signed in as "minhnguyen"
  When I click "Library" in the left sidebar
  Then I should land on the Library page
  And I should see the breadcrumbs "Pages / Library"
  And I should see the page title "Library"
  And I should see the "Library" menu item highlighted in the sidebar

Scenario: User views Library page elements
  Given I am on the Library page
  Then I should see a search bar with placeholder "Search files/folders..."
  And I should see the "Documents" and "Workflows" folders card
  And each folder card should display a yellow folder icon
  And each folder card should display "Folder" label below the folder name

Scenario: User searches for files or folders in Library
  Given I am on the Library page
  When I enter text in the search bar "Dxfact-Lab1"
  Then I should see search results filtered based on the entered text

Scenario: User clicks on Documents folder
  Given I am on the Library page
  When I click on the "Documents" folder card
  Then I should be navigated to the Documents folder contents

Scenario: User clicks on Workflows folder
  Given I am on the Library page
  When I click on the "Workflows" folder card
  Then I should be navigated to the Workflows folder contents
