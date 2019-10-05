
package za.co.temporal.journey.api;

public class FicaStatusNotFoundException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public FicaStatusNotFoundException(Long id) {
        super("FicaStatus id not found : " + id);
    }
}
