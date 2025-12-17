# MyBatis 源码分析

## 1. 概述

### 1.1 什么是 MyBatis
MyBatis 是一款优秀的持久层框架，它支持定制化 SQL、存储过程以及高级映射。MyBatis 避免了几乎所有的 JDBC 代码和手动设置参数以及获取结果集。MyBatis 可以使用简单的 XML 或注解来配置和映射原生类型、接口和 Java 的 POJO（Plain Old Java Objects，普通老式 Java 对象）为数据库中的记录。

### 1.2 MyBatis 的优势
- **灵活的 SQL 编写**：允许开发者编写原生 SQL，而不是像 Hibernate 那样使用 HQL
- **简单易学**：学习曲线平缓，容易上手
- **高性能**：直接使用 SQL，减少了 ORM 框架的开销
- **良好的集成性**：可以与 Spring 等框架无缝集成
- **强大的映射能力**：支持复杂的结果集映射
- **插件机制**：允许扩展 MyBatis 的功能

### 1.3 MyBatis 与 Hibernate 的对比

| 特性 | MyBatis | Hibernate |
|------|---------|-----------|
| SQL 控制 | 完全控制，可编写原生 SQL | 自动生成 SQL，HQL 抽象 |
| 学习曲线 | 较平缓，容易上手 | 较陡，需要理解 ORM 概念 |
| 性能 | 高性能，直接使用 SQL | 性能较好，但有 ORM 开销 |
| 灵活性 | 非常灵活，适合复杂查询 | 相对固定，适合简单查询 |
| 配置复杂度 | 中等，需要配置 SQL 和映射 | 复杂，需要配置大量映射关系 |
| 适用场景 | 复杂查询、需要优化 SQL 的场景 | 简单 CRUD、快速开发的场景 |

## 2. 核心组件

### 2.1 SqlSessionFactory
SqlSessionFactory 是 MyBatis 的核心工厂类，用于创建 SqlSession 实例。它是线程安全的，通常在应用启动时创建，应用关闭时销毁。

### 2.2 SqlSession
SqlSession 是 MyBatis 的核心接口，用于执行 SQL 语句、获取 Mapper 接口实例等。它不是线程安全的，每个线程应该使用独立的 SqlSession 实例。

### 2.3 Mapper 接口
Mapper 接口是 MyBatis 的核心概念之一，它是一个普通的 Java 接口，通过 XML 或注解配置 SQL 语句。MyBatis 会为 Mapper 接口生成动态代理实现。

### 2.4 Executor
Executor 是 MyBatis 的执行器，负责执行 SQL 语句、管理事务等。它有三种实现：
- `SimpleExecutor`：简单执行器，每次执行 SQL 都会创建新的 Statement
- `ReuseExecutor`：重用执行器，重用 Statement
- `BatchExecutor`：批处理执行器，用于批量操作

### 2.5 StatementHandler
StatementHandler 负责处理 JDBC Statement 的创建、参数设置、SQL 执行等操作。

### 2.6 ParameterHandler
ParameterHandler 负责处理 SQL 参数的设置。

### 2.7 ResultSetHandler
ResultSetHandler 负责处理 SQL 查询结果的映射。

### 2.8 TypeHandler
TypeHandler 负责 Java 类型与数据库类型之间的转换。

### 2.9 Configuration
Configuration 是 MyBatis 的配置对象，包含了 MyBatis 的所有配置信息。

## 3. 工作原理

### 3.1 初始化流程

1. **加载配置文件**：MyBatis 加载 XML 配置文件或 Java 配置类
2. **解析配置**：解析配置文件，创建 Configuration 对象
3. **创建 SqlSessionFactory**：使用 Configuration 对象创建 SqlSessionFactory
4. **创建 SqlSession**：使用 SqlSessionFactory 创建 SqlSession
5. **获取 Mapper 接口**：使用 SqlSession 获取 Mapper 接口实例

### 3.2 SQL 执行流程

1. **调用 Mapper 方法**：应用程序调用 Mapper 接口方法
2. **动态代理处理**：MyBatis 动态代理拦截 Mapper 方法调用
3. **获取 MappedStatement**：根据 Mapper 方法获取对应的 MappedStatement
4. **创建 Executor**：创建或获取 Executor 实例
5. **执行 SQL**：Executor 调用 StatementHandler 执行 SQL
6. **处理结果集**：ResultSetHandler 将结果集映射为 Java 对象
7. **返回结果**：将映射后的结果返回给应用程序

