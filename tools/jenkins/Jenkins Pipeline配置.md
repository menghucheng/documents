# Jenkins Pipeline 配置

## 1. 概述

### 1.1 什么是 Jenkins Pipeline
Jenkins Pipeline 是 Jenkins 的核心功能，用于将构建、测试、部署等步骤定义为一个完整的工作流。它支持代码化定义（即流水线即代码，Pipeline as Code），可以将流水线配置存储在版本控制系统中。

### 1.2 Pipeline 的核心优势
- **代码化定义**：流水线配置存储在版本控制系统中，支持版本管理和团队协作
- **可视化界面**：提供直观的流水线可视化界面，便于监控和调试
- **灵活的语法**：支持声明式和脚本式两种语法，满足不同需求
- **强大的扩展性**：支持与多种工具和技术栈集成
- **持久化执行**：构建历史和流水线状态持久化存储
- **并行执行**：支持并行执行构建步骤，提高构建效率

### 1.3 Pipeline 的两种语法
- **声明式流水线（Declarative Pipeline）**：
  - 语法更简洁、结构化
  - 基于 Jenkinsfile 顶层的 `pipeline` 块
  - 提供了更丰富的内置功能
  - 推荐用于大多数场景

- **脚本式流水线（Scripted Pipeline）**：
  - 基于 Groovy 脚本语言
  - 更灵活，支持复杂的逻辑
  - 基于 `node` 块
  - 适合高级用户和复杂场景

## 2. Jenkinsfile 基础

### 2.1 什么是 Jenkinsfile
Jenkinsfile 是包含 Jenkins Pipeline 定义的文本文件，通常存储在项目的根目录中。

### 2.2 Jenkinsfile 位置
- 通常存储在项目根目录，命名为 `Jenkinsfile`
- 也可以存储在其他位置，但推荐使用标准命名和位置

### 2.3 创建 Jenkinsfile
1. 在项目根目录创建 `Jenkinsfile` 文件
2. 在 Jenkins 控制台创建流水线任务，选择 "流水线" 类型
3. 配置流水线定义方式：
   - 从 SCM：从代码仓库中读取 Jenkinsfile
   - 直接输入：在 Jenkins 控制台直接编写 Jenkinsfile

## 3. 声明式流水线语法

### 3.1 基本结构
```groovy
pipeline {
    agent any  // 代理配置
    environment {  // 环境变量配置
        // 定义环境变量
    }
    stages {  // 阶段定义
        stage('Build') {  // 构建阶段
            steps {  // 步骤定义
                // 构建步骤
            }
        }
        stage('Test') {  // 测试阶段
            steps {
                // 测试步骤
            }
        }
        stage('Deploy') {  // 部署阶段
            steps {
                // 部署步骤
            }
        }
    }
    post {  // 构建后操作
        // 构建后操作
    }
}
```

### 3.2 代理配置（agent）
代理配置定义了流水线在哪里执行：

```groovy
// 在任何可用的代理上执行
agent any

// 在特定标签的代理上执行
agent {
    label 'linux'  // 在标签为 linux 的代理上执行
}

// 使用 Docker 容器执行
agent {
    docker {
        image 'maven:3.8.5-openjdk-17'  // Docker 镜像
        args '-v /root/.m2:/root/.m2'  // Docker 运行参数
    }
}

// 为每个阶段指定不同的代理
pipeline {
    agent none  // 顶级不指定代理
    stages {
        stage('Build') {
            agent { label 'linux' }
            steps {
                // 构建步骤
            }
        }
        stage('Test') {
            agent { label 'windows' }
            steps {
                // 测试步骤
            }
        }
    }
}
```

### 3.3 环境变量配置（environment）
```groovy
pipeline {
    environment {
        // 定义环境变量
        MAVEN_HOME = '/usr/local/maven'
        JAVA_HOME = '/usr/local/java'
        // 从凭证管理中获取凭证
        DB_PASSWORD = credentials('db-password')
    }
    // 其他配置
}
```

### 3.4 阶段定义（stages）
阶段是流水线的主要执行单元，包含一个或多个步骤：

