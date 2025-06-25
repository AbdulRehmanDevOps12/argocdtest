import java.io.*;
import java.sql.*;

public class StressTestVulnerableExample {

    // Hardcoded credentials (x3)
    private static final String DB_USER = "root";
    private static final String DB_PASS = "123456";
    private static final String API_KEY = "abcd-1234-secret";

    public static void main(String[] args) {

        // Magic numbers (x5)
        int timeout = 5000;
        int retryCount = 3;
        double tax = 0.18;
        int maxUsers = 1000;
        int minBalance = 50;

        // SQL Injection (x3)
        String username = "' OR 1=1 --";
        String query1 = "SELECT * FROM users WHERE username = '" + username + "'";
        String query2 = "DELETE FROM accounts WHERE id = '" + username + "'";
        String query3 = "UPDATE users SET role = 'admin' WHERE name = '" + username + "'";

        System.out.println(query1);
        System.out.println(query2);
        System.out.println(query3);

        // Null pointer risk (x5)
        String nullStr = null;
        if (nullStr.equals("test")) System.out.println("This will NPE");
        if (nullStr.contains("x")) System.out.println("This too");
        System.out.println(nullStr.length());
        System.out.println(nullStr.charAt(0));
        nullStr.toLowerCase();

        // Empty catch blocks (x10)
        try {} catch (Exception e) {}
        try {} catch (IOException e) {}
        try {} catch (SQLException e) {}
        try {} catch (NumberFormatException e) {}
        try {} catch (NullPointerException e) {}
        try {} catch (Throwable e) {}
        try {} catch (RuntimeException e) {}
        try {} catch (ClassCastException e) {}
        try {} catch (ArrayIndexOutOfBoundsException e) {}
        try {} catch (Exception e) {}

        // Duplicated blocks (x10)
        for (int i = 0; i < 5; i++) {
            System.out.println("Dup Block " + i);
        }
        for (int i = 0; i < 5; i++) {
            System.out.println("Dup Block " + i);
        }
        for (int i = 0; i < 5; i++) {
            System.out.println("Dup Block " + i);
        }
        for (int i = 0; i < 5; i++) {
            System.out.println("Dup Block " + i);
        }
        for (int i = 0; i < 5; i++) {
            System.out.println("Dup Block " + i);
        }
        for (int i = 0; i < 5; i++) {
            System.out.println("Dup Block " + i);
        }
        for (int i = 0; i < 5; i++) {
            System.out.println("Dup Block " + i);
        }
        for (int i = 0; i < 5; i++) {
            System.out.println("Dup Block " + i);
        }
        for (int i = 0; i < 5; i++) {
            System.out.println("Dup Block " + i);
        }
        for (int i = 0; i < 5; i++) {
            System.out.println("Dup Block " + i);
        }

        // Resource leaks (x5)
        try {
            FileWriter writer = new FileWriter("test.txt");
            writer.write("Data"); // not closing
        } catch (IOException ignored) {}

        try {
            FileInputStream fis = new FileInputStream("file.txt");
            fis.read(); // no close
        } catch (IOException ignored) {}

        try {
            BufferedReader br = new BufferedReader(new FileReader("input.txt"));
            br.readLine(); // no close
        } catch (IOException ignored) {}

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/test", DB_USER, DB_PASS);
            conn.createStatement().execute("SELECT 1"); // not closing
        } catch (SQLException ignored) {}

        try {
            PreparedStatement ps = DriverManager.getConnection("jdbc:mysql://localhost/test", DB_USER, DB_PASS)
                .prepareStatement("SELECT 1"); // no close
            ps.execute();
        } catch (SQLException ignored) {}

        // Code smells (x10)
        System.out.println("Error: " + new Exception("Something bad"));
        boolean flag = false; if (flag) System.out.println("ok");
        int x = 0; x = x + 1;
        String path = "C:\\\\path\\\\to\\\\file";
        int arr[] = new int[10]; for (int i = 0; i < arr.length; i++) {}
        if (true) { System.out.println("Always true"); }
        if (false) { System.out.println("Never runs"); }
        if (1 == 1) { System.out.println("Always true"); }
        int y = 100; // unused
        int z = 200; // unused

        // Unused variables (x5)
        String unused1 = "u1";
        String unused2 = "u2";
        int unused3 = 3;
        boolean unused4 = false;
        Object unused5 = new Object();
    }
}
