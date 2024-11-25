# 使用 WildFly 19.1 基础镜像
FROM docker.io/jboss/wildfly:19.1.0.Final


USER root
# 创建 SSL 目录并复制证书
RUN mkdir -p /opt/jboss/wildfly/ssl
COPY ssl/application.keystore /opt/jboss/wildfly/ssl/

# 部署应用
COPY ssl/ROOT.war /opt/jboss/wildfly/standalone/deployments/
COPY ssl/standalone.xml /opt/jboss/wildfly/standalone/configuration/

# 配置权限
RUN chmod 600 /opt/jboss/wildfly/ssl/application.keystore && \
    chown jboss:jboss /opt/jboss/wildfly/ssl/application.keystore

# 暴露 HTTPS 端口
EXPOSE 8443

# 启动 WildFly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
