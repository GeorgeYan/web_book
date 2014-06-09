Feature: Hello World

  Scenario: Sends a message
    Given I send a messge
    When I press "Send message"
    Then page should have notice message "you send message succeed"
