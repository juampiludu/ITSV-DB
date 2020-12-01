import redis

REDIS_PORT = 6379
REDIS_HOST = 'localhost'

r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, db=0)

print(r.ping())

p = r.pubsub()
p.subscribe('Channel')
r.publish('Channel', 'First message')
print(p.get_message())