```groovy
pipeline {
    stages {
        stage('Checkout') {
            steps {
                // 代码检出
                git branch: 'main', url: 'https://github.com/your-repo/your-project.git'
            }
        }
        stage('Build') {
            steps {
                // 构建步骤
                sh 'mvn clean compile'
            }
        }
        stage('Test') {
            steps {
                // 测试步骤
                sh 'mvn test'
            }
        }
        stage('Package') {
            steps {
                // 打包步骤
                sh 'mvn package -DskipTests'
            }
        }
        stage('Deploy') {
            steps {
                // 部署步骤
                sh './deploy.sh'
            }
        }
    }
}
```

### 3.5 步骤定义（steps）
步骤是流水线中的具体执行单元：

```groovy
steps {
    // 执行 Shell 命令
    sh 'echo "Hello Jenkins Pipeline!"'
    
    // 执行 Windows 命令
    bat 'echo Hello Jenkins Pipeline!'
    
    // 执行 PowerShell 命令
    powershell 'Write-Host "Hello Jenkins Pipeline!"'
    
    // 检出代码
    git branch: 'main', url: 'https://github.com/your-repo/your-project.git'
    
    // 使用 Maven 构建
    withMaven(maven: 'Maven 3.8.5') {
        sh 'mvn clean install'
    }
    
    // 归档构建产物
    archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
    
    // 发布测试报告
    junit 'target/surefire-reports/*.xml'
    
    // 发送邮件
    mail to: 'team@example.com', subject: 'Build Status', body: 'Build completed!'
}
```

### 3.6 构建后操作（post）
构建后操作定义了构建完成后执行的操作：

```groovy
pipeline {
    // 其他配置
    post {
        // 构建成功时执行
        success {
            echo '构建成功！'
            mail to: 'team@example.com', subject: '构建成功', body: '构建已成功完成！'
        }
        
        // 构建失败时执行
        failure {
            echo '构建失败！'
            mail to: 'team@example.com', subject: '构建失败', body: '构建失败，请查看日志！'
            slackSend channel: '#jenkins', message: '构建失败！'
        }
        
        // 构建不稳定时执行
        unstable {
            echo '构建不稳定！'
        }
        
        // 无论构建结果如何，总是执行
        always {
            echo '构建完成！'
            // 清理工作
            deleteDir()
        }
        
        // 构建被中止时执行
        aborted {
            echo '构建被中止！'
        }
    }
}
```

### 3.7 条件执行（when）
条件执行用于控制阶段或步骤是否执行：

```groovy
pipeline {
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage('Deploy to Dev') {
            when {
                branch 'dev'  // 只有 dev 分支才执行
            }
            steps {
                sh './deploy-dev.sh'
            }
        }
        
        stage('Deploy to Prod') {
            when {
                branch 'main'  // 只有 main 分支才执行
                and { 
                    environment name: 'DEPLOY_TO_PROD', value: 'true'  // 并且环境变量满足条件
                }
            }
            steps {
                sh './deploy-prod.sh'
            }
        }
        
        stage('Deploy to Staging') {
            when {
                not {
                    branch 'main'  // 非 main 分支执行
                }
                anyOf {
                    branch 'dev'
                    branch 'staging'
                }
            }
            steps {
                sh './deploy-staging.sh'
            }
        }
    }
}
```

### 3.8 并行执行
声明式流水线支持并行执行阶段：

```groovy
pipeline {
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Test') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        sh 'mvn test -Dtest=UnitTests'
                    }
                }
                stage('Integration Tests') {
                    steps {
                        sh 'mvn test -Dtest=IntegrationTests'
                    }
                }
                stage('Performance Tests') {
                    steps {
                        sh 'mvn test -Dtest=PerformanceTests'
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }
}
```

## 4. 脚本式流水线语法

