import com.intuit.karate.junit5.Karate;

class TestRunner {
    static {
        System.setProperty("karate.ssl", "true");
    }

    @Karate.Test
    Karate testMarvelApi() {
        return Karate.run("classpath:com/pichincha/features/marvel_characters_api")
                .tags("~@ignore");
    }

}
