Feature: Notification receiving

Background: User is logged in and on dashboard header
  Given I am logged in to the dashboard
  And I see the notification bell in the header

Scenario: Receive notification when a technical note is created
  Given there is no unread notification
  When a new technical note titled "New Technical Note: HOW TO DEPLOY" is created by any user
  And I open the notification dropdown
  Then I should see an item with text "New Technical Note: HOW TO DEPLOY"
  And I should see a timestamp like "just now" or similar relative time
  And the notification item should be marked as unread

Scenario: Clicking notification opens Technical Note Details modal
  Given there is an unread technical note notification
  When I click the notification item
  Then the Technical Note Details modal should open
  And it should show fields Agent, Status, Created By, Created Date, Updated Date, Question, Answer
  And the Status badge should match the note status (e.g., PENDING)
  And the notification should be marked as read

Scenario: Unread indicator disappears after opening
  Given there is an unread technical note notification
  When I click the notification item to open the modal
  And I close the modal
  Then the notification item should be marked as read
  And the bell unread count should decrease accordingly

Scenario: Multiple notifications order
  Given there are multiple technical note notifications created at different times
  When I open the notification dropdown
  Then notifications should be sorted with newest on top
  And each item should show its own relative timestamp

Scenario: Notification persists after page refresh
  Given a technical note notification exists
  When I refresh the page
  And I open the notification dropdown
  Then I should still see the notification item
  And it should retain its read/unread state
