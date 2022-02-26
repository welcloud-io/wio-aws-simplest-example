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
##### - Assume that you are using an admin user or role (in a sanbox or dev account)
---
---
| Simplest Example Stack |  Template | Diagram |
| --- | --- | --- |
EOF

for folder in $(ls ./cloudformation-templates); do
  for templatename in $(ls ./cloudformation-templates/$folder); do
    stackname=$(echo $templatename |cut -d. -f1)
    templatepath="cloudformation-templates/$folder/$templatename"
    
    # Create stack creation link
    cloudformationurl="https://$region.console.aws.amazon.com/cloudformation/home?region=$region#/stacks/create/review"
    templateurl="https://s3.$region.amazonaws.com/$bucketname/$templatepath"
    stackreviewurl="$cloudformationurl?templateURL=$templateurl&stackName=$stackname"
    stackreviewlink="<a href='$stackreviewurl' target='_blank'>CREATE STACK $stackname</a>"
    
    # Create stack creation link
    templatedownloadlink="[download-template]($templateurl)"
    
    # Create architecture diagram link
    architecturediagrampath="architecture-diagrams/$folder/$stackname.png"
    architecturediagramurl="https://s3.$region.amazonaws.com/$bucketname/$architecturediagrampath"
    architecturediagramlink="[view-architecture-diagram]($architecturediagramurl)"
   
    # Add links to readme file 
    echo "| $stackreviewlink | $templatedownloadlink | $architecturediagramlink |" >> $readmefile
  done
done
