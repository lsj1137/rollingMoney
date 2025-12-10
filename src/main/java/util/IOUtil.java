package util;

import java.util.Scanner;

public class IOUtil {
	static Scanner sc = new Scanner(System.in);
	
	// 문자 입력
	public static String inputStr() {
        try {
            String s = sc.nextLine();
            return s;
        } catch (Exception e) {
            return null; // 에러 발생 시 null 리턴
        }
	}
	
	// 숫자 입력
    public static int inputInt() {
        try {
            int num = sc.nextInt();
            sc.nextLine(); // 버퍼 비우기
            return num;
        } catch (Exception e) {
            sc.nextLine(); // 버퍼 비우기
            return -1; // 에러 발생 시 -1 리턴
        }
    }
}
