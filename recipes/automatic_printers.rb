#
# Cookbook Name:: printers_management
# Recipe:: automatic_printers
#
# Copyright 2011 Junta de Andalucía
#
# Author::
#  * David Amian Valle <damian@emergya.com>
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

service "cups" do
  action :restart
end

package 'python-cups' do
  action :nothing
end.run_action(:install)
package 'cups-driver-gutenprint' do
  action :nothing
end.run_action(:install)
node["automatic_printers"]["printers_spa"].each do |attributes|
  name = attributes['name']
  av_printers=data_bag_item('available_printers', name)
  make = av_printers['make']
  model = av_printers['model']
  ppd = av_printers['ppd']
  uri = av_printers['uri']
  ppd_uri = av_printers['ppd_uri']
  if (ppd_uri != nil and ppd_uri != '') and (ppd != nil and ppd != '')
    FileUtils.mkdir_p("/usr/share/ppd/#{make}/#{model}")   
    remote_file "/usr/share/ppd/#{make}/#{model}/#{ppd}" do
      source ppd_uri
      mode "0644"
    end
  end
  script "install_printer" do
    interpreter "python"
    user "root"
    code <<-EOH
import cups
connection=cups.Connection()
drivers = connection.getPPDs(ppd_make_and_model='#{make} #{model}')
ppd = '#{ppd}'
if ppd != '':
    for key in drivers.keys():
        if key.startswith('lsb/usr') and key.endswith('#{model}/'+ppd):
            ppd = key

if ppd == '':
    ppd = drivers.keys()[0]
    
connection.addPrinter('#{name}',ppdname=ppd, device='#{uri}')
connection.enablePrinter('#{name}')

    EOH
  end
end
