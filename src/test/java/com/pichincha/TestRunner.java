package com.pichincha;

import com.intuit.karate.junit5.Karate;

class TestRunner {
    static {
        System.setProperty("karate.ssl", "true");
    }

    @Karate.Test
    Karate testMarvelCharactersApi() {
        return Karate.run("classpath:com/pichincha/features/marvel_characters_api")
                .tags("~@ignore");
    }

    @Karate.Test
    Karate testObtenerPersonajes() {
        return Karate.run("classpath:com/pichincha/features/marvel_characters_api/obtenerPersonajes.feature");
    }

    @Karate.Test
    Karate testCrearPersonajes() {
        return Karate.run("classpath:com/pichincha/features/marvel_characters_api/crearPersonajes.feature");
    }

    @Karate.Test
    Karate testActualizarPersonajes() {
        return Karate.run("classpath:com/pichincha/features/marvel_characters_api/actualizarPersonajes.feature");
    }

    @Karate.Test
    Karate testEliminarPersonajes() {
        return Karate.run("classpath:com/pichincha/features/marvel_characters_api/eliminarPersonajes.feature");
    }
}
