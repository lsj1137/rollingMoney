package util;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class ThreadPoolManager {
 private static final ExecutorService EXECUTOR_SERVICE = 
     Executors.newFixedThreadPool(10, r -> new Thread(r, "rollingMoney-Worker")); // 스레드 이름 지정

 private ThreadPoolManager() {
     // 싱글턴
 }

 public static ExecutorService getExecutorService() {
     return EXECUTOR_SERVICE;
 }

 // ★ 이 메서드가 핵심입니다.
 public static void shutdown() {
     EXECUTOR_SERVICE.shutdown(); // 새 작업은 거부하고 기존 작업은 완료될 때까지 기다림
     try {
         // 최대 5초 동안 모든 스레드가 종료되기를 기다립니다.
         if (!EXECUTOR_SERVICE.awaitTermination(5, TimeUnit.SECONDS)) {
             EXECUTOR_SERVICE.shutdownNow(); // 5초 후에도 종료되지 않으면 강제 종료
         }
     } catch (InterruptedException e) {
         EXECUTOR_SERVICE.shutdownNow();
         Thread.currentThread().interrupt();
     }
 }
}