require "graphql/client"
require "graphql/client/http"

class DependencyFetcher
  class << self

    def http_client
      @http ||= GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
        def headers(context)
          {
            "Accept": "application/vnd.github.hawkgirl-preview+json",
            "Authorization": "token #{ENV['GITHUB_TOKEN']}"
          }
        end
      end
    end

    def schema
      @schema ||= GraphQL::Client.load_schema(http_client)
    end

    def client
      @client ||= GraphQL::Client.new(schema: schema, execute: http_client)
    end

    def get_dependencies(project)
      organization = project.organization
      return unless manifests = client.query(
        DependencyFetcher::QUERY_SCHEMA,
        variables: {
          repository_owner: organization.name,
          repository_name: project.name,
        }
      ).data.repository.dependency_graph_manifests.nodes
      manifests.map do |manifest|
        manifest.dependencies.nodes.each do |dependency_response|
          package_manager = PackageManager.includes(:language).find_or_create_by!(
            name: dependency_response.package_manager
          )

          dependency = Dependency.find_or_create_by!(
            name: dependency_response.package_name,
            package_manager: package_manager,
            language: package_manager.language.name
          )

          project.dependency_instances.find_or_create_by!(
            dependency: dependency,
          ).update!(version: dependency_response.requirements)
        end
      end
    end
  end

  QUERY_SCHEMA = client.parse <<-'GRAPHQL'
    query($repository_owner: String!, $repository_name: String!) {
      repository(owner: $repository_owner, name: $repository_name) {
        dependencyGraphManifests {
          nodes {
            filename
            dependencies {
              nodes {
                packageName
                packageManager
                requirements
              }
            }
          }
        }
      }
    }
  GRAPHQL

end
