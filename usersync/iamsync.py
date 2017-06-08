"""
iamsync.py
Given a list of IAM Groups, this script syncs user memberships between IAM and
the local unix group of the same name. Users found in the local group but not in
the IAM group are removed. Users found in the IAM group but not in the local
unix group are created if needed and added to the group's membership.
Usage:
    iamsync.py <iamgroups>
"""

import boto3, pwd, os, grp
from docopt import docopt

def get_local_group_membership(groupname):
    try:
        return grp.getgrnam(groupname)[3]
    except KeyError:
        print('Group {} does not exist.'.format(groupname))
    except Exception as e:
        print e

def create_user(username):
    try:
        os.system(
            "useradd -s /bin/bash -md /home/{} {}".format(
                username, username
            )
        )
    except Exception as e:
        print e

def check_if_user_exists(username):
    try:
        check = pwd.getpwnam(username)
        return True
    except KeyError:
        return False

def remove_user_from_group(username, groupname):
    try:
        os.system(
            "gpasswd -d {} {}".format(
                username, groupname
            )
        )
    except Exception as e:
        print e

def add_user_to_group(username, groupname):
    try:
        os.system(
            "usermod -aG {} {}".format(
                groupname, username
            )
        )
    except Exception as e:
        print e

def get_iam_group_membership(groupname):
    try:
        users = []
        iam = boto3.resource('iam')
        group = iam.Group(groupname)
        for u in group.users.all():
            users.append(u.name)
        return users
    except Exception as e:
        print e

if __name__ == '__main__':
    
    # Parse Docopts
    args = docopt(__doc__)
    iamgroups = args['<iamgroups>']

    print iamgroups

    for group in iamgroups.split(','):

        # Determine memberships in IAM and locally
        iamusers = get_iam_group_membership(group)
        print iamusers

        localusers = get_local_group_membership(group)
        print localusers

        # List of users we want to purge from the group
        subtract = []

        # If user exists locally but is not in IAM group
        # Add to subtract list
        for u in localusers:
            if u not in iamusers:
                subtract.append(u)
        
        # Perform subtraction
        if subtract:
            for u in subtract:
                remove_user_from_group(u, group)

        # If user exists in IAM but not locally, create and append to group        
        for u in iamusers:
            if u not in localusers:
                if not check_if_user_exists(u):
                    create_user(u)
                add_user_to_group(u, group)

