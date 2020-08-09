#!/bin/bash
ARTIFACT=`packer build -machine-readable ./ami/footgo_v1.json |awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" }' > amivar.tf
aws s3 cp amivar.tf s3://footgo-project-devops/ami/amivar.tf
