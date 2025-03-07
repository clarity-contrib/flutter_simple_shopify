const String getXProductsAfterCursorQuery = r'''
query($cursor: String, $x: Int, $reverse: Boolean, $sortKey: ProductSortKeys) {
  products(first: $x, after: $cursor, sortKey: $sortKey, reverse: $reverse) {
    pageInfo {
      hasNextPage
    }
    edges {
      cursor
      node {
        id
        handle
        title
        availableForSale
        tags
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
        variants(first: 1) {
          edges {
            node {
              id
              title
              sku
              availableForSale
              quantityAvailable
              requiresShipping
              image {
                altText
                id
                originalSrc
                transformedSrc(maxWidth: 400, crop: CENTER)
              }
              priceV2 {
                amount
                currencyCode
              }
              compareAtPriceV2 {
                amount
                currencyCode
              }
            }
          }
          pageInfo {
            hasNextPage
          }
        }
      }
    }
  }
}
''';