### 4.1 基本结构
```groovy
node {
    // 环境设置
    def env = [
        MAVEN_HOME: '/usr/local/maven',
        JAVA_HOME: '/usr/local/java'
    ]
    
    stage('Checkout') {
        // 代码检出
        git branch: 'main', url: 'https://github.com/your-repo/your-project.git'
    }
    
    stage('Build') {
        // 构建步骤
        sh 'mvn clean compile'
    }
    
    stage('Test') {
        // 测试步骤
        sh 'mvn test'
        
        // 条件执行
        if (fileExists('target/test-reports')) {
            junit 'target/test-reports/*.xml'
        }
    }
    
    stage('Deploy') {
        // 部署步骤
        try {
            sh './deploy.sh'
            echo '部署成功！'
        } catch (Exception e) {
            echo "部署失败：${e.getMessage()}"
            throw e
        }
    }
    
    // 清理工作
    cleanWs()
}
```

### 4.2 脚本式流水线的核心概念

#### 4.2.1 node 块
`node` 块定义了流水线执行的节点，确保工作区隔离：

```groovy
node('linux') {
    // 流水线内容
}
```

#### 4.2.2 变量定义
使用 `def` 关键字定义变量：

```groovy
node {
    def branch = env.BRANCH_NAME
    def buildNumber = env.BUILD_NUMBER
    
    echo "当前分支：${branch}"
    echo "构建编号：${buildNumber}"
}
```

#### 4.2.3 条件语句
```groovy
node {
    if (env.BRANCH_NAME == 'main') {
        echo '当前是主分支，执行部署'
        sh './deploy-prod.sh'
    } else if (env.BRANCH_NAME == 'dev') {
        echo '当前是开发分支，执行开发环境部署'
        sh './deploy-dev.sh'
    } else {
        echo '当前是其他分支，跳过部署'
    }
}
```

#### 4.2.4 循环语句
```groovy
node {
    def environments = ['dev', 'staging', 'prod']
    
    for (env in environments) {
        echo "处理环境：${env}"
        // 执行环境相关操作
    }
}
```

#### 4.2.5 错误处理
```groovy
node {
    try {
        stage('Build') {
            sh 'mvn clean package'
        }
        
        stage('Test') {
            sh 'mvn test'
        }
        
        stage('Deploy') {
            sh './deploy.sh'
        }
        
        echo '构建成功！'
    } catch (Exception e) {
        echo "构建失败：${e.getMessage()}"
        currentBuild.result = 'FAILURE'
        mail to: 'team@example.com', subject: '构建失败', body: "构建失败：${e.getMessage()}"
    } finally {
        echo '清理工作'
        cleanWs()
    }
}
```

## 5. 流水线高级特性

### 5.1 参数化构建
参数化构建允许用户在触发构建时输入参数：

```groovy
pipeline {
    parameters {
        // 字符串参数
        string(name: 'ENVIRONMENT', defaultValue: 'dev', description: '部署环境')
        
        // 布尔参数
        booleanParam(name: 'RUN_TESTS', defaultValue: true, description: '是否运行测试')
        
        // 选择参数
        choice(name: 'DEPLOY_TYPE', choices: ['full', 'incremental', 'rollback'], description: '部署类型')
        
        // 密码参数
        password(name: 'API_KEY', defaultValue: '', description: 'API 密钥')
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Test') {
            when {
                expression { params.RUN_TESTS }
            }
            steps {
                sh 'mvn test'
            }
        }
        
        stage('Deploy') {
            steps {
                echo "部署到环境：${params.ENVIRONMENT}"
                echo "部署类型：${params.DEPLOY_TYPE}"
                sh "./deploy.sh --env ${params.ENVIRONMENT} --type ${params.DEPLOY_TYPE}"
            }
        }
    }
}
```

### 5.2 环境变量
Jenkins 提供了丰富的内置环境变量，也支持自定义环境变量：

#### 5.2.1 内置环境变量
- `BUILD_NUMBER`：构建编号
- `BUILD_ID`：构建 ID
- `BUILD_URL`：构建 URL
- `JOB_NAME`：任务名称
- `JOB_URL`：任务 URL
- `BRANCH_NAME`：当前分支名称
- `GIT_COMMIT`：当前 Git 提交哈希
- `GIT_URL`：Git 仓库 URL

