package ptithcm.util;

public class IDFix {
    public static String fix(String id, int length) {
        String result = id;
        while (result.length() < length) {
            result = result + " ";
        }
        return result;
    }
}
