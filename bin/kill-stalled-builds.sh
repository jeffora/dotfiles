#!/bin/bash
set -euvo pipefail

# Kill all stalled pipelines
PIPELINE_QUERY=$(curl 'https://graphql.buildkite.com/v1' \
  -H 'authority: graphql.buildkite.com' \
  -H 'accept: */*' \
  -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8' \
  -H "authorization: Bearer ${BUILDKITE_TOKEN}" \
  -H 'content-type: text/plain;charset=UTF-8' \
  -H 'origin: https://buildkiteassets.com' \
  -H 'referer: https://buildkiteassets.com/' \
  -H 'sec-ch-ua: "Chromium";v="118", "Google Chrome";v="118", "Not=A?Brand";v="99"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: cross-site' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36' \
  --data-raw $'{"query":"\\n\\n# Welcome to the Buildkite GraphQL Explorer\\n#\\n# This is an in-browser IDE for writing, validating, and\\n# testing GraphQL queries on https://graphql.buildkite.com/v1\\n#\\n# Type queries into this side of the screen, and you will\\n# see intelligent typeaheads aware of the current GraphQL type schema and\\n# live syntax and validation errors highlighted within the text.\\n#\\n# To bring up the auto-complete at any point, just press Ctrl-Space.\\n#\\n# Press the run button above, or Cmd-Enter to execute the query, and the result\\n# will appear in the pane to the right.\\n#\\n# Here is a simple GraphQL query that will request your name and avatar URL\\n\\nquery LastProd {\\n  pipeline(slug:\\"agriwebb-1/sync-performance-test\\") {\\n    id\\n    slug\\n    builds(first:100,branch:[\\"main\\"],state:[SCHEDULED]) {\\n      edges{\\n        node {\\n          id\\n          number\\n        }\\n      }\\n    }\\n  }\\n}\\n\\n# mutation CancelBuild {\\n#   buildCancel(input:{ id:\\"QnVpbGQtLS0wMThiNWIxZS1mNzFmLTRjNjctOTNmNy0xNjM3NzRlZTEyYTk=\\" }) {\\n#     build {\\n#       id\\n#     }\\n#   }\\n# }\\n\\n\\n# Here is a slightly more complex GraphQL query that will request not only your\\n# name, but the latest 10 builds for each of the build pipelines you can access.\\n# To run this query, you\'ll first need to remove the one above, then uncomment this\\n# one.\\n#\\n# query ComplexQuery {\\n#   viewer {\\n#     user {\\n#       name\\n#     }\\n#     organizations {\\n#       edges {\\n#         node {\\n#           name\\n#           pipelines {\\n#             edges {\\n#               node {\\n#                 name\\n#                 repository\\n#                 builds(first: 10) {\\n#                   edges {\\n#                     node {\\n#                       number\\n#                       message\\n#                     }\\n#                   }\\n#                 }\\n#               }\\n#             }\\n#           }\\n#         }\\n#       }\\n#     }\\n#   }\\n# }","variables":null,"operationName":"LastProd"}' \
  --compressed)

PIPELINE_SLUG=$(echo "$PIPELINE_QUERY" | jq -r '.data.pipeline.slug')
BUILDS=$(echo "$PIPELINE_QUERY" | jq -r '.data.pipeline.builds.edges[] | .node.number')
CANCEL_URL_PREFIX="https://api.buildkite.com/v2/organizations/agriwebb-1/pipelines/$PIPELINE_SLUG/builds"
# CANCEL_URL_PREFIX="https://api.buildkite.com/v2/organizations/agriwebb-1/pipelines/$PIPELINE_SLUG/builds/{number}/cancel

for b in $BUILDS; do
  echo "cancelling build #$b"
  curl -X PUT "${CANCEL_URL_PREFIX}/${b}/cancel" -H "Authorization: Bearer ${BUILDKITE_TOKEN}"
done

echo "Done"