#### 5.2.2 自定义环境变量
```groovy
pipeline {
    environment {
        // 定义静态环境变量
        MAVEN_OPTS = '-Xmx1024m'
        
        // 从凭证中获取环境变量
        DB_USERNAME = credentials('db-username')
        DB_PASSWORD = credentials('db-password')
        
        // 动态环境变量
        DOCKER_IMAGE_TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
    }
    
    stages {
        stage('Build') {
            steps {
                echo "Maven 选项：${MAVEN_OPTS}"
                echo "Docker 镜像标签：${DOCKER_IMAGE_TAG}"
                sh "mvn clean package -DskipTests"
            }
        }
    }
}
```

### 5.3 凭证管理
Jenkins 提供了安全的凭证管理机制，支持多种凭证类型：

```groovy
pipeline {
    stages {
        stage('Checkout') {
            steps {
                // 使用 SSH 凭证检出代码
                git branch: 'main', 
                    credentialsId: 'git-ssh-key', 
                    url: 'git@github.com:your-repo/your-project.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                // 使用用户名密码凭证登录 Docker Hub
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', 
                                               usernameVariable: 'DOCKER_USERNAME', 
                                               passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                    sh "docker build -t your-dockerhub-user/your-image:latest ."
                    sh "docker push your-dockerhub-user/your-image:latest"
                }
            }
        }
    }
}
```

### 5.4 并行构建
流水线支持并行执行多个步骤或阶段，提高构建效率：

```groovy
// 并行执行阶段
pipeline {
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Parallel Tests') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        sh 'mvn test -Dtest=UnitTests'
                    }
                }
                
                stage('Integration Tests') {
                    steps {
                        sh 'mvn test -Dtest=IntegrationTests'
                    }
                }
                
                stage('Performance Tests') {
                    steps {
                        sh 'mvn test -Dtest=PerformanceTests'
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }
}

// 并行执行步骤
pipeline {
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Test') {
            steps {
                parallel(
                    "Unit Tests": {
                        sh 'mvn test -Dtest=UnitTests'
                    },
                    "Integration Tests": {
                        sh 'mvn test -Dtest=IntegrationTests'
                    },
                    "Performance Tests": {
                        sh 'mvn test -Dtest=PerformanceTests'
                    }
                )
            }
        }
        
        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }
}
```

## 6. 流水线最佳实践

### 6.1 代码化定义
- 始终使用 Jenkinsfile，将流水线配置存储在版本控制系统中
- 遵循流水线即代码的原则
- 使用声明式流水线，除非需要脚本式的灵活性

### 6.2 阶段设计
- 合理划分阶段，每个阶段完成一个明确的任务
- 保持阶段数量适中，避免过多或过少的阶段
- 每个阶段应该有清晰的名称和目标

### 6.3 日志管理
- 添加充分的日志输出，便于调试和监控
- 使用有意义的日志信息
- 避免输出敏感信息

### 6.4 错误处理
- 添加适当的错误处理机制
- 构建失败时发送通知
- 保持构建历史的完整性

### 6.5 安全性
- 使用 Jenkins 凭证管理存储敏感信息
- 避免在流水线中硬编码密码和密钥
- 限制流水线的执行权限

### 6.6 性能优化
- 使用并行执行提高构建效率
- 合理使用缓存机制，避免重复构建
- 清理不必要的资源和工作区

### 6.7 版本管理
- 对 Jenkinsfile 进行版本管理
- 遵循代码审查流程
- 定期更新和优化流水线

### 6.8 可维护性
- 保持 Jenkinsfile 的简洁性
- 使用模块化设计，将复杂逻辑封装为函数或共享库
- 遵循一致的编码风格

## 7. 流水线示例

