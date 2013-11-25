#说明
命令行工具基于libcurl+ [百度PCS的rest API](http://developer.baidu.com/wiki/index.php?title=docs/pcs/rest/file_data_apis_list) ，适用于linux,Mac OS
#依赖
libcurl >= 7.18, centos/redhat 5自带curl版本较低，编译前请升级
#安装
~~~
make
make install #这一步可以省略咯，就一个可行行文件，可以自己随便copy到哪里。。
~~~
#使用方法
~~~
使用方法: baidu_pcs 命令 [选项]

说明:
    配置文件必须放在 /etc/baidupcs.conf 或者 ~/baidupcs.conf 

命令列表:

info      查看云盘信息

ls        列出远程文件或目录
          选项:
            -l 显示详细信息
            -r 递归子目录

upload   [选项] [本地路径] [远程路径] 上传文件或目录
          选项:
            覆盖策略
            默认:略过已存在同名远程文件
            -o 覆盖远程同名文件
            -n 如果存在同名文件，创建以日期结尾的新文件

            -p 指定上传分片大小,例如 -p100M
            -l 跟随软链

download [选项] [远程路径] [本地路径] 下载文件或目录
          选项:
            -o 覆盖本地同名文件
            -n 如果存在同名文件，创建以日期结尾的新文件

cp       [远程路径] [目的远程路径] 复制远程文件或目录
mv       [远程路径] [目的远程路径] 移动远程文件或目录
rm       [远程路径] 删除远程文件或目录

sync     [选项] [远程路径] [本地路径] 同步文件或者目录
          选项:
            默认:略过已存在同名文件
            -o 覆盖同名文件
            -n 如果存在同名文件，创建以日期结尾的新文件
~~~
#你可能需要知道
1. pcs api只能操作/apps/xxx下的文件
1. 默认文件分片尺寸为50M
2. 下载可以输出到标准输出`baidu_pcs down /apps/xxx/test.mp4 - | mplayer -cache 8192 -`
2. API使用https协议，curl初始化时设置了速度较快的rc4加密方式
3. 所有请求失败会重试5次
4. 非上传请求，5秒连接超时，20秒请求超时
5. 上传请求，5秒连接超时，文件尺寸/(10K/s)的上传超时
6. 上面你都可以自己改了重新编译。。。

#更新的内容
###2013-11-25：
1. 增加一个sync命令，daemon方式每15秒调用一次download命令
2. 增加配置文件功能，用于保存API Key 和 API Secret，方便没有条件编译的朋友
3. 此版本主要是为了方便嵌入系统使用的，比如dd-wrt, openWRT
4. 在osx10.9 ubuntu mips环境下编译通过

#关于
本人Linux、C方面是小白，周末在家配置路由器`BUFFALO WZR-HP-G300NH2`的远程下载时想到这个好工具，
无奈没有可以在dd-wrt上运行的版本，于是想自己动手编译，不料掉入cross compile深坑，
费半天时间在OS X下尝试失败，因为教程几乎一水Linux下于是转战Ubuntu。
还好功夫不负有心人搭近周末编译出了MIPS版。

在此感谢原作者 [@emptyhua](https://github.com/emptyhua) 无私分享的优秀代码，我后来添加的那些代码已经无法直视了。

