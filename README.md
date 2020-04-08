# Apache Spark COVID-19 Reports

A playground project to generate COVID-19 reports from
[Johns Hopkins COVID-19 (2019-nCoV) Data Repository](https://github.com/CSSEGISandData/COVID-19).

The goal of the project is educational and for me to get more familiar with the Apache Spark framework.


## Configure
1. `git clone` [Johns Hopkins COVID-19 (2019-nCoV) Data Repository](https://github.com/CSSEGISandData/COVID-19) repository
2. install Apache Spark 2.4.5

## Run
1. sbt package
2. run locally with

``
REPO_COVID_PATH=~/Development/repos/COVID-19 $SPARK_HOME/bin/spark-submit \
--class "ReportsGenerator" \
--master local[2]  \
target/scala-2.11/spark-covid_2.11-1.0.jar
``  