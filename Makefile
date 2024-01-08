
# make jenkins-controller efs_id="XXX" region="us-west-2"
.PHONY jenkins-controller
jenkins-controller:
	packer build -var "efs_mount_point=$(efs_id).efs.$(region).amazonaws.com" jenkins-controller.pkr.hcl

# make jenkins-agent
.PHONY jenkins-agent
jenkins-agent:
	packer build -var "public_key_path=/devops-tools/jenkins/id_rsa.pub" jenkins-agent.pkr.hcl