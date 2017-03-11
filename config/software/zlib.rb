#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
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

name "zlib"
default_version "1.2.11"

version "1.2.11" do
  source sha256: "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1"
end

version "1.2.8" do
  source md5: "44d667c142d7cda120332623eab69f40"
end

source url: "http://zlib.net/zlib-#{version}.tar.gz"

relative_path "zlib-#{version}"

# we omit the omnibus path here because it breaks mac_os_x builds by picking up the embedded libtool
# instead of the system libtool which the zlib configure script cannot handle.
#env = with_embedded_path()
env = with_standard_compiler_flags()
# for some reason zlib needs this flag on solaris (cargocult warning?)
env['CFLAGS'] << " -DNO_VIZ" if ohai['platform'] == 'solaris2'

build do
  ship_license "https://gist.githubusercontent.com/remh/77877aa00b45c1ebc152/raw/372a65de9f4c4ed376771b8d2d0943da83064726/zlib.license"
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make -j #{workers}", :env => env
  command "make -j #{workers} install", :env => env
end
