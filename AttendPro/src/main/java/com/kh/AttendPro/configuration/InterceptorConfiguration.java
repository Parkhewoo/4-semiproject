package com.kh.AttendPro.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.AttendPro.interceptor.AdminInterceptor;
import com.kh.AttendPro.interceptor.MemberInterceptor;
import com.kh.AttendPro.interceptor.SysAdminInterceptor;
import com.kh.AttendPro.interceptor.WorkerInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer {

    @Autowired
    private SysAdminInterceptor sysAdminInterceptor;
    
    @Autowired
    private WorkerInterceptor workerInterceptor;
    
    @Autowired
    private AdminInterceptor adminInterceptor;
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        
        registry.addInterceptor(adminInterceptor)
                .addPathPatterns("/admin/company/set",
                						"/admin/company/insert",
                						"/admin/worker/add",
                						"/admin/worker/list",
                						"/admin/worker/edit",
                						"/admin/worker/delete",
                						"/admin/worker/addfinish",
                						"/admin/password",
                						"/admin/mypage",
                						"/admin/change",
                						"/qna/adminList"
                						);
               
          registry.addInterceptor(workerInterceptor)
                  .addPathPatterns(
                		  "/worker/mypage",
                		  "/worker/attendance",
                		  "/worker/edit",
                		  "/worker/check"
                		  );
          
          registry.addInterceptor(sysAdminInterceptor)
          			.addPathPatterns("/sysadmin/**",
          							 "/qna/list",
          							 "/notice/write",
          							 "/notice/edit"
          							);
          			
    }
}
