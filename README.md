# Gradle build environment

Build a gradle project by running

```
docker run --rm -v `pwd`:/project -u `id -u`:`id -g` metahelicase/gradle build
```

The container arguments are passed directly to gradle.
The default one is `--version`.

### Command options

`--rm`: removes the container after the build.

``-v `pwd`:/project`` (__required__): maps the build location inside the container to the current directory on the host.
You can specify the absolute path of the project instead of using the `pwd` command.

``-u `id -u`:`id -g` ``: executes the build with the host user id and group id.
The generated build artifacts are owned by the user declared by the `-u` option.
The user id and group id must be numbers, not the names that identify them.
If not specified, the default user is `root` (`0:0`).

### Dependency cache

The project dependencies are stored under the project folder, inside the `.gradle/caches` directory.
After the first build, the container's gradle uses the stored dependencies instead of downloading them again.
