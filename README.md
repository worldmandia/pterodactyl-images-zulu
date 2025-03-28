## Pelican/Pterodactyl/WISP Docker Images

Docker images that can be used with the Pelican/Pterodactyl/WISP Game Panel. You can request more images by opening a new issue. These are mostly created for myself.

Additional Pterodactyl images can be found at [Parkervcp](https://github.com/parkervcp/images), [Matthewpi](https://github.com/matthewpi/images) and [Yolks](https://github.com/pterodactyl/yolks) repositories.

## How to add image to your egg

Navigate to `Admin Panel -> Nests -> Select your egg`. Add Docker image URL(s) from the [available list](https://github.com/trenutoo/pterodactyl-images#pterodactylwisp-images) into the Docker Images section.

![image](https://user-images.githubusercontent.com/10975908/120903180-56719d80-c64d-11eb-8666-02de8ea80701.png)

### Supported Platforms

| Image                                                                                      | Supported platforms |
|--------------------------------------------------------------------------------------------|---------------------|
| [Java Azul Zulu](https://github.com/trenutoo/pterodactyl-images#java-azul-zulu-amd64arm64) | AMD64, ARM64        |
| [Java GraalVM](https://github.com/trenutoo/pterodactyl-images#java-graalvm-amd64arm64)     | AMD64, ARM64        |

### Java Azul Zulu [AMD64/ARM64]

- [Java 24 Zulu](https://github.com/trenutoo/pterodactyl-images/tree/main/java-zulu/24)
  - `ghcr.io/worldmandia/pterodactyl-images:java_24_zulu`

### Java GraalVM [AMD64/ARM64]

- [Java 24 GraalVM JDK](https://github.com/trenutoo/pterodactyl-images/tree/main/java-graalvm/24)
  - `ghcr.io/worldmandia/pterodactyl-images:java_24_graalvm`