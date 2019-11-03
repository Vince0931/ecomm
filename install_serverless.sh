#!/usr/bin/env bash


# user=admin
# password=jAghmKUOUvFrQ2ODhX2lpNwnCnwLtvZ7
# host=staging.c8fzfidnwmue.eu-west-3.rds.amazonaws.com

# check AWS id
# change wedid and perso
nano ~/.aws/credentials


# add "bref/bref": "^0.5.7", in composer.json
#local
composer u

#optimise for deploy
composer install --optimize-autoloader --no-dev


npm install serverless-pseudo-parameters


# add new php init
mkdir php
mkdir conf.d
nano php.ini
 > extension=pdo_mysql

vendor/bin/bref cli --region eu-west-3 ecomm-lambda-dev-artisan -- migrate --force
vendor/bin/bref cli --region eu-west-3 ecomm-lambda-dev-artisan -- db:seed --force



# link nova media
php artisan storage:link

# create serverless.yml

serverless deploy


# sync asset to aws bucket S3 Manually
# if you need to install pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py

pip install awscli

# aws s3 sync <directory> s3://<bucket-name> --delete

aws s3 sync public/ s3://assets.myshop.com --delete
#aws s3 sync public/vendor s3://assets.bagisto.com


# sécurisation des identidfiants

#aws ssm put-parameter --region eu-west-3 --name '/webid-lambda/db-database' --type String --value 'webid'
aws ssm put-parameter --region eu-west-3 --name '/webid-lambda/db-username' --type String --value 'admin'
aws ssm put-parameter --region eu-west-3 --name '/webid-lambda/db-password' --type String --value 'jAghmKUOUvFrQ2ODhX2lpNwnCnwLtvZ7'

#${ssm:/webid-lambda/db-database}
${ssm:/webid-lambda/db-username}
${ssm:/webid-lambda/db-password}


serverless info



#vendor/bin/bref cli webid-lambda-dev-artisan -- migrate
vendor/bin/bref cli --region eu-west-3 ecomm-lambda-dev-website
vendor/bin/bref cli --region eu-west-3 ecomm-lambda-dev-artisan -- migrate


# logs
serverless logs -f website
serverless logs -f artisan



