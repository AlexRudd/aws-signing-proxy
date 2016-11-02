aws-signing-proxy
=================

aws-signing-proxy is a proxy service, written in go, for automatically signing requests made to AWS endpoints.  It leverages the aws-sdk-go library to sign requests to arbitrary URLs in AWS.  I wrote it to connect a kibana instance to an AWS Elasticsearch cluster using an IAM role instead of hard-coding IPs in the access policy.  Other uses may exist.

## Usage

Run as a binary:
```
export AWS_ACCESS_KEY_ID=<xxx>
export AWS_SECRET_ACCESS_KEY=<xxx>
export AWS_REGION=<xxx>
./aws-signing-proxy -target https://search-my-cluster.us-west-2.es.amazonaws.com
```

Run as a Docker container:
```
docker run --name=aws-signing-proxy \
  -e "AWS_ACCESS_KEY_ID=<xxx>" \
  -e "AWS_SECRET_ACCESS_KEY=<xxx>" \
  -e "AWS_REGION=<xxx>" \
  -p 8080:8080 \
  cllunsford/aws-signing-proxy \
  -target https://search-my-cluster.us-west-2.es.amazonaws.com
```

If no environment variables are specified, the application will look for an [IAM Instance Profile Role](http://docs.amazonaws.cn/en_us/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html) in its ec2 Metadata.

## Notes, Tips

### Signature Expired

If you see:

`{"message":"Signature expired: 20160415T172935Z is now earlier than 20160415T174424Z (20160415T174924Z - 5 min.)"}`

verify that the clock/time is in sync on the proxy host.

### Kibana Forbidden index write

For AWS Elasticsearch, the built-in kibana populates the .kibana index.  If you see:

`ClusterBlockException[blocked by: [FORBIDDEN/8/index write (api)];]`

try changing the kibana index setting to use a different index.  The [marcbachmann/kibana4](https://github.com/marcbachmann/dockerfile-kibana4) docker image allows you to change this easily by setting the ```KIBANA_INDEX``` environment variable.


## License

MIT 2016 (c) Chris Lunsford
