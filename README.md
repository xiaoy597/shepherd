# 开发环境（Windows）

## 安装 Anaconda

- 使用以下链接下载Anaconda安装包，并按默认设置安装。<br>
https://repo.anaconda.com/archive/Anaconda3-5.3.0-Windows-x86_64.exe
- 打开Anaconda命令窗口，执行：<br>
    ```shell
    activate <工程路径>/envs/venv3.7-win
    pip uninstall scrapyd
    pip install scrapyd
    ```

## 安装 IDEA PyCharm
链接：https://www.jetbrains.com/pycharm/

## 安装 MySQL 数据库
版本5.6+

## 安装 Solr
- 下载并安装Solr 7.3+。
- 将代码路径下conf/solr/crawler_configs目录拷贝到Solr安装路径下的server/solr/configsets目录下。
- 将Solr安装路径下的contrib/analysis-extras/lucene-libs/lucene-analyzers-smartcn-7.5.0.jar拷贝到server/solr-webapp/webapp/WEB-INF/lib目录下。


## 环境设置
- 根据本地环境修改start-agent.bat文件中变量设置，可参考脚本中对变量的注释。
- 将工程目录下的tool目录加入系统搜索路径。
- 在PyCharm中打开本项目，
    1. 在 File->Settings 菜单中设置项目的Python Interpreter为“项目路径/envs/venv3.7-win”。
    2. 在 Run->Edit Configuration 菜单中修改Shepherd运行配置的环境变量：
        - SHEPHERD_DB_NAME	spiderdb<br>
            Spider数据库的名称
        - SHEPHERD_DB_PASS	spider<br>
            Spider数据库的用户名
        - SHEPHERD_DB_USER	spider<br>
            Spider数据库的用户口令
        - SHEPHERD_SPIDER_TEMPLATE	<工程路径>\clematis\clematis<br>
            Spider项目路径（一般不需修改）
        - SHEPHERD_JOB_PREPARE_PATH	c:\tmp\job_prepare<br>
            部署Spider作业是的准备文件存放路径
        - SHEPHERD_PORT	8888<br>
            Shepherd进程的监听端口
        - SHEPHERD_DB_HOST	localhost<br>
            Shepherd进程的运行主机
        - SHEPHERD_LOGGING_CONF	<工程路径>\shepherd\logging.conf<br>
            日志配置文件路径
        - SPIDER_SCRAPYD_PATH	<工程路径>\envs\venv3.7-win\Scripts<br>
            scrapyd-client的安装路径
        - CONDA_PREFIX	<工程路径>\envs\venv3.7-win<br>
            Conda环境路径
- 创建作业配置数据库<br>
    使用项目路径下conf/spider/spiderdb.sql创建采集作业配置需要的表。<br>
    在conf/example/spiderdb-with-sample-job.sql中有一些配置好的作业可供参考。数据库的名称应与Shepherd使用的配置一致。<br>
    大部分配置作业样例会将采集结果存入MySQL数据库，数据库的访问参数在data_store_param表中。
- 创建采集结果数据库（可选）<br>
    如果需要运行样例作业，需要创建采集结果数据库，执行conf/example/spider_data.sql。

# 运行采集作业
## 运行 Spider-Agent
Spider-Agent负责接收Shepherd进程分发的采集作业并调用scrapy执行作业，运行Spider-Agent的方法为：
- 打开Anaconda的命令行窗口
- 执行：<br>
    ```shell
    activate <工程路径>/envs/venv3.7-win
    <工程路径>/start-agent.bat
    ```
## 运行 Shepherd
Shepherd负责作业的调度。Shepherd启动时会检查作业配置库中的作业调度配置，并根据配置设置各作业的启动时间，在到达启动时间后，将根据作业部署的配置情况将作业打包发送给相应的Spider-Agent执行。<br>
如果作业为无效状态（crawl_job.is_valid = 0），则该作业不会被调度。
- 用PyCharm打开工程，运行Shepherd配置。<br>
    如果作业配置和运行环境都没有问题，配置为“立即执行”的作业将会立即被部署到相应的Spider-Agent，并开始执行。

