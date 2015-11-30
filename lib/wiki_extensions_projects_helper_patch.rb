# Wiki Extensions plugin for Redmine
# Copyright (C) 2009-2011  Haruyuki Iida
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

module WikiExtensionsProjectsHelperPatch
  def self.included(base)
    base.class_eval do
      alias_method_chain :project_settings_tabs, :wiki_extensions
    end
  end

  def project_settings_tabs_with_wiki_extensions
    project_settings_tabs_without_wiki_extensions.tap do |tabs|
      if User.current.allowed_to?(:wiki_extensions_settings, @project)
        tabs.push({
          :name => 'wiki_extensions',
          :partial => 'wiki_extensions_settings/show',
          :action => :wiki_extensions_settings,
          :label => :wiki_extensions
        })
      end
    end
  end
end


