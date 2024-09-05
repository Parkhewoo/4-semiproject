package com.kh.AttendPro.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.AttendPro.interceptor.AdminInterceptor;
import com.kh.AttendPro.interceptor.MemberInterceptor;
import com.kh.AttendPro.interceptor.QnaOwnerInterceptor;
import com.kh.AttendPro.interceptor.SysAdminInterceptor;
import com.kh.AttendPro.interceptor.WorkerInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer {

    @Autowired
    private MemberInterceptor memberInterceptor;

    @Autowired
    private SysAdminInterceptor sysAdminInterceptor;
    
    @Autowired
    private AdminInterceptor adminInterceptor;
    
    @Autowired
    private WorkerInterceptor workerInterceptor;
    
    @Autowired
    private QnaOwnerInterceptor qnaOwnerInterceptor;
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        
        registry.addInterceptor(sysAdminInterceptor)
                .addPathPatterns("/sysadmin/*");
          
        registry.addInterceptor(adminInterceptor)
        		.addPathPatterns("/admin/**")
        		.excludePathPatterns("/admin/login", "/admin/join"
        				,"/admin/findPw","/admin/findPwFinish", 
        				"/admin/resetPw", "/admin/resetPwComplete","/admin/logout");
    
        
        registry.addInterceptor(qnaOwnerInterceptor)
							.addPathPatterns( "/qna/**");
        
        registry.addInterceptor(workerInterceptor)
        .addPathPatterns( "/worker/**")
        .excludePathPatterns("/worker/login"
        		,"/worker/findPw","/worker/findPwFinish", 
        		"/worker/resetPw", "/worker/resetPwComplete");
   
        registry.addInterceptor(memberInterceptor)
        .addPathPatterns("/admin/login", "/worker/login");
        
    }
}
