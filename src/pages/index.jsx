import React from 'react'
import { Link, graphql } from 'gatsby'

import Layout from '../components/layout'
import SEO from '../components/seo'
import { rhythm } from '../utils/typography'

const BlogIndex = ({ data }) => {
  const siteTitle = data.site.siteMetadata.title
  const posts = data.allMarkdownRemark.edges
  return (
    <Layout>
      <SEO title={siteTitle} />
      {posts.map(({ node }) => {
        const title = node.frontmatter.title || node.fields.slug
        return (
          <article
            key={node.fields.slug}
            style={{
              display: 'flex',
              flexWrap: 'wrap',
              alignItems: 'baseline',
              marginBottom: rhythm(1 / 2),
            }}
          >
            <h3
              style={{
                margin: `0 ${rhythm(1 / 4)} 0 0`,
              }}
            >
              <Link to={node.fields.slug}>
                {title}
              </Link>
            </h3>
            <div style={{
              margin: 0,
              color: 'hsla(0, 0%, 0%, 0.59)',
            }}
            >
              {node.frontmatter.date}
            </div>
          </article>
        )
      })}
    </Layout>
  )
}

export default BlogIndex

export const pageQuery = graphql`
  query {
    site {
      siteMetadata {
        title
      }
    }
    allMarkdownRemark(sort: { fields: [frontmatter___date], order: DESC }) {
      edges {
        node {
          fields {
            slug
          }
          frontmatter {
            date(formatString: "MMMM DD, YYYY")
            title
          }
        }
      }
    }
  }
`
