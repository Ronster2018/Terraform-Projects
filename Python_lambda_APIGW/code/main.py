"""
https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html
https://aws-lambda-for-python-developers.readthedocs.io/en/latest/home/

The lambda function "handler" is a method that processes events. When the function is invoked, lambda runs the handler method.

Function runs until the handler returns a response, exits, or times out()

def handler_name(event, context):
    ...
    return some_value


Naming:
- A function handler can be any name; however, the default name in the Lambda console is lambda_function.lambda_handler.

lambda_function - lambda_function.py
lambda_handler - the function name

- To change this behavior, navigate to Functions > Code tab > Runtime Settings > Edit > Handler ( enter the new name for the function) > Save
"""


def lambda_handler(event, context):
    content = """
   <html>
   <h1> Hello Website running on Lambda! Deployed via Terraform </h1>
   </html>
   """
    response = {
        "statusCode": 200,
        "body": content,
        "headers": {
            "Content-Type": "text/html",
        },
    }
    return response
