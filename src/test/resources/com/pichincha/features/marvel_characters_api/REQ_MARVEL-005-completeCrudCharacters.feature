@REQ_MARVEL-005 @HU005 @complete_crud_characters @marvel_characters_api @Agent2 @E2 @REQ_MARVEL-005-marvel_initiative
Feature: MARVEL-005 Complete CRUD for Marvel characters (API for complete operations)

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

  @id:1 @crud_complete @create_multiple_characters_201
  Scenario Outline: T-API-MARVEL-005-CA01-Create multiple characters <name> successfully 201 - karate
    * path '/' + userNamespace +'/api/characters'
    * def commonFunctions = karate.call('commonFunction.feature')
    * def character = { name: '<name>', alterego: '<alterego>', description: '<description>', powers: <powers> }
    * print 'Character to create: ' + character
    * set character.name = character.name + '-' + commonFunctions.randomString(5)
    And request character
    When method POST
    Then status 201
    And match response.id != null
    And match response.alterego != null
    And match response.description != null
    And match response.name contains character.name
    And match response.powers contains character.powers[0]
    And match response.powers == '#[2]'

    Examples:
      | name            | alterego     | description                | powers                               |
      | Iron Man        | Tony Stark   | Genius billionaire         | ["Armor", "Flight"]                  |
      | Spider-Man      | Peter Parker | Friendly neighborhood hero | ["Web-slinging", "Wall-crawling"]    |
      | Captain America | Steve Rogers | Super-soldier              | ["Super strength", "Shield mastery"] |

  @id:2 @crud_complete @complete_character_flow_200
  Scenario: T-API-MARVEL-005-CA02-Complete flow create-read-update-delete 200 - karate
    # Crear personaje
    * def commonFunctions = karate.call('commonFunction.feature')
    * path '/' + userNamespace +'/api/characters'
    * def newCharacter = read('classpath:data/marvel_characters_api/request_create_character.json')
    * set newCharacter.name = 'Character-' + commonFunctions.randomString(5)
    And request newCharacter
    When method POST
    Then status 201
    * def createdId = response.id

    # Consultar personaje creado
    * path '/' + userNamespace +'/api/characters/' + createdId
    When method GET
    Then status 200
    And match response.name == newCharacter.name
    And match response.id == createdId

    # Actualizar personaje
    * def updateCharacter = read('classpath:data/marvel_characters_api/request_update_character.json')
    * path '/' + userNamespace +'/api/characters/' + createdId
    And request updateCharacter
    When method PUT
    Then status 200
    And match response.name == updateCharacter.name
    And match response.id == createdId

    # Eliminar personaje
    * path '/' + userNamespace +'/api/characters/' + createdId
    When method DELETE
    Then status 204

    # Verificar que fue eliminado
    * path '/' + userNamespace +'/api/characters/' + createdId
    When method GET
    Then status 404
    And match response.error == 'Character not found'