### 7.1 Java Maven 项目流水线
```groovy
pipeline {
    agent any
    
    environment {
        MAVEN_OPTS = '-Xmx2048m'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo/java-maven-project.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
                junit 'target/surefire-reports/*.xml'
            }
        }
        
        stage('Package') {
            steps {
                sh 'mvn package -DskipTests'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        
        stage('Deploy to Dev') {
            when {
                branch 'dev'
            }
            steps {
                sh './deploy-dev.sh'
            }
        }
        
        stage('Deploy to Prod') {
            when {
                branch 'main'
            }
            steps {
                sh './deploy-prod.sh'
            }
        }
    }
    
    post {
        success {
            echo '构建成功！'
            mail to: 'team@example.com', subject: '构建成功', body: 'Java Maven 项目构建已成功完成！'
        }
        
        failure {
            echo '构建失败！'
            mail to: 'team@example.com', subject: '构建失败', body: 'Java Maven 项目构建失败，请查看日志！'
        }
        
        always {
            cleanWs()
        }
    }
}
```

### 7.2 Node.js 项目流水线
```groovy
pipeline {
    agent {
        docker {
            image 'node:18-alpine'
            args '-v /root/.npm:/root/.npm'
        }
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo/nodejs-project.git'
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'npm ci'
            }
        }
        
        stage('Lint') {
            steps {
                sh 'npm run lint'
            }
        }
        
        stage('Test') {
            steps {
                sh 'npm test'
                junit 'coverage/junit.xml'
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm run build'
                archiveArtifacts artifacts: 'dist/**/*', fingerprint: true
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'npm run deploy'
            }
        }
    }
    
    post {
        success {
            echo '构建成功！'
        }
        
        failure {
            echo '构建失败！'
        }
        
        always {
            cleanWs()
        }
    }
}
```

## 8. 流水线共享库

### 8.1 什么是流水线共享库
流水线共享库是用于共享 Jenkins Pipeline 代码的机制，允许在多个项目之间共享流水线逻辑，提高代码复用性和维护性。

### 8.2 共享库的结构
```
(root)
+- src/                 # Groovy 源代码目录
|   +- org/
|       +- example/
|           +- Pipeline.groovy  # 共享库代码
+- vars/                # 全局变量目录
|   +- buildAndDeploy.groovy   # 全局变量定义
|   +- sonarScan.groovy        # 全局变量定义
+- resources/           # 资源文件目录
|   +- org/
|       +- example/
|           +- config.yml      # 配置文件
+- Jenkinsfile          # 可选的示例 Jenkinsfile
```

### 8.3 共享库的使用
1. 在 Jenkins 全局配置中添加共享库
2. 在 Jenkinsfile 中导入共享库
3. 使用共享库中的函数和变量

```groovy
// 在 Jenkinsfile 中导入共享库
@Library('my-shared-library') _

pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // 使用共享库中的函数
                buildApp()
            }
        }
        
        stage('Test') {
            steps {
                runTests()
            }
        }
        
        stage('Deploy') {
            steps {
                deployApp('dev')
            }
        }
    }
}
```

## 9. 流水线监控与调试

### 9.1 流水线可视化
Jenkins 提供了直观的流水线可视化界面：
- 查看流水线的整体状态
- 查看每个阶段的执行状态和耗时
- 查看步骤的执行日志
- 暂停和恢复流水线执行

### 9.2 日志管理
- 控制台输出：查看完整的构建日志
- 阶段日志：查看每个阶段的日志
- 步骤日志：查看每个步骤的日志
- 保存构建日志：将日志保存为文件

### 9.3 调试技巧
- 使用 `echo` 命令输出调试信息
- 使用 `printStackTrace()` 查看完整的错误堆栈
- 使用 Blue Ocean 插件进行可视化调试
- 在流水线中添加断点
- 使用 `replay` 功能重新执行流水线，便于调试

## 10. 总结

Jenkins Pipeline 是 Jenkins 的核心功能，支持将构建、测试、部署等步骤定义为一个完整的工作流。它支持代码化定义，便于版本管理和团队协作。

通过学习 Jenkins Pipeline 的语法和最佳实践，可以构建高效、可靠的 CI/CD 流水线，提高软件开发的效率和质量。

无论是简单的项目还是复杂的企业级应用，Jenkins Pipeline 都能满足需求，提供灵活、强大的自动化构建、测试和部署能力。