require "graphql/client"
require "graphql/client/http"

class OrgProjectFetcher

  class << self

    def http_client
      @http ||= GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
        def headers(context)
          {
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

    # Fetches the first 500 public projects under the specified organization
    def get_projects(organization)
      projects = []
      cursor = nil
      5.times do |i|
        response = client.query(
          OrgProjectFetcher::QUERY_SCHEMA,
          variables: {
            organization_name: organization.name.downcase,
            cursor: cursor
          }
        ).data
        projects << response.organization.repositories.nodes
        cursor = response.organization.repositories.edges.last&.cursor
      end
      projects.flatten.each do |project|
        project = Project.find_or_create_by(
          name: project.name,
          repo_url: project.url,
          org_name: project.owner.login,
          organization: organization
        )

        DependenciesFetcherJob.perform_later(project)
      end
      true
    end

  end

  QUERY_SCHEMA = client.parse <<-'GRAPHQL'
    query($organization_name: String!, $cursor: String) {
      organization(login: $organization_name) {
        repositories(first: 100, after: $cursor) {
          edges {
            cursor
          }
          nodes {
            name
            url
            owner {
              login
            }
          }
        }
      }
    }
  GRAPHQL

end
