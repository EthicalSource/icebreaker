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

    def get_projects(organization)
      projects = client.query(
        OrgProjectFetcher::QUERY_SCHEMA,
        variables: {
          organization_name: organization.name.downcase,
        }
      ).data
    end

  end

  QUERY_SCHEMA = client.parse <<-'GRAPHQL'
    query($organization_name: String!) {
      organization(login: $organization_name) {
        nodes {
          repository
        }
      }
    }
  GRAPHQL

end
