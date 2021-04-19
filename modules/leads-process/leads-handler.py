import json
import boto3

def lambda_handler(event, context):
    # print(event["Records"][0])
    # The below is to put code in the s3 bucket
    # s3 = boto3.client("s3")
    # data = event["Records"][0]["body"]
    # s3.put_object(Bucket="sqs-leads", Key="data.json", Body=data)
    # The below is to put a new message in new sqs
    sqs = boto3.resource('sqs')

    queue = sqs.get_queue_by_name(QueueName='leads-process-queue')
    response = queue.send_message(MessageBody=json.dumps(event))
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }

