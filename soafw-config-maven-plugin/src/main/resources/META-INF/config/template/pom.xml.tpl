<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>

	<groupId>com.kjt.service.#{artifactId}</groupId>
	<artifactId>#{artifactId}</artifactId>
	<version>1.0-SNAPSHOT</version>
	<packaging>pom</packaging>

	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		
		<memcached.version>2.0.1</memcached.version>
		<mybatis.version>3.2.8</mybatis.version>
		<mysql.version>5.1.26</mysql.version>
		<mail.version>1.4.1</mail.version>
		<jedis.version>2.6.2</jedis.version>
		<junit.version>4.7</junit.version>
		<json-lib.version>2.2.3</json-lib.version>
		<spring.version>4.0.7.RELEASE</spring.version>
		<hessian.version>4.0.7</hessian.version>
		<sqljdbc4.version>4.0</sqljdbc4.version>
		<slf4j.version>1.7.5</slf4j.version>
		<logback.version>1.1.2</logback.version>
		<servlet-api.version>2.5</servlet-api.version>
		<commons-lang.version>2.5</commons-lang.version>
		<commons-pool.version>1.5.4</commons-pool.version>
		<commons-dbcp.version>1.4</commons-dbcp.version>
		<commons-configuration.version>1.6</commons-configuration.version>
		<curator-framework.version>2.4.0</curator-framework.version>
		<curator-recipes.version>2.4.0</curator-recipes.version>
		<oscache.version>2.4</oscache.version>
		<guava.version>18.0</guava.version>
		<maven-compiler-plugin.version>2.4.2</maven-compiler-plugin.version>
		<validation-api.version>1.1.0.Final</validation-api.version>
		<aspectj.version>1.8.4</aspectj.version>
		<unirest-java.version>1.3.26</unirest-java.version>
		<jackson-databind.version>2.4.2</jackson-databind.version>
		
		<dubbo.version>2.5.3</dubbo.version>
		<zookeeper.version>3.4.6</zookeeper.version>
		<zkclient.version>0.4</zkclient.version>
		
		<soafw-common.version>0.0.1</soafw-common.version>

        <!-- 异常代码生成公共定义 -->
        <exception.enum.class></exception.enum.class>
        <exception.loadType>DB</exception.loadType>
        <exception.tableName>soafw_exception</exception.tableName>
        <exception.dburl>jdbc:mysql://192.168.1.103:3306/kjt_db</exception.dburl>
        <exception.dbuser>caixh</exception.dbuser>
        <exception.dbpwd>caixh123</exception.dbpwd>
        <exception.level></exception.level>
        <spId>1</spId>
        <!-- 异常代码生成公共定义 -->
	</properties>
	<modules>
		<module>#{artifactId}-common</module>
		<module>#{artifactId}-config</module>
		<module>#{artifactId}-cache</module>
		<module>#{artifactId}-dao</module>
		<module>#{artifactId}-domain</module>
		<module>#{artifactId}-service</module>
		<module>#{artifactId}-job</module>
		<module>#{artifactId}-rpc</module>
		<module>#{artifactId}-mq</module>
		<module>#{artifactId}-service-impl</module>
		<module>#{artifactId}-web</module>
	</modules>
	<dependencyManagement>
		<dependencies>
			<dependency>
	            <groupId>com.kjt.service.common</groupId>
	            <artifactId>soafw-common-util</artifactId>
	            <version>${soafw-common.version}</version>
	        </dependency>
	        <dependency>
	            <groupId>com.kjt.service.common</groupId>
	            <artifactId>soafw-common-config</artifactId>
	            <version>${soafw-common.version}</version>
	        </dependency>
	        <dependency>
	            <groupId>com.kjt.service.common</groupId>
	            <artifactId>soafw-common-cache</artifactId>
	            <version>${soafw-common.version}</version>
	        </dependency>
	        <dependency>
	            <groupId>com.kjt.service.common</groupId>
	            <artifactId>soafw-common-dao</artifactId>
	            <version>${soafw-common.version}</version>
	        </dependency>
	        <dependency>
	            <groupId>com.kjt.service.common</groupId>
	            <artifactId>soafw-common-mq</artifactId>
	            <version>${soafw-common.version}</version>
	        </dependency>
	        <dependency>
	            <groupId>com.kjt.service.common</groupId>
	            <artifactId>soafw-common-rpc</artifactId>
	            <version>${soafw-common.version}</version>
	        </dependency>
	        <dependency>
	            <groupId>com.kjt.service.common</groupId>
	            <artifactId>soafw-common-domain</artifactId>
	            <version>${soafw-common.version}</version>
	        </dependency>
	        <dependency>
	            <groupId>com.kjt.service.common</groupId>
	            <artifactId>soafw-common-service</artifactId>
	            <version>${soafw-common.version}</version>
	        </dependency>
	        <dependency>
	            <groupId>com.kjt.service.common</groupId>
	            <artifactId>soafw-common-job</artifactId>
	            <version>${soafw-common.version}</version>
	        </dependency>
	        <dependency>
	            <groupId>com.kjt.service.common</groupId>
	            <artifactId>soafw-common-service-impl</artifactId>
	            <version>${soafw-common.version}</version>
	        </dependency>
			<dependency>
				<groupId>com.kjt.service.common</groupId>
				<artifactId>soafw-common-web</artifactId>
				<version>${soafw-common.version}</version>
			</dependency>
			
			<dependency>
				<groupId>com.kjt.service.#{artifactId}</groupId>
				<artifactId>#{artifactId}-common</artifactId>
				<version>${project.version}</version>
			</dependency>
			<dependency>
				<groupId>com.kjt.service.#{artifactId}</groupId>
				<artifactId>#{artifactId}-config</artifactId>
				<version>${project.version}</version>
			</dependency>
			<dependency>
				<groupId>com.kjt.service.#{artifactId}</groupId>
				<artifactId>#{artifactId}-cache</artifactId>
				<version>${project.version}</version>
			</dependency>
			<dependency>
				<groupId>com.kjt.service.#{artifactId}</groupId>
				<artifactId>#{artifactId}-dao</artifactId>
				<version>${project.version}</version>
			</dependency>
			<dependency>
				<groupId>com.kjt.service.#{artifactId}</groupId>
				<artifactId>#{artifactId}-domain</artifactId>
				<version>${project.version}</version>
			</dependency>
			<dependency>
				<groupId>com.kjt.service.#{artifactId}</groupId>
				<artifactId>#{artifactId}-service</artifactId>
				<version>${project.version}</version>
			</dependency>
			<dependency>
				<groupId>com.kjt.service.#{artifactId}</groupId>
				<artifactId>#{artifactId}-rpc</artifactId>
				<version>${project.version}</version>
			</dependency>
			<dependency>
				<groupId>com.kjt.service.#{artifactId}</groupId>
				<artifactId>#{artifactId}-mq</artifactId>
				<version>${project.version}</version>
			</dependency>
			<dependency>
				<groupId>com.kjt.service.#{artifactId}</groupId>
				<artifactId>#{artifactId}-job</artifactId>
				<version>${project.version}</version>
			</dependency>
			<dependency>
				<groupId>com.kjt.service.#{artifactId}</groupId>
				<artifactId>#{artifactId}-service-impl</artifactId>
				<version>${project.version}</version>
			</dependency>
			<dependency>
				<artifactId>#{artifactId}-web</artifactId>
				<groupId>com.kjt.service.#{artifactId}</groupId>
				<version>${project.version}</version>
			</dependency>
			
			<dependency>
					<groupId>com.google.guava</groupId>
					<artifactId>guava</artifactId>
					<version>${guava.version}</version>
				</dependency>
				<dependency>
					<groupId>javax.servlet</groupId>
					<artifactId>servlet-api</artifactId>
					<version>${servlet-api.version}</version>
				</dependency>
	
				<dependency>
					<groupId>com.danga</groupId>
					<artifactId>memcached</artifactId>
					<version>${memcached.version}</version>
				</dependency>
	
				<dependency>
					<groupId>opensymphony</groupId>
					<artifactId>oscache</artifactId>
					<version>${oscache.version}</version>
				</dependency>
				<dependency>
					<groupId>redis.clients</groupId>
					<artifactId>jedis</artifactId>
					<version>${jedis.version}</version>
					<type>jar</type>
				</dependency>
	
				<dependency>
					<groupId>junit</groupId>
					<artifactId>junit</artifactId>
					<version>${junit.version}</version>
				</dependency>
	
				<dependency>
					<groupId>javax.mail</groupId>
					<artifactId>mail</artifactId>
					<version>${mail.version}</version>
				</dependency>
	
				<dependency>
					<groupId>org.mybatis</groupId>
					<artifactId>mybatis</artifactId>
					<version>${mybatis.version}</version>
				</dependency>
				<dependency>
					<groupId>mysql</groupId>
					<artifactId>mysql-connector-java</artifactId>
					<version>${mysql.version}</version>
				</dependency>
				<dependency>
					<groupId>com.microsoft.sqlserver</groupId>
					<artifactId>sqljdbc4</artifactId>
					<version>${sqljdbc4.version}</version>
				</dependency>
	
				<dependency>
					<groupId>commons-pool</groupId>
					<artifactId>commons-pool</artifactId>
					<version>${commons-pool.version}</version>
				</dependency>
				<dependency>
					<groupId>commons-dbcp</groupId>
					<artifactId>commons-dbcp</artifactId>
					<version>${commons-dbcp.version}</version>
				</dependency>
				<dependency>
					<groupId>commons-lang</groupId>
					<artifactId>commons-lang</artifactId>
					<version>${commons-lang.version}</version>
				</dependency>
				<dependency>
					<groupId>commons-configuration</groupId>
					<artifactId>commons-configuration</artifactId>
					<version>${commons-configuration.version}</version>
				</dependency>
	
				<dependency>
					<groupId>net.sf.json-lib</groupId>
					<artifactId>json-lib</artifactId>
					<version>${json-lib.version}</version>
				</dependency>
				<dependency>
					<groupId>org.slf4j</groupId>
					<artifactId>slf4j-api</artifactId>
					<version>${slf4j.version}</version>
				</dependency>
				<dependency>
					<groupId>org.slf4j</groupId>
					<artifactId>jcl-over-slf4j</artifactId>
					<version>${slf4j.version}</version>
				</dependency>
				<dependency>
					<groupId>org.slf4j</groupId>
					<artifactId>slf4j-log4j12</artifactId>
					<version>${slf4j.version}</version>
				</dependency>
				<dependency>
					<groupId>ch.qos.logback</groupId>
					<artifactId>logback-classic</artifactId>
					<version>${logback.version}</version>
				</dependency>
				<dependency>
					<groupId>ch.qos.logback</groupId>
					<artifactId>logback-core</artifactId>
					<version>${logback.version}</version>
				</dependency>
				<dependency>
					<groupId>org.logback-extensions</groupId>
					<artifactId>logback-ext-spring</artifactId>
					<version>0.1.2</version>
					<scope>runtime</scope>
				</dependency>
				<dependency>
					<groupId>org.springframework</groupId>
					<artifactId>spring-context</artifactId>
					<version>${spring.version}</version>
				</dependency>
				<dependency>
					<groupId>com.caucho</groupId>
					<artifactId>hessian</artifactId>
					<version>${hessian.version}</version>
				</dependency>
				<dependency>
					<groupId>org.springframework</groupId>
					<artifactId>spring-context-support</artifactId>
					<version>${spring.version}</version>
				</dependency>
				<dependency>
					<groupId>org.springframework</groupId>
					<artifactId>spring-webmvc</artifactId>
					<version>${spring.version}</version>
				</dependency>
				<dependency>
					<groupId>org.springframework</groupId>
					<artifactId>spring-web</artifactId>
					<version>${spring.version}</version>
				</dependency>
				<dependency>
					<groupId>org.springframework</groupId>
					<artifactId>spring-core</artifactId>
					<version>${spring.version}</version>
				</dependency>
				<dependency>
					<groupId>org.springframework</groupId>
					<artifactId>spring-test</artifactId>
					<version>${spring.version}</version>
				</dependency>
				<dependency>
					<groupId>org.springframework</groupId>
					<artifactId>spring-jdbc</artifactId>
					<version>${spring.version}</version>
				</dependency>
				<dependency>
					<groupId>org.apache.curator</groupId>
					<artifactId>curator-framework</artifactId>
					<version>${curator-framework.version}</version>
				</dependency>
				<dependency>
					<groupId>org.apache.curator</groupId>
					<artifactId>curator-recipes</artifactId>
					<version>${curator-recipes.version}</version>
				</dependency>
				<dependency>
					<groupId>javax.validation</groupId>
					<artifactId>validation-api</artifactId>
					<version>${validation-api.version}</version>
				</dependency>
				<dependency>
					<groupId>org.aspectj</groupId>
					<artifactId>aspectjrt</artifactId>
					<version>${aspectj.version}</version>
				</dependency>
				<dependency>
					<groupId>org.aspectj</groupId>
					<artifactId>aspectjweaver</artifactId>
					<version>${aspectj.version}</version>
				</dependency>
				<dependency>
					<groupId>com.mashape.unirest</groupId>
					<artifactId>unirest-java</artifactId>
					<version>${unirest-java.version}</version>
				</dependency>
				<dependency>
					<groupId>com.fasterxml.jackson.core</groupId>
					<artifactId>jackson-databind</artifactId>
					<version>${jackson-databind.version}</version>
				</dependency>
				<!-- dubbo -->
				<dependency>
					<groupId>com.alibaba</groupId>
					<artifactId>dubbo</artifactId>
					<version>${dubbo.version}</version>
					<exclusions>
						<exclusion>
							<groupId>org.springframework</groupId>
							<artifactId>spring</artifactId>
						</exclusion>
						<!-- 指定版本的netty -->
						<exclusion>
							<groupId>io.netty</groupId>
							<artifactId>netty</artifactId>
						</exclusion>
					</exclusions>
				</dependency>
				
				<!-- zookeeper -->
				<dependency>
					<groupId>org.apache.zookeeper</groupId>
					<artifactId>zookeeper</artifactId>
					<version>${zookeeper.version}</version>
					<exclusions>
						<exclusion>
							<groupId>javax.mail</groupId>
							<artifactId>mail</artifactId>
						</exclusion>
					</exclusions>
				</dependency>
		
				<!-- zkClient -->
				<dependency>
					<groupId>com.101tec</groupId>
					<artifactId>zkclient</artifactId>
					<version>${zkclient.version}</version>
				</dependency>
		</dependencies>
	</dependencyManagement>
	<build>
		<defaultGoal>package</defaultGoal>
		<plugins>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-compiler-plugin</artifactId>
				<configuration>
					<source>1.7</source>
					<target>1.7</target>
					<encoding>UTF-8</encoding>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-surefire-plugin</artifactId>
				<version>${maven-compiler-plugin.version}</version>
				<configuration>
					<skipTests>true</skipTests>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-source-plugin</artifactId>
				<executions>
					<execution>
						<id>attach-sources</id>
						<goals>
							<goal>jar</goal>
						</goals>
					</execution>
				</executions>
			</plugin>
            <!-- 异常代码生成插件 -->
            <!-- 
            <plugin>
                <groupId>com.kjt.service.common</groupId>
                <artifactId>exception-generator</artifactId>
                <version>0.0.1-SNAPSHOT</version>
                <configuration>
                    <exceptionEnumClass>${exception.enum.class}</exceptionEnumClass>
                    <dbpwd>${exception.dbpwd}</dbpwd>
                    <dburl>${exception.dburl}</dburl>
                    <dbuser>${exception.dbuser}</dbuser>
                    <tableName>${exception.tableName}</tableName>
                    <loadType>${exception.loadType}</loadType>
                    <exceptionLevel>${exception.level}</exceptionLevel>
                </configuration>
                <executions>
                    <execution>
                        <id>exception-generator</id>
                        <goals>
                            <goal>gen</goal>
                        </goals>
                        <phase>generate-sources</phase>
                    </execution>
                </executions>
            </plugin>
            -->
            <!-- 单元测试框架代码生成插件 -->
            <plugin>
				<groupId>com.kjt.service.common</groupId>
				<artifactId>soafw-test-maven-plugin</artifactId>
				<executions>
					<execution>
						<id>soafw-test</id>
						<goals>
							<goal>gen</goal>
						</goals>
						<phase>package</phase>
					</execution>
				</executions>
			</plugin>
		</plugins>
	</build>
</project>
