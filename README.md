[![Docker Image Stars](https://img.shields.io/docker/stars/ergomentum/letsencrypt-ovh.svg)](
  https://hub.docker.com/r/ergomentum/letsencrypt-ovh/)
[![Docker Image Pulls](https://img.shields.io/docker/pulls/ergomentum/letsencrypt-ovh.svg)](
  https://hub.docker.com/r/ergomentum/letsencrypt-ovh/)

# Ergomentum Let's Encrypt Client for OVH DNS challange
Provides a client to create, renew or revoke a [Let's encrypt](https://letsencrypt.org/) certificate for a single
domain hosted at [OVH](https://www.ovh.de/) registrar powered by the [Let's Encrypt Go client (lego)](
https://github.com/xenolf/lego).

## Volumes
None.

OR

<dl>
  <dt><code>/target</code></dt>
  <dd>Where the <code>accounts</code> and <code>certificates</code> directories with the private key and the certificate
  will be stored.</dd>
</dl>

## Environment Variables
_Warning:_ Keep in mind ["that all environment variables originating from Docker within a container are made available
to any container that links to it. This could have serious security implications if sensitive data is stored in them."](
https://docs.docker.com/engine/userguide/networking/default_network/dockerlinks/)
As a consequence it is strictly recommended to prefer a [user defined network](
https://docs.docker.com/engine/userguide/networking/dockernetworks/#user-defined-networks) to [legacy container links](
https://docs.docker.com/engine/userguide/networking/default_network/dockerlinks/) for maximum isolation.

<dl>
  <dt><code>DOMAIN</code></dt>
  <dd>The domain to get the certificate for.</dd>
</dl>

<dl>
  <dt><code>EMAIL</code></dt>
  <dd>Optional. By default <code>hostmaster@${DOMAIN}</code> is used.</dd>
</dl>

<dl>
  <dt><code>STAGING</code></dt>
  <dd>Optional. If set to <code>true</code> the Let's Encrypt staging server is used instead of the production server.</dd>
</dl>

## Exposed Ports
None.

## Configuration
If a configuration file is used, describe it here.

## Usage
Use this image to run a temporary container.

### Getting the OVH credentials
1. Create the [`OVH_APPLICATION_KEY` and `OVH_APPLICATION_SECRET`](https://api.ovh.com/g934.first_step_with_api).
2. Request the `OVH_CONSUMER_KEY`:
```bash
curl \
-XPOST \
-H"X-Ovh-Application: your_ovh_appliction_key" \
-H "Content-type: application/json" \
https://eu.api.ovh.com/1.0/auth/credential -d '{
  "accessRules": [
    {
      "method": "GET",
      "path": "/*"
    },
    {
      "method": "POST",
      "path": "/*"
    },
    {
      "method": "PUT",
      "path": "/*"
    },
    {
      "method": "DELETE",
      "path": "/*"
    }
  ],
  "redirection": "https://www.example.com/"
}'
```

### Create private key and certificate
```bash
docker \
  run \
  --rm \
  -e OVH_APPLICATION_KEY="your_ovh_application_key" \
  -e OVH_APPLICATION_SECRET="your_ovh_application_secret" \
  -e OVH_CONSUMER_KEY="your_ovh_consumer_key" \
  -e STAGING="true" \
  -e DOMAIN="your_domain" \
  -v "${PWD}:/target" \
  ergomentum/letsencrypt-ovh \
  run
```

### Renew certificate
```bash
docker \
  run \
  --rm \
  -e OVH_APPLICATION_KEY="your_ovh_application_key" \
  -e OVH_APPLICATION_SECRET="your_ovh_application_secret" \
  -e OVH_CONSUMER_KEY="your_ovh_consumer_key" \
  -e STAGING="true" \
  -e DOMAIN="your_domain" \
  -v "${PWD}:/target" \
  ergomentum/letsencrypt-ovh \
  renew
```

### Revoke certificate
```bash
docker \
  run \
  --rm \
  -e OVH_APPLICATION_KEY="your_ovh_application_key" \
  -e OVH_APPLICATION_SECRET="your_ovh_application_secret" \
  -e OVH_CONSUMER_KEY="your_ovh_consumer_key" \
  -e STAGING="true" \
  -e DOMAIN="your_domain" \
  -v "${PWD}:/target" \
  ergomentum/letsencrypt-ovh \
  revoke
```

## Contributing
To contribute a feature or a bugfix please open a [pull request](https://github.com/ergomentum/letsencrypt-ovh/pulls) on
[GitHub](https://github.com/ergomentum/letsencrypt-ovh/).

See [CONTRIBUTING](https://github.com/ergomentum/letsencrypt-ovh/blob/master/CONTRIBUTING.md) for details.

## License
See the [LICENSE](https://github.com/ergomentum/letsencrypt-ovh/blob/master/LICENSE.md) file for license rights and
limitations (Apache License, Version 2.0).

## References
None.
