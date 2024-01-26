# Liberty InstantOn spring-boot-starter-security reproducer
Hi 🙂

I found an article about Liberty InstantOn feature, and that you can combine this with spring boot. I found only the article from the liberty blog https://openliberty.io/blog/2023/09/26/spring-boot-3-instant-on.html. If I add `spring-boot-starter-security`  the applications starts with an exception (during check pointing and application startup). I made a reproducer, based on the example code of the blog post [https://github.com/TetrisIQ/LibertyInstantOnSpringBoot/](https://github.com/TetrisIQ/LibertyInstantOnSpringBoot/tree/main/finish). The app was build with Java 17

```java
openjdk 17.0.9 2023-10-17
OpenJDK Runtime Environment Temurin-17.0.9+9 (build 17.0.9+9)
OpenJDK 64-Bit Server VM Temurin-17.0.9+9 (build 17.0.9+9, mixed mode, sharing)
```

This is the stack trace I got: 

```java
org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'conversionServicePostProcessor' defined in class path resource [org/springframework/security/config/annotation/web/configuration/WebSecurityConfiguration.class]: Failed to instantiate [org.springframework.beans.factory.config.BeanFactoryPostProcessor]: Factory method 'conversionServicePostProcessor' threw exception with message: java.security.NoSuchAlgorithmException: RSA KeyFactory not available
        at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:651) ~[spring-beans-6.1.3.jar:6.1.3]
        at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:485) ~[spring-beans-6.1.3.jar:6.1.3]
        at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1334) ~[spring-beans-6.1.3.jar:6.1.3]
        at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1164) ~[spring-beans-6.1.3.jar:6.1.3]
        at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:561) ~[spring-beans-6.1.3.jar:6.1.3]
        at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:521) ~[spring-beans-6.1.3.jar:6.1.3]
        at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:325) ~[spring-beans-6.1.3.jar:6.1.3]
        at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[spring-beans-6.1.3.jar:6.1.3]
        at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:323) ~[spring-beans-6.1.3.jar:6.1.3]
        at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:204) ~[spring-beans-6.1.3.jar:6.1.3]
        at org.springframework.context.support.PostProcessorRegistrationDelegate.invokeBeanFactoryPostProcessors(PostProcessorRegistrationDelegate.java:202) ~[spring-context-6.1.3.jar:6.1.3]
        at org.springframework.context.support.AbstractApplicationContext.invokeBeanFactoryPostProcessors(AbstractApplicationContext.java:788) ~[spring-context-6.1.3.jar:6.1.3]
        at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:606) ~[spring-context-6.1.3.jar:6.1.3]
        at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.refresh(ServletWebServerApplicationContext.java:146) ~[spring-boot-3.2.2.jar:3.2.2]
        at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:754) ~[spring-boot-3.2.2.jar:3.2.2]
        at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:456) ~[spring-boot-3.2.2.jar:3.2.2]
        at org.springframework.boot.SpringApplication.run(SpringApplication.java:334) ~[spring-boot-3.2.2.jar:3.2.2]
        at org.springframework.boot.SpringApplication.run(SpringApplication.java:1354) ~[spring-boot-3.2.2.jar:3.2.2]
        at org.springframework.boot.SpringApplication.run(SpringApplication.java:1343) ~[spring-boot-3.2.2.jar:3.2.2]
        at hello.Application.main(Application.java:15) ~[thin-guide-spring-boot-0.1.0.jar:na]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:na]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77) ~[na:na]
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:na]
        at java.base/java.lang.reflect.Method.invoke(Method.java:568) ~[na:na]
        at com.ibm.ws.app.manager.springboot.internal.SpringBootRuntimeContainer.lambda$invokeSpringMain$6(SpringBootRuntimeContainer.java:139) ~[na:na]
        at com.ibm.ws.threading.internal.ExecutorServiceImpl$RunnableWrapper.run(ExecutorServiceImpl.java:280) ~[na:na]
        at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1136) ~[na:na]
        at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:635) ~[na:na]
        at java.base/java.lang.Thread.run(Thread.java:857) ~[na:na]
Caused by: org.springframework.beans.BeanInstantiationException: Failed to instantiate [org.springframework.beans.factory.config.BeanFactoryPostProcessor]: Factory method 'conversionServicePostProcessor' threw exception with message: java.security.NoSuchAlgorithmException: RSA KeyFactory not available
        at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:177) ~[spring-beans-6.1.3.jar:6.1.3]
        at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:647) ~[spring-beans-6.1.3.jar:6.1.3]
        ... 28 common frames omitted
Caused by: java.lang.IllegalStateException: java.security.NoSuchAlgorithmException: RSA KeyFactory not available
        at org.springframework.security.converter.RsaKeyConverters.rsaFactory(RsaKeyConverters.java:148) ~[spring-security-core-6.2.1.jar:6.2.1]
        at org.springframework.security.converter.RsaKeyConverters.x509(RsaKeyConverters.java:114) ~[spring-security-core-6.2.1.jar:6.2.1]
        at org.springframework.security.config.crypto.RsaKeyConversionServicePostProcessor.<init>(RsaKeyConversionServicePostProcessor.java:54) ~[spring-security-config-6.2.1.jar:6.2.1]
        at org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration.conversionServicePostProcessor(WebSecurityConfiguration.java:185) ~[spring-security-config-6.2.1.jar:6.2.1]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:na]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77) ~[na:na]
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:na]
        at java.base/java.lang.reflect.Method.invoke(Method.java:568) ~[na:na]
        at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:140) ~[spring-beans-6.1.3.jar:6.1.3]
        ... 29 common frames omitted
Caused by: java.security.NoSuchAlgorithmException: RSA KeyFactory not available
        at java.base/java.security.KeyFactory.<init>(KeyFactory.java:138) ~[na:na]
        at java.base/java.security.KeyFactory.getInstance(KeyFactory.java:183) ~[na:na]
        at org.springframework.security.converter.RsaKeyConverters.rsaFactory(RsaKeyConverters.java:145) ~[spring-security-core-6.2.1.jar:6.2.1]
        ... 37 common frames omitted
```
