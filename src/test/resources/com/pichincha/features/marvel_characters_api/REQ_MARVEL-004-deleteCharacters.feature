@REQ_MARVEL-004 @HU004 @delete_characters @marvel_characters_api @Agent2 @E2 @REQ_MARVEL-004-marvel_initiative
Feature: MARVEL-004 Delete Marvel Characters (API for deleting characters)

  Background:
    * def userNamespace = 'schancay'
    * url port_marvel_characters_api
    * def generateHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json",
          "Accept": "application/json"
        };
      }
      """
    * def headers = generateHeaders()
    * headers headers

  @id:1 @deleteCharacter @successfulDeletion204
  Scenario: T-API-MARVEL-004-CA01-Successfully delete character 204 - karate
    * call read('commonUtilCreateCharacter.feature@UtilCreateCharacter')
    * def characterId = responseCreateCharacter.id
    * print 'Character ID: ' + characterId
    * path '/' + userNamespace +'/api/characters/' + characterId
    When method DELETE
    Then status 204
    * print response
    And match response == ''
    And match responseHeaders['Content-Length'][0] == '0'

  @id:2 @deleteCharacter @characterNotFound404
  Scenario: T-API-MARVEL-004-CA02-Delete non-existent character 404 - karate
    * path '/' + userNamespace +'/api/characters/999'
    When method DELETE
    Then status 404
    * print response
    And match response.error == 'Character not found'
    And match response != null

  @id:3 @deleteCharacter @validationError500
  Scenario: T-API-MARVEL-004-CA03-Delete character with invalid ID 400 - karate
    * path '/' + userNamespace +'/api/characters/invalid'
    When method DELETE
    Then status 500
    * print response
    And match response.error != null

  @id:4 @deleteCharacter @serviceError500
  Scenario: T-API-MARVEL-004-CA04-Internal server error 500 - karate
    * path '/' + userNamespace +'/api/characters/error'
    When method DELETE
    Then status 500
    * print response
    And match response.error != null
    And match response.error == 'Internal server error'