## 4. 基本使用

### 4.1 项目创建

使用 Spring Initializr 创建一个 Spring Boot 项目，添加以下依赖：
- MyBatis Framework
- Spring Boot Starter JDBC
- H2 Database（或其他关系型数据库驱动）

### 4.2 配置 MyBatis

**application.yml**：
```yaml
spring:
  datasource:
    url: jdbc:h2:mem:testdb
    username: sa
    password: 
    driver-class-name: org.h2.Driver
  h2:
    console:
      enabled: true

mybatis:
  mapper-locations: classpath:mappers/*.xml  # Mapper XML 文件位置
  type-aliases-package: com.example.mybatis.entity  # 实体类包路径
  configuration:
    map-underscore-to-camel-case: true  # 下划线转驼峰命名
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl  # 日志实现
```

### 4.3 定义实体类

```java
public class User {
    private Long id;
    private String name;
    private Integer age;
    private String email;
    private LocalDateTime createdAt;
    
    // 构造方法、getter 和 setter 方法
    // ...
}
```

### 4.4 定义 Mapper 接口

```java
@Mapper
public interface UserMapper {
    // 使用注解方式定义 SQL
    @Select("SELECT * FROM users WHERE id = #{id}")
    User findById(Long id);
    
    // 使用 XML 方式定义 SQL
    List<User> findAll();
    
    @Insert("INSERT INTO users(name, age, email, created_at) VALUES(#{name}, #{age}, #{email}, #{createdAt})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(User user);
    
    @Update("UPDATE users SET name = #{name}, age = #{age}, email = #{email} WHERE id = #{id}")
    int update(User user);
    
    @Delete("DELETE FROM users WHERE id = #{id}")
    int delete(Long id);
}
```

### 4.5 定义 Mapper XML 文件

**resources/mappers/UserMapper.xml**：
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.example.mybatis.mapper.UserMapper">
    <select id="findAll" resultType="User">
        SELECT * FROM users
    </select>
    
    <select id="findByName" resultType="User">
        SELECT * FROM users WHERE name = #{name}
    </select>
    
    <select id="findByAgeGreaterThan" resultType="User">
        SELECT * FROM users WHERE age > #{age}
    </select>
</mapper>
```

### 4.6 业务层实现

```java
@Service
public class UserService {
    private final UserMapper userMapper;
    
    public UserService(UserMapper userMapper) {
        this.userMapper = userMapper;
    }
    
    public User findById(Long id) {
        return userMapper.findById(id);
    }
    
    public List<User> findAll() {
        return userMapper.findAll();
    }
    
    public User insert(User user) {
        user.setCreatedAt(LocalDateTime.now());
        userMapper.insert(user);
        return user;
    }
    
    public int update(User user) {
        return userMapper.update(user);
    }
    
    public int delete(Long id) {
        return userMapper.delete(id);
    }
}
```

## 5. 源码分析

### 5.1 MyBatis 初始化流程

#### 5.1.1 SqlSessionFactory 的创建

SqlSessionFactory 是 MyBatis 的核心工厂类，用于创建 SqlSession 实例。它的创建过程如下：

1. **加载配置文件**：使用 `SqlSessionFactoryBuilder` 加载 XML 配置文件或 Java 配置类
2. **解析配置**：解析配置文件，创建 `Configuration` 对象
3. **构建 SqlSessionFactory**：使用 `Configuration` 对象构建 `SqlSessionFactory` 实例

**源码分析**：

```java
// SqlSessionFactoryBuilder.build() 方法
public SqlSessionFactory build(InputStream inputStream, String environment, Properties properties) {
  try {
    // 创建 XML 配置构建器
    XMLConfigBuilder parser = new XMLConfigBuilder(inputStream, environment, properties);
    // 解析配置文件，返回 Configuration 对象
    Configuration config = parser.parse();
    // 构建 SqlSessionFactory
    return build(config);
  } catch (Exception e) {
    throw ExceptionFactory.wrapException("Error building SqlSession.", e);
  } finally {
    ErrorContext.instance().reset();
    try {
      inputStream.close();
    } catch (IOException e) {
      // Intentionally ignore. Prefer previous error.
    }
  }
}

