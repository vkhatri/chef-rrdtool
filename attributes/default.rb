
default['rrdtool']['user'] = 'nagios'
default['rrdtool']['group'] = 'nagios'
default['rrdtool']['perms'] = '0774'
default['rrdtool']['timeout'] = 120
default['rrdtool']['flush_timer'] = 300
default['rrdtool']['delay'] = 120
default['rrdtool']['write_threads'] = 4

default['rrdtool']['rrdcached_bin'] = '/usr/bin/rrdcached'

default['rrdtool']['home_dir'] = '/var/rrdtool'
default['rrdtool']['rrdcached_dir'] = ::File.join(node['rrdtool']['home_dir'], 'cache')
default['rrdtool']['journal_dir'] = ::File.join(node['rrdtool']['home_dir'], 'journal')

default['rrdtool']['listen'] = "unix:#{node['rrdtool']['home_dir']}/rrdcached.sock"

default['rrdtool']['options'] = []
