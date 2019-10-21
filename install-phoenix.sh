#!/bin/bash

wget $BUILD_REPO/apache-phoenix-$PHOENIX_VERSION-HBase-$HBASE_VERSION$BUILD_QUALIFIER/bin/apache-phoenix-$PHOENIX_VERSION-HBase-$HBASE_VERSION-bin.tar.gz

tar -xzf apache-phoenix-$PHOENIX_VERSION-HBase-$HBASE_VERSION-bin.tar.gz
mv apache-phoenix-$PHOENIX_VERSION-HBase-$HBASE_VERSION-bin /opt/
rm -f apache-phoenix-$PHOENIX_VERSION-HBase-$HBASE_VERSION-bin.tar.gz
ln -s /opt/apache-phoenix-$PHOENIX_VERSION-HBase-$HBASE_VERSION-bin /opt/phoenix

cp /opt/phoenix/phoenix-$PHOENIX_VERSION-HBase-$HBASE_VERSION-server.jar /opt/hbase/lib/
