# builder-maven

This is a builder image that's used in Jenkins-X pipelines to build maven based projects.

The idea of a builder image is it contains tools required to build an image so we don't have to include them in the final image.

The builder image is referenced in a Jenkins kubernetes-plugin `containerTemplate` configuration. See https://github.com/jenkinsci/kubernetes-plugin#pod-and-container-template-configuration for more details.