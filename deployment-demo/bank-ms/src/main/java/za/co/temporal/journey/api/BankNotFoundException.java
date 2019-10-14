
package za.co.temporal.journey.api;

public class BankNotFoundException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public BankNotFoundException(Long id) {
        super("Bank id not found : " + id);
    }
}
