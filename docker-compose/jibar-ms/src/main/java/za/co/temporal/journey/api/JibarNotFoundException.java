
package za.co.temporal.journey.api;

public class JibarNotFoundException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public JibarNotFoundException(Long id) {
        super("Jibar id not found : " + id);
    }
}
