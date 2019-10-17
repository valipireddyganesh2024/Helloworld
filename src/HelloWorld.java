import java.util.Scanner;

public class HelloWorld {
    public static void main(String[] args){
        // to read input from user
        Scanner sc=new Scanner(System.in);
        //to store user name
        String username;
        //reading and storing user name
        username=sc.nextLine();
        //displaying user name with hello
        // to display value of variable use variable name
        //System.out.println("Hello,"+ username);

        //now we will use funtions to display user hello world to user
        show(username);
        sc.close();



    }
    public static void show(String username){
        System.out.println("Hello Debtanu,"+ username);
    }
}
