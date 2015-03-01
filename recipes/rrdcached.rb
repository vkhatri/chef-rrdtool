#
# Cookbook Name:: rrdtool
# Recipe:: config
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

platform_sysconfig = value_for_platform_family(
  'rhel' => '/etc/sysconfig',
  'debian' => '/etc/default'
)

template ::File.join(platform_sysconfig, 'rrdcached') do
  source 'sysconfig.rrdcached.erb'
  owner 'root'
  group 'root'
  mode 0744
  notifies :restart, 'service[rrdcached]', :delayed
  variables(:group => node['rrdtool']['group'],
            :user => node['rrdtool']['user'],
            :timeout => node['rrdtool']['timeout'],
            :delay => node['rrdtool']['delay'],
            :flush_timer => node['rrdtool']['flush_timer'],
            :write_threads => node['rrdtool']['write_threads'],
            :home_dir => node['rrdtool']['home_dir'],
            :rrdcached_dir => node['rrdtool']['rrdcached_dir'],
            :listen => node['rrdtool']['listen'],
            :perms => '0660',
            :journal_dir => node['rrdtool']['journal_dir'],
            :options => node['rrdtool']['options']
           )
  only_if { node['rrdtool']['setup_rrdcached'] }
end

template '/etc/init.d/rrdcached' do
  source "init.rrdcached.#{node['platform_family']}.erb"
  owner 'root'
  group 'root'
  mode 0744
  notifies :restart, 'service[rrdcached]', :delayed
  variables(:home_dir => node['rrdtool']['home_dir'], :rrdcached_bin => node['rrdtool']['rrdcached_bin'])
  only_if { node['rrdtool']['setup_rrdcached'] }
end

service 'rrdcached' do
  supports :restart => true
  action [:enable, :start]
  only_if { node['rrdtool']['setup_rrdcached'] }
end
