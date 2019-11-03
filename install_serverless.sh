#!/usr/bin/env bash


# check AWS id
# change wedid and perso
nano ~/.aws/credentials


# add "bref/bref": "^0.5.7", in composer.json
#local
composer u

#optimise for deploy
composer install --optimize-autoloader --no-dev

npm install serverless-pseudo-parameters


# change config/filesystems.php

# change app/Http/MiddlewareTrustProxies
protected $proxies = '*';


# add new php init
mkdir php
mkdir conf.d
nano php.ini
 > extension=pdo_mysql

# vendor/bin/bref cli --region eu-west-3 ecomm-lambda-dev-artisan -- migrate --force
# vendor/bin/bref cli --region eu-west-3 ecomm-lambda-dev-artisan -- db:seed --force

vendor/bin/bref cli --region eu-west-3 ecomm-lambda-dev-artisan -- vendor:publish --all
vendor/bin/bref cli --region eu-west-3 ecomm-lambda-dev-artisan -- migrate
vendor/bin/bref cli --region eu-west-3 ecomm-lambda-dev-artisan -- aimeos:setup --option=setup/default/demo:1
vendor/bin/bref cli --region eu-west-3 ecomm-lambda-dev-artisan -- aimeos:cache


# add in app/Providers/AppServiceProvider.php
public function boot()
{
    // Make sure the directory for compiled views exist
    if (! is_dir(config('view.compiled'))) {
        mkdir(config('view.compiled'), 0755, true);
    }
}




serverless deploy


#########################
#  AWS S3 ASSETS
#########################


# sync asset to aws bucket S3 Manually
# if you need to install pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py

pip install awscli

# aws s3 sync <directory> s3://<bucket-name> --delete

aws s3 sync public/ s3://assets.myshop.com --delete
#aws s3 sync public/vendor s3://assets.bagisto.com



#########################
#  AWS SECURE KEY
#########################

# sécurisation des identidfiants

#aws ssm put-parameter --region eu-west-3 --name '/webid-lambda/db-database' --type String --value 'webid'

#${ssm:/webid-lambda/db-database}
${ssm:/webid-lambda/db-username}
${ssm:/webid-lambda/db-password}


#########################
#  DEBUG
#########################

serverless info

# logs
serverless logs -f website
serverless logs -f artisan



