#!/bin/bash
region='eu-west-1'
bucketname='welcloud.io.aws-simplest-example'

readmefile='readme.md'
cat << EOF > $readmefile
### Ready to use Cloudformation templates
###### !! These templates may incur (small) costs !!
###### !! So, you should delete them when you are done !!
###### !! You should NOT create them in a production account !!
###### !! Create them in a sandbox or dev account for learning purpose !!
---
##### For simplicity each template uses :
##### - Ireland Region (eu-west-1)
##### - AWS Account "Default VPC" Network
---
EOF

for folder in $(ls -d cloudformation-templates/*/); do
  for templatename in $(ls $folder); do
    stackname=$(echo $templatename |cut -d. -f1)
    templatepath=$folder$templatename
    cloudformationurl="https://$region.console.aws.amazon.com/cloudformation/home?region=$region#/stacks/create/review"
    templateurl="https://s3.$region.amazonaws.com/$bucketname/$templatepath"
    stackreviewurl="$cloudformationurl?templateURL=$templateurl&stackName=$stackname"
    stackreviewlink="<a href='$stackreviewurl' target='_blank'>CREATE STACK $stackname</a>"
    templatedownloadlink="[download-template]($templateurl)"
    architecturediagramlink="[view-architecture-diagram](../architecture-diagrams/ec2/one-ec2-instance-with-latest-ami.png)"
    echo "$stackreviewlink | $templatedownloadlink | $architecturediagramlink" >> $readmefile
  done
done
