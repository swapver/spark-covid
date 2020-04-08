# Apache Spark COVID-19 Reports

A playground project to generate COVID-19 reports from
[Johns Hopkins COVID-19 (2019-nCoV) Data Repository](https://github.com/CSSEGISandData/COVID-19).

The goal of the project is educational and for me to get more familiar with the Apache Spark framework.


## Configure
1. `git clone` [Johns Hopkins COVID-19 (2019-nCoV) Data Repository](https://github.com/CSSEGISandData/COVID-19) repository
2. install Apache Spark 2.4.5 locally

## Run
1. sbt package
2. submit spark job locally:

```
REPO_COVID_PATH=<LOCAL_DATA_REPO_PATH> $SPARK_HOME/bin/spark-submit \
--class "ReportsGenerator" \
--master local[2]  \
target/scala-2.11/spark-covid_2.11-1.0.jar
``` 

where `REPO_COVID_PATH` is the folder where the data repository has been cloned above.

Or use the script
```bash
export SPARK_HOME=<LOCAL_SPARK_PATH>
export REPO_COVID_PATH=<LOCAL_DATA_REPO_PATH>
bash scripts/generateReports.sh
```