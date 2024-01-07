
# make jenkins-controller efs_id="XXX" region="us-west-2"
.PHONY jenkins-controller
jenkins-controller:
	packer build -var "efs_mount_point=$(efs_id).efs.$(region).amazonaws.com" jenkins-controller.pkr.hcl