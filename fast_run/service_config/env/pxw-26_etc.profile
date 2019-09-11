#CUDA
export LD_LIBRARY_PATH="/usr/local/cuda/lib64"
export CUDA_HOME=/usr/local/cuda
export PATH="$CUDA_HOME/bin:$PATH"

#JAVA
export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-1.el7_6.x86_64"
export CLASSPATH=".:$JAVA_HOME/lib:.:/lib:"
export PATH="$PATH:$JAVA_HOME/bin"

#HADOOP
export HADOOP_HOME="/usr/local/hadoop/hadoop-2.7.7"
export PATH="$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin"
export HADOOP_CONF_DIR="/usr/local/hadoop/hadoop-2.7.7/etc/hadoop"
export YARN_CONF_DIR="/usr/local/hadoop/hadoop-2.7.7/etc/hadoop"
export HDFS_CONF_DIR="$HADOOP_HOME/etc/hadoop"

#SCALA
export SCALA_HOME="/usr/local/hadoop/scala-2.11.8"
export PATH="$PATH:$SCALA_HOME/bin"

#HBase by lipengfei
export HBASE_HOME="/usr/local/hadoop/hbase-2.0.2"
export PATH="$PATH:$HBASE_HOME/bin:$HBASE_HOME/sbin"

#SPARK
export SPARK_HOME="/usr/local/hadoop/spark-2.2.3-bin-hadoop2.7"
export PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"
export SPARK_CLASSPATH="$SPARK_HOME/lib"
export CLASSPATH=".:$JAVA_HOME/lib:$SPARK_CLASSPATH"

#GO ENV by LiPengFei
export GOROOT="/usr/local/go"
export GOPATH="$HOME/gopath"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

#sbt by lipengfei 20190119
export SBT_HOME="/usr/local/sbt"
export PATH="$PATH:$SBT_HOME/bin"

#pycharm by LiPengFei
export PATH="$PATH:/opt/pycharm-2018.3.2/bin"