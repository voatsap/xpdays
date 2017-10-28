#!/bin/bash

java_config_file=/usr/share/tomcat8/bin/setenv.sh
java_additional_params=$@

cat > ${java_config_file}  << EOF
JAVA_OPTS="\$JAVA_OPTS ${java_additional_params}"
EOF
