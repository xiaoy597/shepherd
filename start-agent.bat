@rem 工程目录
@SET SPIDER_HOME=C:\users\xiaoy\pycharmprojects\shepherd

@rem Spider-Agent的工作目录，需要提前创建
@SET SPIDER_AGENT_WORK_DIR=c:\tmp\scrapyd

@rem Shepherd守护进程的IP地址
@SET SHEPHERD_HOST=127.0.0.1
@rem Shepherd守护进程的监听端口
@SET SHEPHERD_PORT=8888

@rem 是否保存网页原始内容到HBase，目前未实现
@SET SPIDER_PAGE_DUMP=False

@rem 日志配置文件的路径，一般不需要修改
@SET SPIDER_LOGGING_CONF=%SPIDER_HOME%\clematis\clematis\logging.conf

@rem Solr服务的地址和端口
@SET SOLR_SERVER=127.0.0.1:8983

@python %SPIDER_HOME%/spider-agent.py
