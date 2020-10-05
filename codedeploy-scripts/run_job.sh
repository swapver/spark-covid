cd /home/ec2-user/
mkdir -p out

REPO_COVID_PATH=/home/ec2-user/COVID-19
RESOURCES_PATH=/home/ec2-user/spark-covid/src/main/resources

git -C $REPO_COVID_PATH pull
RESOURCES_PATH=$RESOURCES_PATH 
REPO_COVID_PATH=$REPO_COVID_PATH 
/home/ec2-user/spark-2.4.7-bin-hadoop2.7/bin/spark-submit --class /home/ec2-user/spark-covid/src/main/ReportsGenerator --master local[1] --jars /home/ec2-user/spark-covid/target/scala-2.11/spark-covid_2.11-1.0.jar
python /home/ec2-user/spark-covid/scripts/create_index.py

BUCKET=$(aws --region us-east-2 ssm get-parameter --githubOAuthToken codepipeline-us-east-2-65887929830 --query 'Parameter.Value' --output text)
aws s3 sync out s3://codepipeline-us-east-2-65887929830
