cd /home/ec2-user/

REPO_COVID_PATH=/home/ec2-user/COVID-19
RESOURCES_PATH=/home/ec2-user/

git -C $REPO_COVID_PATH pull
RESOURCES_PATH=$RESOURCES_PATH REPO_COVID_PATH=$REPO_COVID_PATH /home/ec2-user/./spark-2.4.5-bin-hadoop2.7/bin/spark-submit --class "ReportsGenerator" --master local[1] spark-covid_2.11-1.0.jar