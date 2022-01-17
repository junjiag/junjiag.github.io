---
layout: post
title: AWS S3 Useful awscli Operations at Linux | 亚马逊AWS S3常用Linux awscli操作
date: 2017-01-21 18:21:10
image: default_cover1.jpg
updated: 2017-01-21 19:40:35
tags:
- AWS
- Linux
- awscli
---

### Install 安装：
`sudo apt-get install awscli`
### Configuration 配置：
`aws configure`
### File Operation 文件操作：
```shell
# Create a new bucket 新建存储桶
aws s3 mb s3://bucketname
# Browse the file list 查看文件列表
aws s3 ls s3://bucketname
# Upload file to S3 上传文件到S3
aws s3 cp test.txt s3://bucketname
# Download file from S3 从S3下载文件
aws s3 cp s3://bucketname/test.txt .
# Delete file in S3 删除S3内文件
aws s3 rm s3://bucketname/test.txt
# Delete bucket in S3 删除存储桶
aws s3 rb s3://bucketname [--force]
```
