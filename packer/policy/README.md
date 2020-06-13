# Creating vmimport role to interact with AMIs and Raw image convertion on AWS

## Prerequisites

- Install aws cli : [How to install](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- Configure aws cli `aws configure` or change your current config under `.aws/config` to define Regions
- Make sure you have a [AWS ACCESS KEY and AWS SECRET KEY](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)

  You can store the keys under `.aws/credentias` but **PLEASE** do not share and keep it any secret safe possibly using Vault.
- [How to import an image](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html)
- See the examples in this directory about the format we are using.

## Creating / defining vmimport role

- Creating role as  defined on the trust policy in this directory.

`aws iam create-role --role-name vmimport --assume-role-policy-document "file:///trust-policy.json"`

- Defining role policy to access S3 bucket and convert images from it. **Remember to change the S3 butcket defined on the json**.

`aws iam put-role-policy --role-name vmimport --policy-name vmimport --policy-document "file://role-policy.json"`

