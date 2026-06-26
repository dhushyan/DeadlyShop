package util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * PasswordUtil — wraps jBCrypt for password hashing and verification.
 */
public class PasswordUtil {

    private static final int WORK_FACTOR = 12;

    /** Hash a plain-text password. */
    public static String hash(String plainText) {
        return BCrypt.hashpw(plainText, BCrypt.gensalt(WORK_FACTOR));
    }

    /** Return true if plainText matches the stored hash. */
    public static boolean verify(String plainText, String hashed) {
        if (plainText == null || hashed == null) return false;
        try {
            return BCrypt.checkpw(plainText, hashed);
        } catch (Exception e) {
            return false;
        }
    }
}
