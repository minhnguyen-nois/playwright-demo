Feature: Chat page UI

Background:
  Given I am signed in as "minhnguyen"
  When I click "Chat" in the left sidebar
  Then I should land on the Chat page

Scenario: User views chat layout
  Then I should see a left sidebar with "New Chat" button
  And I should see a conversation list panel
  And I should see the main chat area with message history
  And I should see a message input box with placeholder "Message..."
  And I should see the current workspace/agent selector at the top of the chat

Scenario: Agent dropdown presence
  When I open the "Select Agent" dropdown in the top bar
  Then I should see a list of available agents (or an empty state if none)
  And selecting an agent should reflect the chosen name in the dropdown

Scenario: Agent picker in composer
  When I click the agent picker input below the chat area
  Then I should see the same agent list as the top dropdown
  And selecting an agent should update the input to that agent

Scenario: Send disabled with no agent
  Given no agent is selected
  Then the send button should be disabled
  When I type "Hello" into the message box
  Then the send button should remain disabled until an agent is selected

Scenario: Send enabled after agent selection
  Given I have selected an agent
  When I type "Hello" into the message box
  Then the send button should become enabled

Scenario: Start new chat from sidebar
  When I click "New Chat" in the left sidebar
  Then the conversation should reset to an empty state
  And the hero prompt should remain visible
  And no agent should be preselected

Scenario: User sends a message
  And a conversation is selected
  When I type a question in the message input
  And I send the message
  Then I should see my message appear in the chat history
  And I should see a "Thinking" or progress indicator
  And I should see the assistant response when ready

Scenario: User sees thinking and retrieval steps
  And the assistant is processing a message
  Then I should see a "Thinking" section with steps like knowledge retrieval and reasoning

Scenario: User sees response with references and follow-ups
  And the assistant has responded
  Then I should see references or citations listed (e.g., Reference section with documents)
  And I should see suggested follow-up questions displayed as quick replies

Scenario: User switches conversation
  Given there are multiple conversations in the list
  When I click on another conversation in the list
  Then the chat history should update to that conversation
  And the message input should target that conversation

Scenario: User navigates to Management from avatar menu
  When I click on the avatar/profile menu
  And I click on "Management"
  Then I should be redirected to the Agents page
  And I should see the page title "Agents"

Scenario: User starts a new chat session
  And I am viewing an existing chat session with an Agent
  When I click the "New Chat" button
  Then a new, empty chat session should be started
  And I should see the suggested quick questions/prompts

Scenario: E2E - Start a new chat and get a response
  When I click the "Chat with Agent" button on the "Tr? l� ti�u chu?n Logistics demo" Agent card
  Then I should be redirected to the Chat interface
  And I click on "New Chat"
  And I enter "How to balance business goals with environmental responsibility in logistics?" in the message input
  And I send the message
  Then I should see my message in the chat history
  And I should see a "Thinking" indicator
  And I should see an assistant response with references and suggested follow-up questions

Scenario: E2E - User selects and receives a response from a quick question prompt
  When I click the "Chat with Agent" button on the "Tr? l� ti�u chu?n Logistics demo" Agent card
  Then I should be redirected to the Chat interface
  And I should see suggested quick questions/prompts available for selection
  And the chat history is currently empty
  When I click on the suggested prompt "� ngh?a c?a tr�ch nhi?m l�nh ??o trong �p d?ng c�c ti�u chu?n ISO v�o logistics."
  Then the prompt text "� ngh?a c?a tr�ch nhi?m l�nh ??o trong �p d?ng c�c ti�u chu?n ISO v�o logistics." should appear as the user's sent message in the chat history
  And I should see the Agent starting to generate a response
  Then a response from the Agent should appear below my message in the chat history
  And the response should be relevant to the selected prompt
