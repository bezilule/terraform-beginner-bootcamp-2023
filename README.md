# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructiions have changed due to gpg keyring changes. So we needed refer to the latest install CLI instructions via TerraformDocumentation and change the scripting for install. 

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution 

This project is built against Ubuntu. 
Please consider checking your Linux Distirbution and change accordingly to distribution needs. 

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:

```
cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```
### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprciation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash scripts is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portablity for other projects that need to install Terraform CLI.


#### Shebang Considerations

A Shebang (pronounced She-bang) tells the bash script what program that will interpret the script. Eg. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability for different os distributions
- will serarch the user's PATH for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations 
When execiting the bash screipt we can use the  `./` shorthand notation to execute the bash script. 

eg. `./bin/instal_terraform_cli`

If we are using a scrip in .gitpod.yml, we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

`
#### Linux Permission Considerations 

In order to make our bash scripts executable we need to change linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_Terraform_cli
```

Alternatively:

```sh
cmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### GitHub Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working Env Vars

We can list out all Evnironment Variables (Env Vars) using the `env`

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using export `export HELLO=world`

In the terrminal we can unset using `unset HELLO`

We can set an env var temporarly whe just running a command

```sh
HELLO=`world` ./bin/print_message
```

```sh
#!/usr/bin/env bash

HELLO=`world`

echo $HELLO
```

## Priniting Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want to Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```

All future workspaces launced will set the env vars for all bas terminals opened in thoes workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensetive env vars.

### AWS CLI is installlation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli'](.bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)


We cam check if our AWS credentials is configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If is is succesfull you should see a json payload return that looks like this:

```json
{       "UserId": "BIJA8LBVC6NWKCJESQ7F4",
        "Account": "555888777222",
        "Arn": "arn:aws:iam::888777888444:user/terraform-bootcamp"
}
```

We'll need to generate AWS CLI credits from IAM user in ourder to the user AWS CLI.

## Terraform Basics

### Teraform Registery 

Terraform source their profiders and modules from the Terraform registry which located at [registery.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in terraform.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`

#### Terraform Init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project.

#### Terraform Plan

`terraform plan`

This will generate out a changeset, about the state of our infrastucture and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be excute by terraform. Apply should prompt yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`
#### Terraform Destroy

`terraform destroy`

You can also use the auto approve flag to skip the approve prompt
eg. `terrraform apply --auto-approve`

#### Terrafrom Lock Files

`terraform.lock.hcl` contains the locked versiong for the providers or modulues that should be used with this project.

The Terraform Lock file **should be committed** to your Version Control System (VSC) eg. GitHub.

### Terraform State Files

`terraform.tfstate` contain information abut the current state of your sensitive data.

If you lose this file, you lose knowning the stat of your infrastructure.

`terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers.