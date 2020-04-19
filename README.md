# Apache Spark COVID-19 Reports

A playground project to generate COVID-19 reports from
[Johns Hopkins COVID-19 (2019-nCoV) Data Repository](https://github.com/CSSEGISandData/COVID-19).

The goal of the project is educational and for me to get better with the Apache Spark framework and as well as with AWS CI/CD services.


## Local Installation & Run

### Configure
1. `git clone` [Johns Hopkins COVID-19 (2019-nCoV) Data Repository](https://github.com/CSSEGISandData/COVID-19) repository
2. install Apache Spark 2.4.5 locally

### Run
1. sbt package
2. submit spark job locally in standalone mode:

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

## AWS CI/CD

The project can be fully managed for continuous integration and delivery through an [AWS CodePipeline](https://aws.amazon.com/codepipeline/).
The pipeline:
  1. builds the project from code through [AWS CodeBuild](https://aws.amazon.com/codebuild/)
  2. deploys the project to an EC2 Instance through [AWS CodeDeploy](https://aws.amazon.com/codedeploy/)
  3. runs the spark job in standalone/local mode on the  [EC2 Instance](https://aws.amazon.com/ec2/)
  4. and uploads the generated reports into an [AWS S3 Bucket](https://aws.amazon.com/s3/)
  
  
The CI/CD service is being modelled and provisioned with [AWS CloudFormation](https://aws.amazon.com/cloudformation/)


### Deploy Pipeline 

Create and deploy the CodePipepile along with all required components by using the `cloudformation/cf-all.yml` file:    

```bash
aws cloudformation deploy --template-file cloudformation/cf-all.yml --stack-name spark-covid  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM
```

##### Note:
Set up the necessary system manager parameter store first (See below). 

- The pipeline is connected to the gitHub repository and is being triggered by new commits. For that purpose a
[GitHub personal access token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line) should
be generated and provided to the CloudFormation through a Parameter.

- Moreover, a cron scheduler for daily execution through a [AWS CloudWatch Events Rule](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/Create-CloudWatch-Events-Scheduled-Rule.html) can be set up.


### Parameters Store

To protect sensitive data as well as to parameterize the cloudFormation, [AWS Systems Manager Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html)
is being used.
The setup of these parameters is manual, and it should take place before the CloudFormation deloyment. 


The GitHub personal access token is being provided as a parameter store: `'{{resolve:ssm:githubOAuthToken:1}}'`
##### Remark:
Parameter Store persists the value of the parameter in plain text. 
- A SecureString would be a more secure alternative, since they are encrypted, but security strings are not being supported in the CodePipeline stack:
`'{{resolve:ssm-secure:githubOAuthToken:1}}'`
- A secret managed by [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/) is the only secure alternative:
`{resolve:secretsmanager:secret-id:secret-string:json-key:version-stage:version-id}}`