// SqlSessionFactoryBuilder.build() 方法（重载）
public SqlSessionFactory build(Configuration config) {
  // 创建 DefaultSqlSessionFactory 实例
  return new DefaultSqlSessionFactory(config);
}
```

#### 5.1.2 Configuration 的初始化

`Configuration` 是 MyBatis 的配置对象，包含了 MyBatis 的所有配置信息。它的初始化过程如下：

1. **设置默认配置**：设置 MyBatis 的默认配置，如默认的 Executor 类型、默认的 StatementHandler 类型等
2. **加载映射文件**：加载 Mapper XML 文件，解析 SQL 语句和映射关系
3. **注册 Mapper 接口**：注册 Mapper 接口，生成动态代理实现

**源码分析**：

```java
// XMLConfigBuilder.parse() 方法
public Configuration parse() {
  if (parsed) {
    throw new BuilderException("Each XMLConfigBuilder can only be used once.");
  }
  parsed = true;
  // 解析配置文件的根节点 <configuration>
  parseConfiguration(parser.evalNode("/configuration"));
  return configuration;
}

// XMLConfigBuilder.parseConfiguration() 方法
private void parseConfiguration(XNode root) {
  try {
    // 解析 properties 节点
    propertiesElement(root.evalNode("properties"));
    // 解析 settings 节点
    Properties settings = settingsAsProperties(root.evalNode("settings"));
    // 加载自定义 VFS 实现
    loadCustomVfs(settings);
    // 解析 typeAliases 节点
    typeAliasesElement(root.evalNode("typeAliases"));
    // 解析 plugins 节点
    pluginElement(root.evalNode("plugins"));
    // 解析 objectFactory 节点
    objectFactoryElement(root.evalNode("objectFactory"));
    // 解析 objectWrapperFactory 节点
    objectWrapperFactoryElement(root.evalNode("objectWrapperFactory"));
    // 解析 reflectorFactory 节点
    reflectorFactoryElement(root.evalNode("reflectorFactory"));
    // 设置 settings 到 Configuration
    settingsElement(settings);
    // 解析 environments 节点
    environmentsElement(root.evalNode("environments"));
    // 解析 databaseIdProvider 节点
    databaseIdProviderElement(root.evalNode("databaseIdProvider"));
    // 解析 typeHandlers 节点
    typeHandlerElement(root.evalNode("typeHandlers"));
    // 解析 mappers 节点（重点）
    mapperElement(root.evalNode("mappers"));
  } catch (Exception e) {
    throw new BuilderException("Error parsing SQL Mapper Configuration. Cause: " + e, e);
  }
}
```

### 5.2 SQL 执行流程

#### 5.2.1 SqlSession 的创建

SqlSession 是 MyBatis 的核心接口，用于执行 SQL 语句。它的创建过程如下：

1. **获取 SqlSessionFactory**：从 Spring 容器中获取 SqlSessionFactory 实例
2. **创建 SqlSession**：调用 `SqlSessionFactory.openSession()` 方法创建 SqlSession 实例
3. **绑定 SqlSession**：将 SqlSession 绑定到当前线程（如果使用了 Spring 集成）

**源码分析**：

```java
// DefaultSqlSessionFactory.openSession() 方法
public SqlSession openSession() {
  // 使用默认的事务隔离级别和执行器类型
  return openSessionFromDataSource(configuration.getDefaultExecutorType(), null, false);
}

// DefaultSqlSessionFactory.openSessionFromDataSource() 方法
private SqlSession openSessionFromDataSource(ExecutorType execType, TransactionIsolationLevel level, boolean autoCommit) {
  Transaction tx = null;
  try {
    // 获取 Environment 对象
    final Environment environment = configuration.getEnvironment();
    // 获取 TransactionFactory
    final TransactionFactory transactionFactory = getTransactionFactoryFromEnvironment(environment);
    // 创建 Transaction
    tx = transactionFactory.newTransaction(environment.getDataSource(), level, autoCommit);
    // 创建 Executor
    final Executor executor = configuration.newExecutor(tx, execType);
    // 创建 DefaultSqlSession
    return new DefaultSqlSession(configuration, executor, autoCommit);
  } catch (Exception e) {
    // 如果创建失败，关闭事务
    closeTransaction(tx); // may have fetched a connection so lets call close()
    throw ExceptionFactory.wrapException("Error opening session.  Cause: " + e, e);
  } finally {
    // 重置 ErrorContext
    ErrorContext.instance().reset();
  }
}
```

#### 5.2.2 Mapper 代理的创建

MyBatis 会为 Mapper 接口生成动态代理实现，代理类会拦截 Mapper 方法调用，执行对应的 SQL 语句。

**源码分析**：

```java
// MapperProxyFactory.newInstance() 方法
public T newInstance(SqlSession sqlSession) {
  // 创建 MapperProxy 对象
  final MapperProxy<T> mapperProxy = new MapperProxy<>(sqlSession, mapperInterface, methodCache);
  // 使用 JDK 动态代理创建 Mapper 接口实例
  return newInstance(mapperProxy);
}

