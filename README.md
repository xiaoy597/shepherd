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
- 将Solr安装路径下的contrib/analysis-extras/lucene-libs/lucene-analyzers-smartcn-7.3.0.jar拷贝到server/solr-webapp/webapp/WEB-INF/lib目录下。

## 安装 Firefox 
最新版本

## 环境设置
- Spider-Agent<br>
    根据本地环境修改start-agent.bat文件中变量设置，可参考脚本中对变量的注释。
- Gecko Driver<br>
    将工程目录下的tool目录加入系统搜索路径。对于Firefox 64.0+，需要使用geckodriver 0.23以上版本。
- Shepherd<br>
    在PyCharm中打开本项目，
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
- 作业配置数据库<br>
    在MySQL中创建作业配置数据库，数据库的名称应与Shepherd使用的配置一致。<br>
    使用项目路径下conf/spider/spiderdb.sql创建采集作业配置需要的表。<br>
    在conf/example/spiderdb-with-sample-job.sql中有一些配置好的作业可供参考。
- 采集结果数据库（可选）<br>
    如果需要运行样例作业，需要创建采集结果数据库。执行conf/example/spider_data.sql创建采集结果数据库，数据库的访问参数在作业配置数据库的data_store_param表中。

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
    如果作业配置和运行环境都没有问题，配置为“立即执行”的作业将会立即被部署到相应的Spider-Agent，并开始执行。采集程序的运行日志记录在Spider-Agent工作目录的logs子目录下。


# 运行环境（CentOS 7.3）
进行运行环境的部署之前，需要在开发环境中执行Run -> Run... -> Build，执行完毕后在dist目录下会生成安装包，<br>
    ```shell
    shpherd_0.1.0.zip
    spider-agent_0.1.0.zip
    ```

运行环境分为抓取引擎和管理监控界面两个部分，**这里只包括抓取引擎的安装和配置，管理监控界面部分的安装和配置请联系宋超群。**<br>

## 环境准备
### MySQL服务器
- 版本5.6+。
- 数据库初始化

   a. 为抓取服务创建数据库用户，用户名和口令需要与shepherd用户环境变量（SHEPHERD_DB_USER/SHEPHERD_DB_PASS）一致。<br>
   b. 创建抓取服务配置数据库，名为spiderdb，默认字符集为utf8。<br>
   c. 使用源代码路径下的conf/example/spiderdb-with-sample-job.sql初始化shepherd配置数据库。<br>
   d. 创建抓取数据存储库，名为spider_data，默认字符集为utf8。<br>
   e. 使用源代码路径下的conf/example/spider_data.sql初始化抓取数据存储库。<br>
   f. 将spiderdb和spider_data数据库的所有权限赋予抓取服务的数据库用户。
   
### Solr服务器
版本7.3+。<br>
参考开发环境对Solr服务器的配置步骤。
### 抓取服务器
- 操作系统为CentOS 7.3，如果使用CentOS更早的版本，Firefox需要升级到最新版本。
- 关闭防火墙
```shell
systemctl stop firewalld
systemctl disable firewalld
```
- 安装所需的软件包
```shell
yum install Xvfb
yum install firefox
```

## Shepherd服务配置
Shepherd服务负责监听管理监控界面发来的任务调度命令，将相应的抓取任务分配给指定的抓取执行服务（Spider-agent）。
由于Shepherd服务在启动时，会在配置数据库中查找配置为立即执行的任务，并立即调度这些任务，所以需要事先启动执行这些作业的Spider-agent服务，
否则将出现调度失败错误。

1. 在抓取服务器上创建shepherd用户
2. 在shepherd用户目录下安装anaconda3（版本5.3+）<br>
   注意在安装结束时选择在.bashrc中加入anaconda的初始化命令。
3. 重新登录shepherd用户，安装所需的python package，
    ```shell
    pip install apscheduler
    conda install pyhamcrest
    pip install colorlog
    conda install tornado
    conda install mysql-connector-python
    pip install scrapyd-client
	```
