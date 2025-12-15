package config;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import util.ThreadPoolManager;

@WebListener
public class AppContextListener implements ServletContextListener {

 // 애플리케이션이 시작될 때 (Tomcat이 디플로이할 때)
 @Override
 public void contextInitialized(ServletContextEvent sce) {
     // 스레드 풀을 초기화하거나 사용할 준비를 합니다.
     System.out.println("RollingMoney: ThreadPoolManager 초기화 완료.");
 }

 // ★ 애플리케이션이 종료될 때 (Tomcat이 언디플로이할 때)
 @Override
 public void contextDestroyed(ServletContextEvent sce) {
     System.out.println("RollingMoney: ThreadPoolManager 종료 시작.");
     ThreadPoolManager.shutdown(); // ★ 안전한 종료 메서드 호출
     System.out.println("RollingMoney: ThreadPoolManager 종료 완료.");
 }
}