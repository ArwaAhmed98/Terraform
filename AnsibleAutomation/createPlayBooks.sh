# this file install open-jdk-8, docker-cli, and copy agent.jar on the privatec2 instance which is already connected to jenkis as a slave
mkdir -p /var/jenkins_home/ansible/
cat << EOF > inventory
[host]
private_instance
[Java_Group]  
${private_instance} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=~/.ssh/private_key.pem  ansible_python_interpreter=/usr/bin/python3
EOF
cat << EOF > ansible.cfg
[defaults]
inventory = hosts
remote_user = ubuntu
[privilege_escalation]
become=True
become_method=sudo
become_user=root
become_ask_pass=False
EOF
# playbook to install open-jdk-8
cat << EOF > installjava.yml
- hosts: Java_Group

  tasks:
  - name: Update APT package manager repositories cache
    become: true
    apt:
      update_cache: yes

  - name: Install OpenJDK Java
    become: yes
    apt:
      name: "{{ item }}"
      state: present
    with_items:
     openjdk-8-jdk
EOF
# install docker-CLI
cat << EOF > docker.yml
    ---
- hosts: all
  become: true
  vars:
    container_count: 4
    default_container_name: docker
    default_container_image: ubuntu
    default_container_command: sleep 1d

  tasks:
    - name: Install aptitude
      apt:
        name: aptitude
        state: latest
        update_cache: true

    - name: Install required system packages
      apt:
        pkg:
          - apt-transport-https
          - ca-certificates
          - curl
          - software-properties-common
          - python3-pip
          - virtualenv
          - python3-setuptools
        state: latest
        update_cache: true

    - name: Add Docker GPG apt Key
      apt_key:
        url: https://download.docker.com/linux/ubuntu/gpg
        state: present

    - name: Add Docker Repository
      apt_repository:
        repo: deb https://download.docker.com/linux/ubuntu focal stable
        state: present

    - name: Update apt and install docker-ce
      apt:
        name: docker-ce
        state: latest
        update_cache: true

    - name: Install Docker Module for Python
      pip:
        name: docker

    - name: Pull default Docker image
      community.docker.docker_image:
        name: "{{ default_container_image }}"
        source: pull

    - name: Create default containers
      community.docker.docker_container:
        name: "{{ default_container_name }}{{ item }}"
        image: "{{ default_container_image }}"
        command: "{{ default_container_command }}"
        state: present
      with_sequence: count={{ container_count }}
EOF
# copy agent.jar in order to connect ec2 as a slave 
cat << EOF > copyagent.yml
- name: Ansible Copy Example Local to Remote
  hosts: Java_Group
  tasks:
    - name: copying file with playbook
      become: true 
      copy:
        src: agent.jar
        dest: /home/ubuntu/agent.jar
EOF