4. 在shepherd用户目录下安装shepherd模块<br>
   a. 在shepherd用户目录下解压shepherd_0.1.0.zip<br>
   b. 为shepherd_0.1.0/bin目录下所有文件增加执行权限。<br>
   c. 在.bashrc中设置环境变量，
   ```shell
    export SPIDER_PACKAGE=shepherd_0.1.0
    export SHEPHERD_HOME=$HOME/$SPIDER_PACKAGE
    export PATH="$SHEPHERD_HOME/bin:$PATH"
    export PYTHONPATH="$SHEPHERD_HOME"
    export SHEPHERD_LOGGING_CONF=$SHEPHERD_HOME/shepherd/logging.conf
    export SHEPHERD_SPIDER_TEMPLATE=$SHEPHERD_HOME/clematis/clematis
    export SHEPHERD_JOB_PREPARE_PATH=$SHEPHERD_HOME/tmp
    export SHEPHERD_DB_HOST=127.0.0.1  # 根据本地环境修改
    export SHEPHERD_DB_NAME=spiderdb
    export SHEPHERD_DB_USER=spider     # 根据本地环境修改
    export SHEPHERD_DB_PASS=spider     # 根据本地环境修改
    export SHEPHERD_PORT=8888
    export CONDA_PREFIX=${HOME}/anaconda3/bin
    export SPIDER_SCRAPYD_PATH=$CONDA_PREFIX
   ```
5. 重新登录shepherd用户，启动shepherd服务
   ```shell
   cd $HOME/shepherd_0.1.0; python shepherd/shepherd.py
   ```
## Spider-agent服务配置
Spider-agent服务负责接收Shepherd服务分配的抓取任务，并执行这些任务。
由于Shepherd服务启动时会对那些配置为立即执行的任务进行调度，所以需要Spider-agent服务先于Shepherd服务启动，以免发生任务调度失败的情况。

1. 在抓取服务器上创建spider-agent用户
2. 在spider-agent用户目录下安装anaconda3（版本5.3+）<br>
   注意在安装结束时选择在.bashrc中加入anaconda的初始化命令。
3. 重新登录spider-agent用户，安装所需的python package，
    ```shell
    conda install scrapy
    pip install scrapyd
    conda install selenium
    pip install kafka-python
    conda install mysql-connector-python
    pip install colorlog
	```
4. 在spider-agent用户目录下安装spider-agent模块<br>
   a. 在spider-agent用户目录下解压spider-agent_0.1.0.zip<br>
   b. 为spider-agent_0.1.0/bin目录下所有文件增加执行权限。（如果Firefox版本为64.0+，需要使用geckodriver 0.23以上版本）<br>
   c. 在.bashrc中设置环境变量， 
   ```shell
   export DISPLAY=:1
   
   export SPIDER_PACKAGE=spider-agent_0.1.0
   export SPIDER_AGENT_HOME=$HOME/$SPIDER_PACKAGE
   
   export PATH="$SPIDER_AGENT_HOME/bin:$PATH"
   export PYTHONPATH="$SPIDER_AGENT_HOME"
   
   export SPIDER_AGENT_WORK_DIR=$SPIDER_AGENT_HOME/scrapyd
   export SPIDER_LOGGING_CONF=$SPIDER_AGENT_HOME/logging.conf
   export SHEPHERD_PORT=8888
   export SHEPHERD_HOST=127.0.0.1
   export SPIDER_PAGE_DUMP=False
   export SOLR_SERVER=127.0.0.1:8983    # 需要修改为本地Solr服务的地址
   ```
   d. 设置scrapyd配置文件
   ```shell
   cp $HOME/spider-agent_0.1.0/scrapyd.conf.default ~/.scrapyd.conf
   ```
5. 重新登录spider-agent用户，启动spider-agent服务
   ```shell
   python $HOME/spider-agent_0.1.0/spider-agent.py
   ```