// MapperProxyFactory.newInstance() 方法（重载）
protected T newInstance(MapperProxy<T> mapperProxy) {
  // 使用 JDK 动态代理创建实例
  return (T) Proxy.newProxyInstance(mapperInterface.getClassLoader(), new Class[] { mapperInterface }, mapperProxy);
}

// MapperProxy.invoke() 方法（JDK 动态代理的 invoke 方法）
public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
  try {
    // 如果是 Object 类的方法，直接调用
    if (Object.class.equals(method.getDeclaringClass())) {
      return method.invoke(this, args);
    } else {
      // 否则，调用 MapperMethod.execute() 方法
      return cachedInvoker(method).invoke(proxy, method, args, sqlSession);
    }
  } catch (Throwable t) {
    throw ExceptionUtil.unwrapThrowable(t);
  }
}
```

#### 5.2.3 SQL 执行过程

SQL 执行过程是 MyBatis 的核心流程，包括参数处理、SQL 执行、结果集映射等步骤。

**源码分析**：

```java
// MapperMethod.execute() 方法
public Object execute(SqlSession sqlSession, Object[] args) {
  Object result;
  // 根据 SQL 类型执行不同的方法
  switch (command.getType()) {
    case INSERT:
      { // 处理插入操作
        Object param = method.convertArgsToSqlCommandParam(args);
        result = rowCountResult(sqlSession.insert(command.getName(), param));
        break;
      }
    case UPDATE:
      { // 处理更新操作
        Object param = method.convertArgsToSqlCommandParam(args);
        result = rowCountResult(sqlSession.update(command.getName(), param));
        break;
      }
    case DELETE:
      { // 处理删除操作
        Object param = method.convertArgsToSqlCommandParam(args);
        result = rowCountResult(sqlSession.delete(command.getName(), param));
        break;
      }
    case SELECT:
      if (method.returnsVoid() && method.hasResultHandler()) {
        // 处理带 ResultHandler 的查询
        executeWithResultHandler(sqlSession, args);
        result = null;
      } else if (method.returnsMany()) {
        // 处理返回多个结果的查询
        result = executeForMany(sqlSession, args);
      } else if (method.returnsMap()) {
        // 处理返回 Map 的查询
        result = executeForMap(sqlSession, args);
      } else if (method.returnsCursor()) {
        // 处理返回 Cursor 的查询
        result = executeForCursor(sqlSession, args);
      } else {
        // 处理返回单个结果的查询
        Object param = method.convertArgsToSqlCommandParam(args);
        result = sqlSession.selectOne(command.getName(), param);
        if (method.returnsOptional() && (result == null || !method.getReturnType().equals(result.getClass()))) {
          result = Optional.ofNullable(result);
        }
      }
      break;
    case FLUSH:
      // 处理 flush 操作
      result = sqlSession.flushStatements();
      break;
    default:
      throw new BindingException("Unknown execution method for: " + command.getName());
  }
  if (result == null && method.getReturnType().isPrimitive() && !method.returnsVoid()) {
    throw new BindingException("Mapper method '" + command.getName() 
        + " attempted to return null from a method with a primitive return type (" + method.getReturnType() + ").");
  }
  return result;
}
```

## 6. 高级特性

### 6.1 插件机制

MyBatis 提供了插件机制，允许开发者扩展 MyBatis 的功能。插件可以拦截以下接口的方法：
- `Executor`：执行器，负责执行 SQL 语句
- `StatementHandler`：处理 JDBC Statement
- `ParameterHandler`：处理 SQL 参数
- `ResultSetHandler`：处理结果集

**插件开发示例**：

```java
@Intercepts({
    @Signature(
        type = Executor.class,
        method = "update",
        args = {MappedStatement.class, Object.class}
    )
})
public class LoggingPlugin implements Interceptor {
    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        long startTime = System.currentTimeMillis();
        try {
            // 执行原始方法
            return invocation.proceed();
        } finally {
            long endTime = System.currentTimeMillis();
            // 记录执行时间
            System.out.println("SQL 执行时间：" + (endTime - startTime) + "ms");
        }
    }
    
    @Override
    public Object plugin(Object target) {
        // 使用 Plugin.wrap() 方法包装目标对象
        return Plugin.wrap(target, this);
    }
    
    @Override
    public void setProperties(Properties properties) {
        // 设置插件属性
    }
}
```

### 6.2 缓存机制

MyBatis 提供了两级缓存机制：
- **一级缓存**：SqlSession 级别的缓存，默认启用
- **二级缓存**：Mapper 级别的缓存，需要手动启用

**二级缓存配置**：

1. **在 Mapper XML 文件中启用二级缓存**：
   ```xml
   <mapper namespace="com.example.mybatis.mapper.UserMapper">
       <cache/>
       <!-- 其他配置 -->
   </mapper>
   ```

2. **在实体类上实现 Serializable 接口**：
   ```java
   public class User implements Serializable {
       // ...
   }
   ```

### 6.3 动态 SQL

MyBatis 提供了动态 SQL 功能，允许根据条件动态生成 SQL 语句。

**动态 SQL 示例**：

```xml
<select id="findUsers" resultType="User">
    SELECT * FROM users
    <where>
        <if test="name != null and name != ''">
            AND name LIKE CONCAT('%', #{name}, '%')
        </if>
        <if test="age != null">
            AND age > #{age}
        </if>
        <if test="ids != null and ids.size() > 0">
            AND id IN
            <foreach collection="ids" item="id" open="(" separator="," close=")">
                #{id}
            </foreach>
        </if>
    </where>
    <order by created_at DESC
</select>
```

## 7. 最佳实践

### 7.1 SQL 优化
- **编写高效的 SQL**：避免使用 SELECT *，只查询需要的字段
- **使用索引**：为经常查询的字段创建索引
- **避免在循环中执行 SQL**：使用批量操作
- **合理使用缓存**：根据实际情况启用二级缓存

### 7.2 代码优化
- **使用 Mapper 接口**：避免使用 SqlSession 直接执行 SQL
- **合理使用动态 SQL**：避免生成过于复杂的 SQL
- **使用分页插件**：如 PageHelper，简化分页查询
- **使用注解还是 XML**：简单 SQL 使用注解，复杂 SQL 使用 XML

### 7.3 配置优化
- **设置合适的 Executor 类型**：根据实际情况选择 SIMPLE、REUSE 或 BATCH
- **启用下划线转驼峰命名**：`map-underscore-to-camel-case: true`
- **设置合理的缓存大小**：根据实际情况调整一级缓存和二级缓存的大小
- **启用延迟加载**：对于关联查询，启用延迟加载可以提高性能

## 8. 总结

MyBatis 是一款优秀的持久层框架，它提供了灵活的 SQL 编写方式和强大的映射能力。通过深入理解 MyBatis 的源码，我们可以更好地使用和优化 MyBatis 应用。

MyBatis 的核心组件包括 SqlSessionFactory、SqlSession、Mapper 接口、Executor 等，它们协同工作，完成 SQL 语句的执行和结果集的映射。MyBatis 的插件机制允许开发者扩展其功能，缓存机制可以提高应用性能，动态 SQL 功能可以根据条件动态生成 SQL 语句。

在实际开发中，我们应该根据实际情况选择合适的 ORM 框架。对于需要灵活控制 SQL 的场景，MyBatis 是一个不错的选择；对于需要快速开发、简单 CRUD 操作的场景，Hibernate 或 JPA 可能更合适。

通过学习 MyBatis 的源码，我们可以深入理解其工作原理，从而更好地使用和优化 MyBatis 应用。同时，我们也可以学习到 MyBatis 的设计思想和架构模式，这对于我们的软件开发能力的提升也是非常有帮助的。