#!/bin/bash

region='eu-west-1'
bucketname='welcloud.io.aws-simplest-example'

# Upload cloudformation templates to s3
for folder in $(ls -d cloudformation-templates/*/); do
  for templatename in $(ls $folder); do
    templatepath=$folder$templatename
    aws s3 cp $templatepath s3://$bucketname/$templatepath
  done
done

# Upload architecture diagrams to s3
for folder in $(ls -d architecture-diagrams/*/); do
  for diagramname in $(ls $folder); do
    diagrampath=$folder$diagramname
    aws s3 cp $diagrampath s3://$bucketname/$diagrampath
  done
done
