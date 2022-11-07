# https://hub.docker.com/r/opensearchproject/opensearch
FROM opensearchproject/opensearch:1.3.6

RUN opensearch-plugin install --batch analysis-icu analysis-kuromoji

# https://opensearch.org/docs/1.3/opensearch/install/docker/#sample-docker-composeyml
ENV OPENSEARCH_JAVA_OPTS="-Xms512m -Xmx512m" \
    bootstrap.memory_lock="true" \
    cluster.name="docker-cluster" \
    discovery.type="single-node" \
    http.cors.allow-origin="*" \
    http.cors.enabled="true" \
    http.host="0.0.0.0" \
    indices.breaker.fielddata.limit="50%" \
    indices.fielddata.cache.size="40%" \
    logger.deprecation.level="warn" \
    transport.host="127.0.0.1" \
    DISABLE_INSTALL_DEMO_CONFIG="true" \
    DISABLE_SECURITY_PLUGIN="true"

HEALTHCHECK --interval=10s --timeout=30s --retries=10 CMD curl --ipv4 --fail http://127.0.0.1:9200/_cluster/health || exit 1
