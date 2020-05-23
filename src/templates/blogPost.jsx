import React from 'react'
import { graphql } from 'gatsby'

import Utterances from 'utterances-react'

import Layout from '../components/layout'
import SEO from '../components/seo'
import { rhythm, scale } from '../utils/typography'

const BlogPostTemplate = ({ data: { markdownRemark: post } }) => (
  <Layout>
    <SEO
      title={post.frontmatter.title}
      description={post.frontmatter.description || post.excerpt}
    />
    <article>
      <header>
        <h1
          style={{
            marginTop: rhythm(1),
            marginBottom: 0,
          }}
        >
          {post.frontmatter.title}
        </h1>
        <p
          style={{
            ...scale(-1 / 5),
            display: 'block',
            marginBottom: rhythm(1),
          }}
        >
          {post.frontmatter.date}
        </p>
      </header>
      {/* eslint-disable-next-line react/no-danger */}
      <section dangerouslySetInnerHTML={{ __html: post.html }} />
    </article>
    <Utterances
      async
      repo="mthli/blog"
      issueTerm="pathname"
      crossorigin="anonymous"
      theme="github-light"
      style={`
        & .utterances {
          max-width: 100%;
        }
      `}
    />
  </Layout>
)

export default BlogPostTemplate

export const pageQuery = graphql`
  query BlogPostBySlug($slug: String!) {
    markdownRemark(fields: { slug: { eq: $slug } }) {
      id
      excerpt(pruneLength: 160)
      html
      frontmatter {
        title
        date(formatString: "MMMM DD, YYYY")
        description
      }
    }
  }
`
