# Contributing
## Build

```bash
cd build-haproxy-rpm
docker run --rm -v "${PWD}:/target" ergomentum/build-lego
docker build -t ergomentum/letsencrypt-ovh .
upstream_version="$(docker run --rm --entrypoint=lego ergomentum/letsencrypt-ovh --version)"
version="$(echo "${upstream_version}"|cut -d ' ' -f 3).$(date -u +'%y%m%d%H%M%S')"
git tag -a "${version}" -m "Change version number."
git push origin "${version}"
```

## Known issues
None.

## Conventions
See [Conventions](https://github.com/ergomentum/conventions).

## References
None.
