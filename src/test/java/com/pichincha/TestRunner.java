package com.pichincha;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

class TestRunner {

    @BeforeAll
    static void beforeAll() {
        System.setProperty("karate.ssl", "true");
    }

    @AfterAll
    static void afterAll() {
    }

    @Test
    void testMarvelCharactersApi() {
        // Ejecutar tests en paralelo con 4 threads
        Results results = Runner.path("classpath:com/pichincha/features")
                .tags("~@ignore")
                .threads(4)
                .parallel(4);

        // Opcional: assert para verificar que no haya fallas
        if (results.getFailCount() > 0) {
            throw new RuntimeException("Hay escenarios fallidos: " + results.getFailCount());
        }
    }


}
