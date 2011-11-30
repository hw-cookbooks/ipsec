#
# Cookbook Name:: ipsec
# Recipe:: default
#
# Copyright 2011, Heavy Water Software Inc.
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

package "strongswan"

template "/etc/ipsec.conf" do
  source "ipsec.conf.erb"
  variables( :nat_traversal => node[:ipsec][:nat_traversal],
             :peers => search( :node, "recipes:ipsec AND NOT name:#{node.name}" ),
             :local_ip => node[:ipaddress] )
  notifies :reload, "service[ipsec]"
end

template "/etc/ipsec.secrets" do
  source "ipsec.secrets.erb"
  variables( :secret => node[:ipsec][:shared_secret] )
  notifies :reload, "service[ipsec]"
end

service "ipsec" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
