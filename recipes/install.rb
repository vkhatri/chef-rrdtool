#
# Cookbook Name:: rrdtool
# Recipe:: install
#
# Copyright 2014, Virender Khatri
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

packages = value_for_platform_family(
  'debian' => %w(make rrdtool librrds-perl g++ php5-cli php5-gd libapache2-mod-php5),
  'rhel' => %w(php php-gd php-pdo php-common php-devel rrdtool rrdtool-devel perl-Time-HiRes libtool-ltdl rrdtool-php rrdtool-perl)
)

[node['rrdtool']['home_dir'],
 node['rrdtool']['rrdcached_dir'],
 node['rrdtool']['journal_dir']
].each do |d|
  directory d do
    owner node['rrdtool']['user']
    group node['rrdtool']['group']
    mode node['rrdtool']['perms']
  end
end

packages.each do |p|
  package p
end
