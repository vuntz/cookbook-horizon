#
# Cookbook Name:: horizon
# Attributes:: default
#
# Copyright 2012, AT&T, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Set to some text value if you want templated config files
# to contain a custom banner at the top of the written file
default["horizon"]["custom_template_banner"] = "
# This file autogenerated by Chef
# Do not edit, changes will be overwritten
"

default["horizon"]["debug"] = false

# This user's password is stored in an encrypted databag
# and accessed with openstack-common cookbook library's
# db_password routine.
default["horizon"]["db"]["username"] = "dash"

# The Keystone role used by default for users logging into the dashboard
default["horizon"]["keystone_default_role"] = "Member"

# This is the name of the Chef role that will install the Keystone Service API
default["horizon"]["keystone_service_chef_role"] = "keystone"

default["horizon"]["use_ssl"] = true
default["horizon"]["ssl"]["cert"] = "horizon.pem"
default["horizon"]["ssl"]["key"] = "horizon.key"

default["horizon"]["swift"]["enabled"] = "False"

case node["platform"]
when "fedora", "centos", "redhat", "amazon", "scientific"
  default["horizon"]["ssl"]["dir"] = "/etc/pki/tls"
  default["horizon"]["local_settings_path"] = "/etc/openstack-dashboard/local_settings"
  # TODO(shep) - Fedora does not generate self signed certs by default
  default["horizon"]["platform"] = {
    "horizon_packages" => ["openstack-dashboard", "MySQL-python"],
    "package_overrides" => ""
  }
when "suse"
  default["horizon"]["ssl"]["dir"] = "/etc/ssl"
  default["horizon"]["local_settings_path"] = "/usr/share/openstack-dashboard/openstack_dashboard/local/local_settings.py"
  default["horizon"]["platform"] = {
    "horizon_packages" => ["openstack-dashboard", "python-mysql"],
    "package_overrides" => ""
  }
when "ubuntu", "debian"
  default["horizon"]["ssl"]["dir"] = "/etc/ssl"
  default["horizon"]["local_settings_path"] = "/etc/openstack-dashboard/local_settings.py"
  default["horizon"]["platform"] = {
    "horizon_packages" => ["lessc","openstack-dashboard", "python-mysqldb"],
    "package_overrides" => "-o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-confdef'"
  }
end

default["horizon"]["dash_path"] = "/usr/share/openstack-dashboard/openstack_dashboard"
default["horizon"]["stylesheet_path"] = "/usr/share/openstack-dashboard/openstack_dashboard/templates/_stylesheets.html"
default["horizon"]["wsgi_path"] = node["horizon"]["dash_path"] + "/wsgi/django.wsgi"
default["horizon"]["session_backend"] = "memcached"

default["horizon"]["ssl_offload"] = "false"
