FROM eclipse-temurin:17-jre
ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar  isodevops.jar
ENTRYPOINT [ "java","-jar","isodevops.jar"]

