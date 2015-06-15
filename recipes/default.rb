#
# Cookbook Name:: scalex
# Recipe:: default
#
# Copyright 2015, Andrey Linko
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

include_recipe 'nodejs'
include_recipe 'postgresql'
include_recipe 'xml::ruby'
include_recipe 'imagemagick'
include_recipe 'imagemagick::devel'

ppa 'brightbox/ruby-ng'

package 'ruby2.2'
package 'ruby2.2-dev'
package 'pdftk'
package 'mdbtools'
package 'mdbtools-dev'

gem_package 'pg'
gem_package 'bundler'

locales 'ru_RU.UTF-8' do
  action :add
end

remote_file '/usr/local/bin/docker-compose' do
  source "https://github.com/docker/compose/releases/download/1.2.0/docker-compose-#{node['kernel']['name']}-#{node['kernel']['machine']}"
  mode 0755
end

directory '/home/ubuntu/workspace/autohub' do
  recursive true
  owner 'ubuntu'
  mode 0755
end

bash 'init repository' do
  cwd '/home/ubuntu/workspace/autohub'
  user 'ubuntu'
  code <<-EOH
    git init
    git remote add origin https://github.com/scalex/autohub.git
  EOH
  not_if { ::File.exist? '/home/ubuntu/workspace/autohub/.git' }
end

template '/home/ubuntu/workspace/autohub/.env' do
  owner 'ubuntu'
  source '.env.erb'
end
