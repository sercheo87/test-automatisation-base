@REQ_MARVEL-003 @HU003 @update_characters @marvel_characters_api @Agent2 @E2 @REQ_MARVEL-003-marvel_initiative
Feature: MARVEL-003 Update Marvel Characters (API for updating existing characters)

  Background:
    * def userNamespace = 'schancay'
    * url port_marvel_characters_api
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json",
          "Accept": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers

  @id:1 @updateCharacter @successfulUpdate200
  Scenario: T-API-MARVEL-003-CA01-Successfully update character 200 - karate
    * def commonFunctions = karate.call('commonFunction.feature')
    * call read('commonUtilCreateCharacter.feature@UtilCreateCharacter')
    * def characterId = responseCreateCharacter.id
    * print 'Character ID: ' + characterId
    * def jsonData = read('classpath:data/marvel_characters_api/request_update_character.json')
    * jsonData.name = 'Updated-' + commonFunctions.randomString(5)
    * path '/' + userNamespace +'/api/characters/' + characterId
    And request jsonData
    When method PUT
    Then status 200
    * print response
    And match response.id == characterId
    And match response.name == jsonData.name

  @id:2 @updateCharacter @characterNotFound404
  Scenario: T-API-MARVEL-003-CA02-Update non-existent character 404 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_update_character.json')
    * path '/' + userNamespace +'/api/characters/999'
    And request jsonData
    When method PUT
    Then status 404
    * print response
    And match response.error == 'Character not found'
    And match response != null

  @id:3 @updateCharacter @invalidData400
  Scenario: T-API-MARVEL-003-CA03-Update character with invalid data 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_invalid_character.json')
    * path '/' + userNamespace +'/api/characters/1'
    And request jsonData
    When method PUT
    Then status 400
    * print response
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'

  @id:4 @updateCharacter @serverError500
  Scenario: T-API-MARVEL-003-CA04-Error interno del servidor 500 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_update_character.json')
    * set jsonData.name = 'ServerError'
    * path '/api/characters/null'
    And request jsonData
    When method PUT
    Then status 500
    And match response.error != null
    And match response.error == 'Internal server error'


