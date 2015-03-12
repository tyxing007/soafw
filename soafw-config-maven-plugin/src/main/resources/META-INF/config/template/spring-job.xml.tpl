<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns="http://www.springframework.org/schema/beans" xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:context="http://www.springframework.org/schema/context" xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:mvc="http://www.springframework.org/schema/mvc" xmlns:dubbo="http://code.alibabatech.com/schema/dubbo"
	xmlns:cache="http://www.springframework.org/schema/cache"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
    http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
    http://www.springframework.org/schema/aop
    http://www.springframework.org/schema/aop/spring-aop-4.0.xsd
    http://www.springframework.org/schema/context
    http://www.springframework.org/schema/context/spring-context-4.0.xsd
    http://code.alibabatech.com/schema/dubbo
    http://code.alibabatech.com/schema/dubbo/dubbo.xsd"
	default-autowire="byName">
	
	<import resource="classpath*:/META-INF/config/spring/spring-rpc.xml"/>
	<import resource="classpath*:/META-INF/config/spring/spring-mq.xml"/>
	
	<bean id="kjtService$Config" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
		
		<property name="order" value="2" />
		<property name="ignoreUnresolvablePlaceholders" value="true" />
		<property name="locations">
			<list>
				<value>classpath*:/META-INF/config/local/dubbo.properties</value>
				<!--  
				<value>file:/config/dubbo.properties</value>
				-->
			</list>
		</property>
	</bean>
	
	<!-- 消费方应用名，用于计算依赖关系，不是匹配条件，不要与提供方一样 -->
	<dubbo:application name="kjt-#{artifactId}-job"/>
	 
    <!-- 使用zookeeper发现服务地址 --> 
    <dubbo:registry address="${#{artifactId}.registry.address}"/>
    
    <!-- 服务消费者定义 -->
    <dubbo:consumer timeout="${#{artifactId}.job.timeout}" init="true" check="false"/>
    
    <!-- 使用监控中心 -->
    <dubbo:monitor protocol="registry"/>
    
    <!--服务查询定义信息请在该备注以下添加-->
    
    <!--
	<dubbo:reference id="xxxService" interface="com.kjt.service.#{artifactId}.IXxxxService" />
	-->
</beans>