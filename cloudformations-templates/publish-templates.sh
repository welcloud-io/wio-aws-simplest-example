bucketname='welcloud.io.aws-simplest-example'
folder='ec2'
templatename='one-ec2-instance-with-latest-ami.template.yaml'

region='eu-west-1'
readmefile='../readme.md'
cat << EOF > $readmefile
### Ready to use Cloudformation templates
###### !! These templates may incur (small) costs !!
###### !! You should delete them when done !!
---
#### Region = eu-west-1 (Ireland)
#### VPC = Default
---
EOF

for folder in $(ls -d */); do
for templatename in $(ls $folder); do 
aws s3 cp $folder$templatename s3://$bucketname/cloudformation-templates/$folder$templatename

stackname=$(echo $templatename |cut -d. -f1)
cloudformationurl="https://$region.console.aws.amazon.com/cloudformation/home?region=$region#/stacks/create/review"
templateurl="https://s3.$region.amazonaws.com/$bucketname/cloudformation-templates/$folder$templatename"
stackreviewurl="$cloudformationurl?templateURL=$templateurl&stackName=$stackname"

echo "<a href='$stackreviewurl' target='_blank'>CREATE STACK $stackname</a> | [download-template]($templateurl)" >> $readmefile
done
done
