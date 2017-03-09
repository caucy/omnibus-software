name "paramiko"
default_version "1.15.2"

dependency "python"
dependency "pip"

build do
  ship_license "https://raw.githubusercontent.com/paramiko/paramiko/master/LICENSE"
  command "#{install_dir}/embedded/bin/pip install --install-option=\"--install-scripts=#{install_dir}/bin\" #{name}==#{version}"
end
