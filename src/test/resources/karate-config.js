function fn() {
    var env = karate.env || 'local';

    // Base configuration for all environments
    var config = {
        port_marvel_characters_api: 'http://localhost:8080'
    };

    // URLs for all microservices (named with format port_service_name)
    config.port_marvel_characters_api = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';

    // Environment-specific configuration
    if (env == 'dev') {
        config.port_marvel_characters_api = 'http://bp-se-dev-cabcd9b246a5.herokuapp.com';
    } else if (env == 'qa') {
        config.port_marvel_characters_api = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';
    }

    return config;
}
