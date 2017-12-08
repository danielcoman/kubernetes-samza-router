#!/usr/bin/env python
import kafka
c = kafka.KafkaConsumer(bootstrap_servers=['zk-cs.samza-router.svc.cluster.local:2181'])
zetopics = c.topics()
for x in zetopics:
    print x
