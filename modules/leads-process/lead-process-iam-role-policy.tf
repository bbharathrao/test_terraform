resource "aws_iam_role_policy" "lead_process_policy" {
  name = "lead_process_policy"
  role = "${aws_iam_role.lead_process_role.id}"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sqs:*"],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Action": ["s3:*"],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Action": ["sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes", "logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Action": ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
      "Effect": "Allow",
      "Resource": ["*"]
    }
  ]
}
POLICY
}

resource "aws_iam_role" "lead_process_role" {
  name = "lead_process_role"
  assume_role_policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Action":"sts:AssumeRole",
      "Effect":"Allow",
      "Sid":"",
      "Principal":{
        "Service":"lambda.amazonaws.com"
      }
    }
   ]
}
EOF
}