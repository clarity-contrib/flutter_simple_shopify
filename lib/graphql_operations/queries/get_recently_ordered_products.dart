String getRecentlyOrderedProductsQuery(int variantsCount) {
  return '''
query getOrders(
  \$cursor: String
  \$x: Int
  \$sortKey: OrderSortKeys
  \$accessToken: String!
  \$reverse: Boolean
) {
  customer(customerAccessToken: \$accessToken) {
    id
    orders(first: \$x, after: \$cursor, sortKey: \$sortKey, reverse: \$reverse) {
      pageInfo {
        hasNextPage
      }
      edges {
        node {
          id
          processedAt
          canceledAt
          cancelReason
          financialStatus
          fulfillmentStatus
          lineItems(first: 10) {
            edges {
              node {
                title
                variant {
                  product {
                    id
                    title
                    handle
                    availableForSale
                    vendor
                    rating: metafield(namespace: "rview", key: "rating") {
                      key 
                      namespace 
                      value 
                      type 
                    }
                    review_count: metafield(namespace: "rview", key: "review-count") {
                      key 
                      namespace 
                      value 
                      type 
                    }
                    images(first: 1) {
                      edges {
                        node {
                          altText
                          id
                          originalSrc
                          transformedSrc(maxWidth: 400, crop: CENTER)
                        }
                      }
                    }
                    variants(first: $variantsCount) {
                      edges {
                        node {
                          id
                          title
                          availableForSale
                          quantityAvailable
                          requiresShipping
                          sku
                          priceV2 {
                            amount
                            currencyCode
                          }
                          compareAtPriceV2 {
                            amount
                            currencyCode
                          }
                          selectedOptions {
                            name
                            value
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          
        }
        cursor
      }
    }
  }
}
''';
}
