#!/bin/sh

for controller in $(find app/ -name *_controller.rb); do
  controller_name=$(echo $controller | ruby -ne 'puts scan(/(\w+)_controller.rb/).delete(/s$/)')
  echo "fgrep \"def ${controller_name}_\" $controller"
  for method in $(fgrep "def ${controller_name}_" $controller | awk '{print $2}'); do
    echo "$controller: $method"
  done
done
